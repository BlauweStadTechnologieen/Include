//+------------------------------------------------------------------+
//|                                                ConditionData.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict
#include <GlobalNamespace.mqh>
#include <RunDiagnostics.mqh> 
#include <FunctionsModule.mqh> 
#include <ChartData.mqh> 
#include <RunMarketExecution.mqh>

double MovingAverage(int AveragingPeriod, int  AveragingMethod){

   double ma = iMA(NULL,0,AveragingPeriod,0,AveragingMethod,0,1);
   
   return ma;

}

//--- Data Structures
struct MarketConditions{

   double   StandardDeviation;
   double   RSquared;
   double   MarketBid;
   double   MarketAsk;
   double   MarketSpread;

};

struct ExposureConditions{

   int      PositionsTotal;
   double   _AccountEquity;

};

struct UserConditions{

   double   _MarginRequired ;
   
};

bool CheckStandardDeviation(){

   MarketConditions Market;
   
   Market.StandardDeviation = StDev;
   
   if(Market.StandardDeviation >= (double)MinimumStandardDeviation && Market.StandardDeviation <= (double)MaximumStandardDeviation){
   
      //Print(__FUNCTION__ " PASS");
      
      return true;
   
   } 
   
   //Print(__FUNCTION__ " FAIL");
   
   return false;

}

bool CheckRSquared(){

   MarketConditions Market;
   
   Market.RSquared = RSq;
   
   if(Market.RSquared >= (double)minRSquared && Market.RSquared <= (double)maxRSquared){
   
      //Print(__FUNCTION__" PASS");
      
      return true;
   
   } 
   
   //Print(__FUNCTION__" FAIL");
   
   return false;

}

bool ExposureCheck(){

   ExposureConditions Exposure;
   UserConditions UserSettings;
   
            Exposure._AccountEquity          = AccountEquity();
            UserSettings._MarginRequired     = MarketInfo(Symbol(),MODE_MARGINREQUIRED) * LotSize;
   double   PositionMarginLevelCheck         = Exposure._AccountEquity / UserSettings._MarginRequired * 100;
            Exposure.PositionsTotal          = OrdersTotal();
   
   if(PositionMarginLevelCheck > brokerMarginLevel
   && Exposure.PositionsTotal < 1){
   
      //Print(__FUNCTION__" PASS");
      
      return true;
   
   }
   
   //Print(__FUNCTION__" FAIL");
   
   return false;

}

bool CheckMarketSpread(){

   MarketConditions Market;
   
   Market.MarketBid     = Bid;
   Market.MarketAsk     = Ask;
   Market.MarketSpread  = NormalizeDouble((Market.MarketAsk - Market.MarketBid)/_Point,0);
   
   if(Market.MarketSpread <= (double)MaximumSpread){
   
      //Print(__FUNCTION__" PASS");
      
      return true;
   
   }
   
   //Print(__FUNCTION__" FAIL");
   
   return false;

}

bool CheckDebugMode(){

   if(DebugMode == DebugOff){
   
      //Print(__FUNCTION__" PASS");
      
      return true;
   
   }
   
   //Print(__FUNCTION__" FAIL");
   
   return false;

}

bool CheckSuspensionStatus(){

   if(TempSuspension != TemporarySuspension && NoTradeReason == NoSuspension){
   
      //Print(__FUNCTION__" PASS");
      
      return true;
   
   }
   
   //Print(__FUNCTION__" FAIL");
   
   return false;

}

bool CheckTradingHours(){

   MqlDateTime timeLocStruct;
   TimeToStruct(TimeLocal(), timeLocStruct);
   
   if(timeLocStruct.hour >= startingHour && timeLocStruct.hour < endingHour){
   
      //Print(__FUNCTION__" PASS");
      
      return true;
   
   }
   
   //Print(__FUNCTION__" FAIL");
   
   return false;

}

bool CheckMovingAverage(int MomentumAveragingFast, int MomentumAveragingSlow, int TrendAveragingFast, int TrendAveragingSlow, int MarketDirection){
   
   if(MarketDirection == 0){
   
      if(MovingAverage(MomentumAveragingFast,1) > MovingAverage(MomentumAveragingSlow,0)
      && MovingAverage(TrendAveragingFast,1) > MovingAverage(TrendAveragingSlow,1)){
      
         return true;
      
      }
      
      return false;
         
   } else if (MarketDirection == 1) {
   
      if(MovingAverage(MomentumAveragingFast,1) < MovingAverage(MomentumAveragingSlow,0)
      && MovingAverage(TrendAveragingFast,1) < MovingAverage(TrendAveragingSlow,1)){
         
         return true;
      
      }
      
      return false;
         
   } 
   
   DiagnosticMessaging("Invalid Moving Average Setting","Unfortunately, you can entered an invalid moving average trend setting. Please gheck the documentaiton published on the Hub of Le Git");      
   
   return false;

}

bool CheckAutomationStatus(){

   bool CheckAutomationStatus = IsTradeAllowed();
   
   if(CheckAutomationStatus){
   
      return true;
   
   }
   
   return false;

}


bool CandleBodyLengthAnalysis(int CandleStar, int EndCandle, int CommencementCandle){
   
   CandleBodyLength = 0;
   
   if(AverageCandleBodyLength() >= (double)VolatilityCandleBodyLength){
   
      CandleBodyLength = AverageCandleBodyLength();
      
      //Print(__FUNCTION__" ComparisonCandleBodyLength "+string(CandleBodyLength));
   
   } else {
   
      CandleBodyLength = (double)VolatilityCandleBodyLength;
      
      //Print(__FUNCTION__" ComparisonCandleBodyLength  "+string(CandleBodyLength));
   
   }
   
   double   CandleBody[];
   double   CandleOpen[];
   double   CandleClose[];
   
   if (!ArrayResize(CandleOpen, EndCandle + 1) ||
    
      !ArrayResize(CandleClose, EndCandle + 1) ||
       
      !ArrayResize(CandleBody, EndCandle + 1)){
      
         DiagnosticMessaging("Array Error","Unfortunately, there was an error in resizing your arrays within the function "__FUNCTION__);
      
         return false;
         
   }
   
   //Print(__FUNCTION__ + " - EndCandle is " + string(EndCandle));
   //Print(__FUNCTION__+string(CandleStar)+" "+string(EndCandle)+" "+string(CommencementCandle));
   //Print(__FUNCTION__+"End Candle is "+string(EndCandle));
   
   for(int i = 0; i <= EndCandle; i++){
         
      if(DebugMode == DebugOn){
      
         Print(__FUNCTION__ + " Loop iteration i = " + string(i));
      
      }
      
      CandleOpen[i]   = iOpen(CurrentChartSymbol, 0, i) / _Point;
        
      CandleClose[i]  = iClose(CurrentChartSymbol, 0, i) / _Point;
        
      CandleBody[i]   = NormalizeDouble(MathAbs(CandleClose[i] - CandleOpen[i]), Digits);
 
      //Print(__FUNCTION__"Candle "+string(i)+" has a body of "+string(CandleBody[i])+" Avg Len "+string(CandleBodyLength));
      
      if (CandleBody[i] == CandleBody[1]){
      
         if(CurrencyPairInVolatileList()){ 
         
            if(CandleBody[1] < (double)minimumHammerBody){
                                          
               //Print(__FUNCTION__," First Candle Failed #"+string(i));
        
               return false;
            
            } 
         
         } else {
         
            continue;
         
         }
      
      }
      
      if(i == CandleStar){
                           
         if(CandleBody[CandleStar] < (double)minimumHammerBody){
            
            //Print(__FUNCTION__," Candle Star Fail #"+string(i)+" "+string(CandleBody[CandleStar]));
                        
            return false;
      
         } 
         
         continue;
         
      }
            
      if(CandleBody[i] == CandleBody[0])
         
         continue; 
      
      if(CandleBody[i] < CandleBodyLength){
                  
         //Print(__FUNCTION__," Candle Body Length #"+string(i));
                  
         return false;
      
      } 
   
   }

///Print(__FUNCTION__" Passed");

return true;

}

// --- Condition Check Function
bool ConditionsCheck(int MarketDirection, int CandleStar, int EndCandle, int CommencementCandle){

   // -- All bool functions are checked to ensure that each check return true, before returning to the calling programme.
   if(CheckMovingAverage(8,13,21,55,MarketDirection)){
   
      if(CheckAutomationStatus()
      && ExposureCheck()
      && CheckRSquared() 
      && CheckMarketSpread()
      && CheckDebugMode()
      && CheckSuspensionStatus()
      && CheckTradingHours()
      && CheckStandardDeviation()
      && CandleBodyLengthAnalysis(CandleStar, EndCandle, CommencementCandle)){
         
         if(!ExecuteMarketOrder(MarketDirection, CandleStar, EndCandle, CommencementCandle)){
         
            return false;
         
         }

         return true;
      
      } 
               
      SendConfirmationEmail(False, CandleStar, EndCandle, CommencementCandle);
      
      BarTime = Time[0];
            
   }
   
   return false;
            
}