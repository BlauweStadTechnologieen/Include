//+------------------------------------------------------------------+
//|                                               RunDiagnostics.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

#include <GlobalNamespace.mqh>
#include <ClientData.mqh>
#include <CheckLicence-001.mqh>
#include <FileWrite.mqh>

string FooterNotes = LegalFooterDisclaimer();

void DiagnosticMessaging(string ErrorMessageSubject, string ErrorMessageExplaination){
   
   if(!MessageSent){

      if(GetCurrentErrorCode == 0){
      
         GetCurrentErrorCode = 999999;
         
         Print("You have received a #"+string(GetCurrentErrorCode)+" code because you have either configured the software in a way that goes against certain parameters, or the Error Logging System has failed to reinitialise");
         
      }
            
      Print(ErrorMessageExplaination + " Please quote error #"+string(GetCurrentErrorCode)+" and contact us at "+CompanyEngineeringTicket);
      
      SendMail(ErrorMessageSubject+" (Error #"+string(GetCurrentErrorCode)+") "+HeaderInformation,
      "Dear "+ClientName+
      "\n\n"+ErrorMessageExplaination+
      "\n\nA copy of this message, along with error code "+string(GetCurrentErrorCode)+" has also been sent to the logging console of your Terminal"+
      "\n\n"+CompanyHelpInstructions+
      "\n\n"+FooterNotes);
      
      GetCurrentErrorCode = 0;
      
      ResetLastError(); 
      
      Print("Error code reset to #"+string(GetLastError()));
      
      MessageSent = True;
   
   }
      
   return;
   
}

void PrintDebugMessage(string DebugMessage){

   if(DebugMode == DebugOn){
   
      if(!MessageSent){
         
         Print("Debug Message: "__FUNCTION__+" "+DebugMessage);
         
         MessageSent = True;
      
      }
   
   }
   
   return;

}

int PopupMessaging(string BoxHeader, string MessageText, int Flags){

   return MessageBox(MessageText, BoxHeader+" "+HeaderInformation, Flags);

}

void ObjectNotFoundMessage(string ChartObject){

   DiagnosticMessaging("Object Error ("+string(GetCurrentErrorCode)+") "+HeaderInformation,"Unfortunately, the the chart object "+ChartObject+" has not been found. Please check this again.");
   
   return;

}