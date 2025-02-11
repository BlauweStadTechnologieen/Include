#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"

#include <GlobalNamespace.mqh>
#include <MessagesModule.mqh>

void ChartButtonFluidAttributes(color ProfitColor, color LossColor, color ButtonUnavailable){
      
      ObjectMove(ChartID_PipDisplayFluid,0,Time[1],Ask);
            
      //---
      //Asessing the order type
      if(DebugMode == DebugOff){
      
         if(OrderType() == OP_BUY){
         
            PipPerformance = NormalizeDouble((SpotAsk - _OrderOpenPrice)/Point,Digits);
            
         } else if (OrderType() == OP_SELL){
         
            PipPerformance = NormalizeDouble((_OrderOpenPrice - SpotBid)/Point,Digits);
         
         } 
              
      } else {
      
         PositionNetProfit = 1365.32;
         _OrderTicket      = 12345678;
         PipPerformance    = NormalizeDouble(Bid / _Point,Digits);
      
      }
      
      ObjectSetString(UniqueChartIdentifier,ChartID_SpreadDisplay, OBJPROP_TEXT,"Running spread "+string(MarketSpread));
      ObjectSetString(UniqueChartIdentifier,ChartID_CloseButton, OBJPROP_TEXT,"Close Ticket #"+string(_OrderTicket)+" with a "+(PositionNetProfit > 0.01 ? "profit" : "loss")+" of "+_AccountCurrency+DoubleToString(PositionNetProfit,2));

      //---
      //Pip performance comparison to stop level
      if(PipPerformance >= broker_stop_level){
         
         ObjectSetInteger(UniqueChartIdentifier,ChartID_Breakeven, OBJPROP_BGCOLOR,ProfitColor); 
      
      } else {
      
         ObjectSetInteger(UniqueChartIdentifier,ChartID_Breakeven, OBJPROP_BGCOLOR,ButtonUnavailable);  
      
      }
      //---
      
      if(PositionNetProfit >= 0.01){
      
         //---
         //ChartID_PipDisplayFluid
         ObjectSetText(ChartID_PipDisplayFluid,Symbol()+" +"+string(PipPerformance));
         ObjectSetInteger(UniqueChartIdentifier,ChartID_PipDisplayFluid, OBJPROP_COLOR,ProfitColor);
         //---
         
         //---
         //ChartID_CloseButton
         ObjectSetInteger(UniqueChartIdentifier,ChartID_CloseButton, OBJPROP_BGCOLOR, ProfitColor);
         //---
         
         //---
         //ChartID_SpreadDisplay
         ObjectSetInteger(UniqueChartIdentifier,ChartID_SpreadDisplay, OBJPROP_COLOR,ProfitColor);
         //---
         
         //---
         //ChartID_PipDisplayStatic
         ObjectSetString(UniqueChartIdentifier,ChartID_PipDisplayStatic, OBJPROP_TEXT,Symbol()+" +"+string(PipPerformance));
         ObjectSetInteger(UniqueChartIdentifier,ChartID_PipDisplayStatic, OBJPROP_COLOR,ProfitColor);
         //---
      
      } else {
      
         //---
         //ChartID_PipDisplayFluid
         ObjectSetText(ChartID_PipDisplayFluid,Symbol()+" -"+string(PipPerformance));
         ObjectSetInteger(UniqueChartIdentifier,ChartID_PipDisplayFluid, OBJPROP_COLOR,LossColor);
         //---
         
         //---
         //ChartID_CloseButton
         ObjectSetInteger(UniqueChartIdentifier,ChartID_CloseButton, OBJPROP_BGCOLOR,LossColor);
         //---
         
         //---
         //ChartID_SpreadDisplay
         ObjectSetInteger(UniqueChartIdentifier,ChartID_SpreadDisplay, OBJPROP_COLOR,LossColor);
         //---
         
         //---
         //ChartID_PipDisplayStatic
         ObjectSetString(UniqueChartIdentifier,ChartID_PipDisplayStatic, OBJPROP_TEXT,Symbol()+" "+string(PipPerformance));
         ObjectSetInteger(UniqueChartIdentifier,ChartID_PipDisplayStatic, OBJPROP_COLOR,LossColor);
         //---
         
      }
      //
      //---
  
}
      



