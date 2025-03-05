//+------------------------------------------------------------------+
//|                                                 PricingStats.mqh |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property strict
#include <GlobalNamespace.mqh>
#include <MessagesModule.mqh>
#include <CompanyData.mqh>
#include <ConditionData.mqh>

double AverageBody(int Count){

   if(!ResizeArrays(Count)){
   
      PrintDebugMessage(__FUNCTION__" Error in resizing arrays");
      
      return -1;
   
   }
   
   double sum = 0;
   
   for (int i = 1; i <= Count; i++){
   
      CandleClose[i]        = iClose(Symbol(), 0, i) / Point;
      CandleOpen[i]         = iOpen(Symbol(), 0, i) / Point;
      CandleBody[i]         = NormalizeDouble(MathAbs(CandleClose[i] - CandleOpen[i]), Digits);
      sum                  += CandleBody[i];
      
      Print("Body #"+string(i)+" "+string(CandleBody[i]));
   
   }
   
   double ave =  sum / Count;
   
   Print(__FUNCTION__" Count "+string(Count));
   Print(__FUNCTION__" Sum "+string(sum));
   Print(__FUNCTION__" Average "+string(ave));
      
   return ave;

}

double PricingStats(int Mode){
   
   if(!ResizeArrays(ChartDataPeriods)){
   
      PrintDebugMessage(__FUNCTION__"Resize Error");
      
      return -1;
   
   }
   
   double   SumCandleLengths                 = 0;
   double   SumOfPeriods                     = 0;
   double   RollingAveragePrice              = iMA(NULL, 0, ChartDataPeriods, 0, ENUM_MA_METHOD(ChartDataMAMethod), PRICE_OPEN, 0);
   double   SumTimeMinusAvg                  = 0;
   double   SumPriceMinusAvg                 = 0;
   double   SumTimePriceAverage              = 0;
   //double   SumTimeSquared                   = 0;
   //double   SumTimePriceProduct              = 0;
   double   SumPriceMinusAvgPower             = 0;
   double   SumTimeMinusAvgPower             = 0;
   double   TimeByPeriodSum                  = 0;
   double   AverageCandleBodyLength          = 0;
   double   MarketBid                        = 0;
   double   MarketAsk                        = 0;
            MarketSpread                     = 0;
   
   for (int i = 1; i <= ChartDataPeriods; i++){
   
      TimeByPeriod[i]         = double(ulong(ulong(Time[i])));
      PriceByPeriod[i]        = Open[i];
      TimeByPeriodPower[i]    = MathPow(TimeByPeriod[i],2);
      TimeByPeriodSum        += TimeByPeriod[i];
   
   }
   
   double AverageTimeByPeriod = TimeByPeriodSum / ChartDataPeriods;
   
   for (int i = 1; i <= ChartDataPeriods; i++) {
      
      
      //SumTimeSquared       += TimeByPeriodPower[i];
      //SumTimePriceProduct  += TimeByPeriod[i] * PriceByPeriod[i];
      
      SumTimeMinusAvg         = (TimeByPeriod[i] - AverageTimeByPeriod);
      SumPriceMinusAvg        = (PriceByPeriod[i] - RollingAveragePrice);
      CandleClose[i]          = iClose(Symbol(), 0, i) / Point;
      CandleOpen[i]           = iOpen(Symbol(), 0, i) / Point;
      CandleBody[i]           = NormalizeDouble(MathAbs(CandleClose[i] - CandleOpen[i]), Digits);
      SumCandleLengths       += CandleBody[i];
      SumTimePriceAverage    += (SumTimeMinusAvg * SumPriceMinusAvg);
      SumPriceMinusAvgPower  += MathPow(SumPriceMinusAvg, 2);
      SumTimeMinusAvgPower   += MathPow(SumTimeMinusAvg,2);
   
   }
   
   double sqrtSumTimeMinusAvgPow2   =  sqrt(SumTimeMinusAvgPower/ (ChartDataPeriods - 1));
   double sqrtSumPriceMinusAvgPow2  =  sqrt(SumPriceMinusAvgPower / (ChartDataPeriods - 1));
   double Variance                  =  SumTimePriceAverage / (ChartDataPeriods - 1);
   double CoVariance                =  sqrtSumTimeMinusAvgPow2 * sqrtSumPriceMinusAvgPow2;
   double CorrelationCoefficient    =  NormalizeDouble((Variance / CoVariance),2);
          AverageCandleBodyLength   =  NormalizeDouble((SumCandleLengths  / ChartDataPeriods),0);
          StandardDeviation         =  NormalizeDouble(sqrtSumPriceMinusAvgPow2  / Point,0);
          RSq                       =  NormalizeDouble(MathPow(CorrelationCoefficient,2)*100,0);
          MarketBid                 =  Bid / Point;
          MarketAsk                 =  Ask / Point;
          MarketSpread              =  NormalizeDouble(MathAbs(MarketAsk - MarketBid),0);
   
   switch (Mode){
      
      case 1:
                  
         return StandardDeviation;
         
         break;
         
      case 2:
                  
         return RSq;
         
         break;
      
      case 3:
                  
         return AverageCandleBodyLength;
         
         break;
         
      case 4:
                  
         return MarketSpread;  
         
         break;
          
      default:
         
         return -1;
         
         break;
         
   }

   return Mode;

}
