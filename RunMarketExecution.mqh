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
#include <EmailLegalDisclaimer.mqh>

//+------------------------------------------------------------------+
//|This module will run the market(spot)execution module, and will
//| return either a successful execution or a failed execution.                                                             |
//+------------------------------------------------------------------+

bool ExecuteMarketOrder(int OrderProperty, int CandleStar, int EndCandle){

   double StopLossPrice     =  NormalizeDouble((StopLoss * Point),Digits);
   double TakeProfitPrice   =  NormalizeDouble(((StopLoss * RewardFactor) * Point),Digits);
   double EstimatedProfit   =  NormalizeDouble(((TakeProfitPrice / _Point) * LotSize)/LocalExchangeRate,2);  
   
   //---
   //This will verify as to whether the OrderProperty is valid.
   //if the OrderProperty is NOT valid, then an error message will be sent. See below.
   if(OrderProperty <= 5){
   
      double PriceProperty = 0;
      double MarketOrderStopLoss = 0;
      double MarketOrderTakeProfit = 0;
      //---
      //This will take care of all Market Orders.
      //This will return an eaCode of 1
      if(OrderProperty <= 1){ 
       
         if(OrderProperty == 0){
         
            //If the OrderProperty is set to 0, the following variables will be calculated and instantiated into the OrderSend() statement)
            PriceProperty           =  Ask;
            MarketOrderStopLoss     =  Ask - StopLossPrice;
            MarketOrderTakeProfit   =  Ask + TakeProfitPrice;
            WebColors               =  clrGreen;
            //---

         } else if (OrderProperty == 1){
         
            //---
            //If the OrderProperty is set to 1, the following variables will be calculated and instantiated into the OrderSend() statement)
            PriceProperty           =  Bid;
            MarketOrderStopLoss     =  Bid + StopLossPrice;
            MarketOrderTakeProfit   =  Bid - TakeProfitPrice;
            WebColors               =  clrCyan;
            //---
            
         }
         
         Expires = 0;
         
      }   
      //---

      //---
      //This will take care of all Pending Orders.
      //This will return an eaCode of 4
      if(OrderProperty >= 2){
      
      CurrentBarOpenPrice = Open[0];
      
         //---
         //This will take care of either the BUY_LIMIT or the BUY_STOP order.
         if(OrderProperty == 2 || OrderProperty == 4){
         //---
         
            PriceProperty           =  CurrentBarOpenPrice;
            MarketOrderStopLoss     =  CurrentBarOpenPrice - StopLossPrice; 
            MarketOrderTakeProfit   =  CurrentBarOpenPrice + TakeProfitPrice;
            WebColors               =  clrCornflowerBlue; 
         
         //---
         //This will take care of either the SELL_STOP or the SELL_LIMIT order
         } else if (OrderProperty == 3 || OrderProperty == 5) {
         
            PriceProperty           =  CurrentBarOpenPrice;
            MarketOrderStopLoss     =  CurrentBarOpenPrice + StopLossPrice; 
            MarketOrderTakeProfit   =  CurrentBarOpenPrice - TakeProfitPrice;
            WebColors               =  clrLightSeaGreen;
            
         }
         //---

         Expires = CandleOpenTime + PendingExpiration;
      
      } 
      
      Print("Estimated profit ",CurrencyForAccount+string(EstimatedProfit));
      
      //---
      //As long as the OrderProperty is less than or equal to 5 (the maximum number of order types), an order will attempted to be sent to te broker.
      if(!OrderSend(CurrentChartSymbol,OrderProperty,LotSize,PriceProperty,100,MarketOrderStopLoss,MarketOrderTakeProfit,StringSubstr(EnumToString((ENUM_ENTITY)Group_Entity),0),int(UniqueChartIdentifier),Expires,WebColors)){
      
         #ifdef __SLEEP_AFTER_EXECUTION_FAIL
               
            Sleep(__SLEEP_AFTER_EXECUTION_FAIL);
               
         #endif 
         
         DiagnosticMessaging("Order Execution Failure","Your broker has made an attempt to place an order. Unfortunately this was unsuccessful");
                  
         return false;
      
      } 
               
      if(DebugMode == DebugOff){
      
         ChartButtonStaticAttributes();
                                          
      } 
      
      BarTime = Time[0];
                
      SendConfirmationEmail(True, CandleStar, EndCandle);
      
      return true;
      
   } else {
   
      // --- If the OrderProperty cannot be deteramined, then an error message will be sent, returning an error code.
      DiagnosticMessaging("Order Execution Error","The type of order could not be determined. Please confirm you have ordered a compliant order type.");
      
      return false;
   
   }   

   return false;

}