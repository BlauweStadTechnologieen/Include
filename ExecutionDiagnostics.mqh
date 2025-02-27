//+------------------------------------------------------------------+
//|                                       diagnostics_hammertime.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict
#include <GlobalNamespace.mqh>
#include <ScreenshotCapture.mqh>
#include <ChartData.mqh>
#include <ConditionData.mqh>
#include <FunctionsModule.mqh>

string ExecutionDiagnostics(int CandleStar, int EndCandle){
      
   string Pass = "PASS";
   string Fail = "FAIL";
   
   string diagnostics   = 
      "\n=============================================="+
      "\nUser Settings"+
      "\n=============================================="+
      "\n"+
      "\nStandard Deviation Range Setting: "+string(MinimumStandardDeviation)+" / "+string(MaximumStandardDeviation)+
      "\n"+
      "\nR-Squared Range Setting: "+string(minRSquared)+"% / "+string(maxRSquared)+"%"+
      "\n"+
      "\nMax Spread Setting: "+string(MaximumSpread)+" pips"+
      "\n"+
      "\nStar Candle Body Length: "+string(minimumHammerBody)+" pips"+
      "\n"+
      "\nTrading Hours Setting: "+string(startingHour)+":00 to "+string(endingHour)+":00 Local"+
      "\n"+
      "\n=============================================="+
      "\nCondition Data"+
      "\n=============================================="+
      "\n"+
      "\nStandard Deviation: "+(CheckStandardDeviation() ? Pass : Fail)+
      "\n"+
      "\nExposure: "+(ExposureCheck() ? Pass : Fail)+
      "\n"+
      "\nR-Squared: "+(CheckRSquared() ? Pass : Fail)+
      "\n"+ 
      "\nMarket Spread: "+(CheckMarketSpread() ? Pass : Fail)+
      "\n"+
      "\nDebug Mode Off: "+(CheckDebugMode() ? Pass : Fail)+
      "\n"+
      "\nSuspension Status: "+(CheckSuspensionStatus() ? Pass : Fail)+
      "\n"+
      "\nMinimum Candle Body Length: "+string(CandleBodyLength)+
      "\n"+
      "\nTrading Hours: "+(CheckTradingHours() ? Pass : Fail)+
      "\n"+
      "\nAutomation Status "+(CheckAutomationStatus() ? Pass : Fail)+
      "\n"+
      "\nCandle Body Length "+(CandleBodyLengthAnalysis(CandleStar, EndCandle) ? Pass : Fail)+
      "\n"+
      "\n==============================================";      

   return diagnostics;

}