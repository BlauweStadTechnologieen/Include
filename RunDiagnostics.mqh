//+------------------------------------------------------------------+
//|                                               RunDiagnostics.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

#include <GlobalNamespace.mqh>
#include <ConfirmationMessage.mqh>
#include <ExecutionDiagnostics.mqh>

void RunDiagnostics(){
                                                            
   Sleep(1000);
   
   //SendConfirmationEmail(False);
      
   BarTime = Time[0];

   return;

}

void RunDiagnostics(int CandleStar = 3, int EndCandle = 4){
                                                            
   Sleep(1000);
   
   SendMail("Market Order","CandlebodylengthAnalysis function"+string(CandleStar)+" "+string(EndCandle));
      
   BarTime = Time[0];
   
   return;

}