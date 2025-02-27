//+------------------------------------------------------------------+
//|                                              EmailAttributes.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict


string   CompanyName                =  "Blue City Capital Technologies, Inc";
string   CompanyLegalAddress        =  "#14395 8 The Green, Dover, DE 19901";
string   CompanyContactAddress      =  "255 S King St Ste 800 Seattle, WA 98104";
string   CompanyRegData             =  "Registered in the State of Delaware under Section 102 of the General Corporation Law of the State of Delaware, Company Number 3215522";
string   CompanyDomain              =  "bluecitycapital.us"; 
string   CompanyRaiseTicket         =  "hello@"+CompanyDomain;
string   CompanyEngineeringTicket   =  "engineering@"+CompanyDomain;
string   CompanyReportAbuse         =  "abuse@"+CompanyDomain;
string   CompanyWebAddress          =  "www."+CompanyDomain;
string   ContactInformation         =  "This email originates from "+CompanyName+" "+CompanyLegalAddress+" | "+CompanyRegData;
string   CompanyPrivacyURL          =  "https://www."+CompanyDomain+"/legal/privacy/privacy-statement";
string   HeaderInformation          =  " | "+CompanyName;
string   LicenceInformationStatus   =  "Licence Check Status "+HeaderInformation;
string   ErrorCodeURL               =  "https://www.mql5.com/en/docs/constants/errorswarnings/errorcodes";
string   CompanyHelpInstructions    =  "If you have an error code, you can look this up by visiting"+ErrorCodeURL+
                                       "\n\nIf the issue persists, please contact us at "+CompanyEngineeringTicket+", or you can go to www."+CompanyDomain+" & select 'Speak with us' at the buttom of the page.";
string   GitHubRepo                 =  "https://github.com/BlauweStadTechnologieen/hammertime/blob/main/README.md";
string   CompanySignOff             =  "You can always raise a help ticket by emailing "+CompanyRaiseTicket+
                                       "\n\nYours sincerely\n\n"+CompanyName;
string   MQHScript                  =  " | MQH Script";

string LegalFooterDisclaimer(){
   //---
   //This contains the privacy and identification and identification information about the company in the event that an unauthorized party becomes privy to the contents of this email.
   string Message =  "This automated email is intended for the recipient stated at the address at the top of this email. If you have received this in error, please forward this email immediately to dpo@"+CompanyDomain+", then delete this from your email client. You can also reply to this message if you need any assistance. If you have any queries, you can raise a ticket by messaging us on "+CompanyRaiseTicket+
                     "\n\nTo view a copy of our privacy policy, you can head over to "+CompanyPrivacyURL+
                     "\n\nThis message has originated from "+CompanyName +
                     "\n\nYou can now reply directy to this email address if you need any assistance & you will shortly receive a support ticket where you can add additional information as necessary."+
                     "\n\nThis message is only intended for the recipient(s) stated at the top of this message. If you have received this message in error, we wholeheartedly apologise. Please forward this message to dpo@"+CompanyDomain+" if you were not expecting to receive this message."+
                     "\n\nYou are receiving this message because the email address at the top of this e-mail was included in the terminal settings of either your MQL4 or MQL5 terminal."+
                     "\n\nYou can read our Privacy Policy by visiting "+CompanyPrivacyURL+
                     "\n\nOur legal address is "+CompanyLegalAddress+" & our trading address is "+CompanyContactAddress+
                     "\n\n"+CompanyRegData;
   
   return Message;

}