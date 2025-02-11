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
      
         //Print(__FUNCTION__" PASS");
         
         return true;
      
      }
         
   } else if (MarketDirection == 1) {
   
      if(MovingAverage(MomentumAveragingFast,1) < MovingAverage(MomentumAveragingSlow,0)
      && MovingAverage(TrendAveragingFast,1) < MovingAverage(TrendAveragingSlow,1)){
      
         //Print(__FUNCTION__" PASS");
         
         return true;
      
      }
         
   } else {
   
      //Print(__FUNCTION__" INVALID TREND SETTING");
      
      DiagnosticMessaging("Invalid Moving Average Setting","Unfortunately, you can entered an invalid moving average trend setting. Please gheck the documentaiton published on the Hub of Le Git");      
      
      return false;
   
   }
   
   return false;

}

bool CheckAutomationStatus(){

   bool CheckAutomationStatus = IsTradeAllowed();
   
   if(CheckAutomationStatus){
   
      //Print(__FUNCTION__" PASS");
      
      return true;
   
   }
   
   //Print(__FUNCTION__" FAIL");
   
   return false;

}

// --- Condition Check Function
bool ConditionsCheck(int MarketDirection){

   // -- All bool functions are checked to ensure that each check return true, before returning to the calling programme.
   if(CheckMovingAverage(8,13,21,55,MarketDirection)){
   
      if(CheckAutomationStatus()
      && ExposureCheck()
      && CheckRSquared() 
      && CheckMarketSpread()
      && CheckDebugMode()
      && CheckSuspensionStatus()
      && CheckTradingHours()
      && CheckStandardDeviation()){
      
         return true;
      
      } else {
               
         RunDiagnostics();
         
         return false;
      
      }
      
   }
         
   return false;
   
}