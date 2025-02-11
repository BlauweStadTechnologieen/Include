//+------------------------------------------------------------------+
//|                                              OnTickVariables.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict
#include <GlobalNamespace.mqh>

void OnTickVariables(){

   //+------------------------------------------------------------------+
   //|string                                                                 
   //+------------------------------------------------------------------+
   ExecutionSymbol         =  OrderSymbol();
   EAName                  =  WindowExpertName();
   //+------------------------------------------------------------------+
   //|double                                                               
   //+------------------------------------------------------------------+
   SpotAsk                 =  Ask;
   SpotBid                 =  Bid;
   MarketSpread            =  NormalizeDouble((Ask - Bid)/_Point,0);
   TickValue               =  MarketInfo(CurrentChartSymbol,MODE_TICKVALUE);
   LocalExchangeRate       =  NormalizeDouble(1/TickValue,_Digits);
   PositonTickValue        =  TickValue * LotSize;
   CurrentBarOpenPrice     =  iOpen(Symbol(),0,0);
   PositionGrossProfit     =  OrderProfit();
   PositionNetProfit       =  PositionGrossProfit - _OrderSwap;
   CurrentFreeMargin       =  AccountFreeMargin();
   RemainingMargin         =  CurrentFreeMargin - OrderMarginRequirement;
   _AccountEquity          =  AccountEquity();
   AverageCandleBodyLen    =  0;  
   AverageCandleRangeLen   =  0; 
   //+------------------------------------------------------------------+
   //|int                                                               
   //+------------------------------------------------------------------+
   _OrderMagicNumber       =  OrderMagicNumber();
   MarginBuffer            =  1000;
   //+------------------------------------------------------------------+
   //|datetime                                                                
   //+------------------------------------------------------------------+
   _TimeCurrent            =  TimeCurrent();
   
   return;

}

