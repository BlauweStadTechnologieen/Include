//+------------------------------------------------------------------+
//|                                          ConfirmationMessage.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict


#include <GlobalNamespace.mqh>
#include <ScreenshotCapture.mqh>
#include <ExecutionDiagnostics.mqh>
#include <BrokerData.mqh>
#include <CompanyData.mqh>
#include <FunctionsModule.mqh>
#include <ChartButtonStaticAttrs.mqh>

void SendConfirmationEmail(bool ParamsMet, int CandleStar, int EndCandle, int CommencementCandle){

   bool     SelectOrder                         =  OrderSelect(PositionsTotal-1,SELECT_BY_POS, MODE_TRADES);
   string   ParamDiagnostics                    =  ExecutionDiagnostics(CandleStar, EndCandle, CommencementCandle);
   string   ConfirmationOrderProperty           =  "Market Order";
   string   FooterNotesForConformationMessage   =  LegalFooterDisclaimer();
      
   if (!ParamsMet){
      ConfimationEmailCostData  =  "As no order was sent to the broker, cost data is not available.";
      CaptureFileNameId         =  FileNameIDGenerator(80000000,89999999);
      ChartURL                  =  ScreenShotCaptureURL(CaptureFileNameId);
      ConfimationEmailGreeting  =  "A "+ConfirmationOrderProperty+" would have been placed with your broker on the "+CurrentChartSymbol+" "+string(ExecutionTimeframe)+"H Chart. However one or more parameters were not met. Check below to see which parameter(s) failed.";
  
   
   } else {
   
      if(!SelectOrder){
      
         GetCurrentErrorCode        =  GetLastError();
         ConfirmationOrderProperty  =  "Order Error ("+string(GetCurrentErrorCode)+")";
         ConfimationEmailGreeting   =  "Although your broker successfully sent an order to your broker, there was an error with selecting the order from the ledger, therefore we are unable to provide any cost data or screen shot capture services.\n\n"+ErrorCodeURL+"\n\nPlease contact "+CompanyRaiseTicket+" to raise a support ticket, which can also be done via our website at https://www."+CompanyDomain;
         ConfimationEmailCostData   =  "Cost data is unavailable.(Error #"+string(GetCurrentErrorCode)+")";
         ChartURL                   =  "Screenshot unavailable at this time";
         ErrorCodeURL               = " https://www.mql5.com/en/docs/constants/errorswarnings/errorcodes";
         
         DiagnosticMessaging("Order Select Error on Successful Execution","Although your broker has successfully returned an order transaction, there was an error in selecting the order from the ledger. Ths means that cost data & screen capture services are not available on this occasion.\n\nYou may be able to self-diagnose the problem if you have an error code. You can visist "+ErrorCodeURL+" where you may be able to trace the problem.");
      
      } else {
      
         if (OrderType() >= 2){
         
            ConfirmationOrderProperty = "Pending Order";
         
         } 
      
         double ItemizedCosts[5];
                ExecutionSpreadCharge     = MarketSpread * PositonTickValue;
                ItemizedCosts[0]          = OrderMarginRequirement;
                ItemizedCosts[1]          = ExecutionSpreadCharge;
                ItemizedCosts[2]          = _OrderCommission;
                ItemizedCosts[3]          = _OrderSwap;
                ItemizedCosts[4]          = OrderTransactionCost(ItemizedCosts,ArraySize(ItemizedCosts));
                ExecutionSymbol           = OrderSymbol();
                ConfimationEmailCostData  = "Initial Investment (Margin Cost): "+_AccountCurrency+string(ItemizedCosts[0])+
                                            "\n\nSpread Charge:                "+_AccountCurrency+string(ItemizedCosts[1])+
                                            "\n\nCommission Charge:            "+_AccountCurrency+string(ItemizedCosts[2])+
                                            "\n\nSwapCharge:                   "+_AccountCurrency+string(ItemizedCosts[3])+
                                            "\n\nCost of Revenue:              "+_AccountCurrency+string(ItemizedCosts[4]);
                ConfimationEmailGreeting  = "A "+ConfirmationOrderProperty+" has been successfully placed with your broker on the "+ExecutionSymbol+" "+string(ExecutionTimeframe)+"H Chart"+
                                            "\n\nBelow, you find will the itemised costs for #"+string(_OrderTicket)+" for your records, including information pertaining to your broker & their contact details."+
                                            "\n\n"+CompanySignOff+
                                            "\n\n"+
                                            "\n\n"+LegalFooterDisclaimer();
                CaptureFileNameId         = _OrderTicket;
                ChartURL                  = ScreenShotCaptureURL(CaptureFileNameId);
      
      }
         
   }
   
   if (SendTransactionMessages == Send_Transaction_Messages){
   
      SendMail(ConfirmationOrderProperty+" "+HeaderInformation+" Notification",
      "\n\nDear "+ClientName+
      "\n\n"+ConfimationEmailGreeting+
      "\n=============================================="+
      "\nTransaction Cost Data"+
      "\n=============================================="+
      "\n\n"+ConfimationEmailCostData+
      "\n\n"+ParamDiagnostics+
      "\n=============================================="+
      "\nYour Chart Screenshot"+
      "\n=============================================="+
      "\n\nYou can view your screenshot link here:"+
      "\n\n"+ChartURL+
      "\n\n"+
      "\n\nExecution ID:"+
      "\n\n"+
      "\n\n"+string(CaptureFileNameId)+
      "\n\n"+
      "\n=============================================="+
      "\nSystem Build"+
      "\n=============================================="+
      "\n\nEA Version Build: "+EAName+
      "\n=============================================="+
      "\n\nBroker Information"+
      "\n=============================================="+
      "\n\nBroker Name: "+BrokerName+
      "\n\nBroker Account Number: "+string(BrokerAccountNumber)+
      "\n\nAccount Server: "+BrokerAccountServer+
      "\n\nBroker Contact Address: "+BrokerContactAddress+
      "\n\nBroker Regulation Information "+BrokerRegData+
      "\n\nBroker Privacy Policy: "+BrokerPrivacyURL+
      "\n\nMemos: "+MemoText+
      "\n\nYou can view the change log & browse all updates: "+GitHubRepo+
      "\n\nComments: "+FreeTextComment+
      "\n\nYours sincerely"+
      "\n\n"+CompanyName+
      "\n\n"+FooterNotesForConformationMessage);
      
   } else {
   
      Print("Transactional messages have been turned off.");
   
   }
   
   return;

}