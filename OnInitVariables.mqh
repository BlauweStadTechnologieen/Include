//+------------------------------------------------------------------+
//|                                              OnTickVariables.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict
#include <GlobalNamespace.mqh>

void OnInitVariables(){

   MessageSent       = False;
   LocalExchangeRate = 1;
   BarTime           = Time[0];
   
   if(DebugMode == DebugOn){
   
      PositionsHistoryTotal = 0;
   
   } else {
   
      PositionsHistoryTotal = OrdersHistoryTotal();
   
   }
   
   return;
   
}
