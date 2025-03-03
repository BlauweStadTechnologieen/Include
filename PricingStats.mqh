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

double PricingStats(int Mode){
   
   ResizeArrays(ChartDataPeriods);
   
   double   SumCandleLengths                 = 0;
   double   SumOfPeriods                     = 0;
   double   RollingAveragePrice              = iMA(NULL, 0, ChartDataPeriods, 0, ENUM_MA_METHOD(ChartDataMAMethod), PRICE_OPEN, 0);
   double   SumTimeMinusAvg                  = 0;
   double   SumPriceMinusAvg                 = 0;
   double   SumTimePriceAverage              = 0;
   double   SumTimeSquared                   = 0;
   double   SumTimePriceProduct              = 0;
   double   SumPriceMinusAvgPow2             = 0;
   double   SumTimeMinusAvgPow2              = 0;
   double   TimeByPeriodSum                  = 0;
   double   AverageCandleBodyLength          = 0;
   double   MarketBid                        = 0;
   double   MarketAsk                        = 0;
            MarketSpread                     = 0;
   
   for (int i = 0; i < ChartDataPeriods; i++){
   
      TimeByPeriod[i]         = double(ulong(ulong(Time[i])));
      PriceByPeriod[i]        = Open[i];
      TimeByPeriodPower[i]    = MathPow(TimeByPeriod[i],2);
      TimeByPeriodSum        += TimeByPeriod[i];
   
   }
   
   double AverageTimeByPeriod = TimeByPeriodSum / ChartDataPeriods;
   
   for (int i = 0; i < ChartDataPeriods; i++) {
      
      SumTimeMinusAvg      += (TimeByPeriod[i] - AverageTimeByPeriod);
      SumPriceMinusAvg     += (PriceByPeriod[i] - RollingAveragePrice);
      SumTimePriceAverage  += (TimeByPeriod[i] - AverageTimeByPeriod) * (PriceByPeriod[i] - RollingAveragePrice);
      SumTimeSquared       += TimeByPeriodPower[i];
      SumTimePriceProduct  += TimeByPeriod[i] * PriceByPeriod[i];
      SumPriceMinusAvgPow2 += MathPow(PriceByPeriod[i] - RollingAveragePrice, 2);
      SumTimeMinusAvgPow2  += MathPow(TimeByPeriod[i] - AverageTimeByPeriod,2);
      CandleClose[i]        = iClose(Symbol(), 0, i) / Point;
      CandleOpen[i]         = iOpen(Symbol(), 0, i) / Point;
      CandleBody[i]         = NormalizeDouble(MathAbs(CandleClose[i] - CandleOpen[i]), Digits);
      SumCandleLengths     += CandleBody[i];
   
   }
   
   double sqrtSumTimeMinusAvgPow2   =  sqrt(SumTimeMinusAvgPow2 / (ChartDataPeriods - 1));
   double sqrtSumPriceMinusAvgPow2  =  sqrt(SumPriceMinusAvgPow2 / (ChartDataPeriods - 1));
   double Variance                  =  SumTimePriceAverage / (ChartDataPeriods - 1);
   double CoVariance                =  (sqrtSumTimeMinusAvgPow2 * sqrtSumPriceMinusAvgPow2);
   double CorrelationCoefficient    =  NormalizeDouble((Variance / CoVariance),2);
          AverageCandleBodyLength   =  NormalizeDouble((SumCandleLengths  / ChartDataPeriods),0);
          StandardDeviation         =  NormalizeDouble(sqrtSumPriceMinusAvgPow2  / Point,0);
          RSq                       =  NormalizeDouble(MathPow(CorrelationCoefficient,2)*100,0);
          MarketBid                 =  Bid;
          MarketAsk                 =  Ask;
          MarketSpread              =  MathAbs(MarketAsk - MarketBid);
   
   switch (Mode){
      case 1:
         Print(__FUNCTION__" Standard Deviation "+string(StandardDeviation));
         return StandardDeviation;
         break;
      case 2:
         Print(__FUNCTION__" RSQ "+string(RSq));
         return RSq;
         break;
      case 3:
         Print(__FUNCTION__" Ave Candle Body Length "+string(AverageCandleBodyLength));
         return AverageCandleBodyLength;
         break;
      case 4:
         Print(__FUNCTION__"Market Spread "+string(MarketSpread));
         return MarketSpread;   
      default:
         return -1;
         break;
   }

   return Mode;

}
