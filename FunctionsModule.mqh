//+------------------------------------------------------------------+
//|                                              FunctionsModule.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict
#include <MessagesModule.mqh>
#include <GlobalNamespace.mqh>
#include <ConfirmationMessage.mqh>

double OrderTransactionCost(double &TransactionCostItem[], int NumberOfItems){

   double ExecutionCost = 0;
      
   for(int i = 0; i < NumberOfItems; i++){
   
      ExecutionCost += TransactionCostItem[i];
   
   }

   return ExecutionCost;

}

void VariableInitialization(){

   MessageSent             =  False;
   BarTime                 =  Time[0];

   return;

}

void DislayServerTime(){

   string TimeWithMinutes = TimeToStr(TimeLocal(),TIME_DATE | TIME_SECONDS);
   
   Comment(TimeWithMinutes);

}

void ErrorReset(){

   ResetLastError();
   Print("Resetting Error Logging Systems...");
   GetLastError();
   GetCurrentErrorCode = 0;
   
   if(GetLastError()  != 0){
   
      DiagnosticMessaging("Error Logging Systems Not Reset","There was an error in resetting the logging system on system initialisation.\n\nThe last error code still remained at "+string(GetLastError())+" The error logging system should not be reset");
      
   } else {
   
      Print("Error Logging Systems Successfully Reset");
         
   }

}

int FileNameIDGenerator(int LowerBand, int UpperBand){

   MathSrand(GetTickCount());
   
   return LowerBand + MathRand() % (UpperBand - LowerBand + 1);

}

void DeletePositionCartObjects(){
      
   ObjectDelete(ChartID_CloseButton); 
   ObjectDelete(ChartID_Breakeven);
   ObjectDelete(ChartID_ModifyTakeProfit);
   ObjectDelete(ChartID_PipDisplayFluid); 
   ObjectDelete(ChartID_PipDisplayStatic); 
   ObjectDelete(ChartID_SpreadDisplay);

   return;

}

void ChartIDExtTest(){

   Print("Your Unique Chart Identifier - sourced externally - is ",UniqueChartIdentifier);

}

void DeletePairSupensionNotice(){

   ObjectDelete(ChartID_Suspension);

}

void PrintTransactionEvent(string LoggingMessage){

   if (DebugMode == DebugOn){
   
      if(!MessageSent){
      
         Print(LoggingMessage);
         
         MessageSent = True;
      
      }
   
   }
   
   return;
   
}

void PrintDebugMessage(string DebugMessage){

   if(DebugMode == DebugOn){
   
      if(!MessageSent){
         
         Print("Debug Message: "+DebugMessage);
         
         MessageSent = True;
      
      }
   
   }
   
   return;

}

void LiveDebugMessage(string DebugMessage){

   if(!MessageSent){
   
      Print("Live Debug Message: "+DebugMessage+" Reinitialise System Now.");
   
      MessageSent = True;
   
   }
   
   return;

}

bool CurrencyPairInVolatileList(){

   int   JPYPresent     =  StringFind(CurrentChartSymbol,"JPY",0);
   int   EURAUDPresent  =  StringFind(CurrentChartSymbol,"EURAUD",0);
   int   GBPAUDPresent  =  StringFind(CurrentChartSymbol,"GBPAUD",0);

   if(JPYPresent >= 0 || GBPAUDPresent >= 0 || EURAUDPresent >= 0){
   
      return true;
   
   }
   
   return false;

}



int GetDebugMode(){

   if(DebugMode == DebugOn){  
            
      Print("Generating UCID from OnInit()...");
      Print("Your UCID is "+string(UniqueChartIdentifier));
      
      Print("Now testing averaging candle body lengths....");
      CandleBodyLengthAnalysis(PrimaryStar, PrimaryEnd);
           
      int ExecuteTestRun = PopupMessaging("Initiate a Test Run","Greetings Grasshopper!\n\nWould you like to initiate test trading position?",MB_YESNO | MB_ICONQUESTION);
      
      if(ExecuteTestRun == 6){
      
         // --- If you accept the INITIAL test run confirmation, it will check to ensure that this is a DEMO account
         if(AccountInfoInteger(ACCOUNT_TRADE_MODE) == ACCOUNT_TRADE_MODE_DEMO){
         
            int FinalExecuteTestRunConfirmation = PopupMessaging("Initiating Test Run...","Please confirm that you would like to initiate a test position.",MB_YESNO | MB_ICONWARNING);
         
               if (FinalExecuteTestRunConfirmation == 6){
               
                  // --- If you accept the FINAL confirmation, a test run will execute, complete with confirmation email.
                  ExecuteMarketOrder(1,3,4);
                  // ---
         
               } else {
              
                  Print ("Cancelled final confirmation");
               
               }
      
         } else {
         
            PopupMessaging("Invalid Account Mode","This feature is compatable only with DEMO accounts. Please switch to a DEMO account before sending a test positon to your broker.", MB_OK | MB_ICONSTOP);
                  
         }
   
      } else {
      
         Print("You have cancelled the initial test run");
               
      }
      
      TransactionMessage("Platform Set to Test Mode","You have set the platform to DEBUG mode. If this was intentional, you can disregard this message.");
      
      ChartButtonStaticAttributes();
   
   } else {
   
      //---
      //This is the Product Licence Key, not the CustomerNumber
      if(!ValidLicence(ProductLicenceKey)) return(INIT_FAILED);
      //--- 
      
      if(PositionsTotal > 0){
      
         for(int i = PositionsTotal - 1; i >= 0; i--){
         
            if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)){
               
               if(_OrderMagicNumber == UniqueChartIdentifier){
               
                  ChartButtonStaticAttributes();
               
               } else {
               
                  continue;
               
               }
            
            } else {
            
               DiagnosticMessaging("Order Selection Error OnInit","During the initialization of the system, there was an error in selecting the order(s) from the ledger");
               
               break;
            
            }
         
         }
      
      } else {
      
         DeletePositionCartObjects();
      
      }
   
   }
   
   return (INIT_SUCCEEDED);
   
}