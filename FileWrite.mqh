#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"

#include <GlobalNamespace.mqh>
#include <ScreenshotCapture.mqh>
#include <PricingStats.mqh>  

void WriteFile(string FileName){
                           
   if(!FileIsExist(FileName+".csv", FILE_COMMON)){
   
      FileHandle = FileOpen(FileName+".csv",FILE_COMMON | FILE_WRITE,',');
      
      if (FileHandle == INVALID_HANDLE) {
      
         DiagnosticMessaging("FileOpen Error", "Failed to create file: " + FileName);
         
         return;
      }
      
      FileWrite(FileHandle,
      "Symbol",
      "Order Ticket #",
      "Market Entry Price",
      "Market Exit Price",
      "Cost of Revenue (Swap Charge)",
      "Cost of Revenue (Commission Charge)",
      "Revenue",
      "Gross Profit"); 
   
   } else {
   
      FileHandle = FileOpen(FileName + ".csv", FILE_COMMON | FILE_READ | FILE_WRITE, ',');
      
      
      if (FileHandle == INVALID_HANDLE) {
      
         DiagnosticMessaging("FileOpen Error", "Failed to open file: " + FileName);
         
         return;
         
      }
      
      FileSeek(FileHandle, 0, SEEK_END);
   
   }
   
   double _OrderProfit = OrderProfit();
   
   FileWrite(FileHandle,
   _OrderSymbol,
   DoubleToString(NormalizeDouble(_OrderTicket,0),0),
   DoubleToString(NormalizeDouble(_OrderOpenPrice,Digits),Digits),
   DoubleToString(NormalizeDouble(_OrderTakeProfit,Digits),Digits),
   DoubleToString(NormalizeDouble(_OrderSwap,2),2),
   DoubleToString(NormalizeDouble(_OrderCommission,2),2),
   DoubleToString(NormalizeDouble(_OrderProfit,2),2),
   DoubleToString(NormalizeDouble(_OrderProfit + _OrderCommission + _OrderSwap,2),2)); 
   
   FileClose(FileHandle);
   
   Print(FileName);
   Print("File Entry Written for #", string(_OrderTicket));
   
   if (FileHandle == INVALID_HANDLE) {
   
      DiagnosticMessaging("FileWrite Error", "There was an error in writing the file entry for the order " + string(_OrderTicket));
   
   }

   return;

}

void RecordUnexecutedPositions(string FileName, string ChartCaptureName, int UniqueID){
                           
   if(!FileIsExist(FileName+".csv", FILE_COMMON)){
   
      FileHandle = FileOpen(FileName+".csv", FILE_COMMON | FILE_WRITE, ',');
      
      if (FileHandle == INVALID_HANDLE) {
      
         DiagnosticMessaging("FileOpen Error", "Failed to create file: " + FileName);
         
         return;
      }
      
      FileWrite(FileHandle,
      "UniqueID",
      "Symbol",
      "R-Squared",
      "Standard Deviation",
      "Average Body Length",
      "Market Spread",
      "Chart Snapshot"); 
   
   } else {
   
      FileHandle = FileOpen(FileName + ".csv", FILE_COMMON | FILE_READ | FILE_WRITE, ',');
      
      if (FileHandle == INVALID_HANDLE) {
      
         DiagnosticMessaging("FileOpen Error", "Failed to open file: " + FileName);
         
         return;
         
      }
      
      FileSeek(FileHandle, 0, SEEK_END);
   
   }
   
            StandardDeviation = PricingStats(1);
            RSq               = PricingStats(2);
   double   AveBodyLength     = PricingStats(3); 
            MarketSpread      = PricingStats(4);
               
   FileWrite(FileHandle,
   UniqueID,
   CurrentChartSymbol,
   RSq,
   StandardDeviation,
   AveBodyLength,
   MarketSpread,
   ChartCaptureName); 
   
   FileClose(FileHandle);
   
   Print(FileName);
   Print("File Entry Written for #", string(UniqueID));
   
   if (FileHandle == INVALID_HANDLE) {
   
      DiagnosticMessaging("FileWrite Error", "There was an error in writing the file entry for the order " + string(_OrderTicket));
   
   }

   return;

}