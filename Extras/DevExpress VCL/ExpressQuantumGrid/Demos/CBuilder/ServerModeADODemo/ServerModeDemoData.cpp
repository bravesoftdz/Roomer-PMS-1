//---------------------------------------------------------------------------

#include <vcl.h>
#include "dstring.h"
#pragma hdrstop

#include "ServerModeDemoData.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "dxServerModeADODataSource"
#pragma link "dxServerModeData"
#pragma resource "*.dfm"
TServerModeDemoDataDM *ServerModeDemoDataDM;
//---------------------------------------------------------------------------
String GetCaption(){
  return "ExpressQuantumGrid ADO Server Mode Demo";
}
//---------------------------------------------------------------------------
String GetDatabaseName(){
  return "ServerModeGridDemo";
}
//---------------------------------------------------------------------------
String GetTableName(){
  return "ServerModeGridTableDemo";
}
//---------------------------------------------------------------------------
String GetDescription(){
  return "This demo shows a grid control's capabilities when bound to a large amount of data in Server Mode via an ADO connection.";
}
//---------------------------------------------------------------------------
__fastcall TServerModeDemoDataDM::TServerModeDemoDataDM(TComponent* Owner)
	: TDataModule(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TServerModeDemoDataDM::AddRecords(int ACount, TdxProgressEvent AProgress)
{


  int ASubCount = 10;
  String ASQL;
  ADOConnection->BeginTrans();
  try
	{
	  for (int I=0;I<(ACount/ASubCount);I++)
	  {
		if ((I % 100) == 0)
		  AProgress(this, I*ASubCount*100.0/ACount);
		ASQL = "";
		for (int J=1;J<=ASubCount;J++)
		{
		  ASQL = ASQL + GetInsertSQL();
		}
		ADOConnection->Execute(ASQL);
	  }
	  ADOConnection->CommitTrans();
	  }
  __except(EXCEPTION_EXECUTE_HANDLER)
  {
	ADOConnection->RollbackTrans();
  }
}      
//---------------------------------------------------------------------------
void TServerModeDemoDataDM::Connect(String AHostName, String ADatabaseName, String AUserName, String APassword, Boolean OSAuthentication)
{
  String AConnectionString;
  ADOConnection->Connected = false;
  ADOConnection->Provider = "SQLOLEDB.1";
  ADOConnection->LoginPrompt = false;
  String S = "Provider=SQLOLEDB.1;Data Source=%s;Initial Catalog=%s";
  TVarRec args[2] = {AHostName, ADatabaseName};
  AConnectionString = Format(S, args, 2);
  if (OSAuthentication)
	ADOConnection->ConnectionString = AConnectionString + ";Integrated Security=SSPI;Persist Security Info=False";
  else
  {
	TVarRec args2[2] = {AUserName, APassword};
	S = ";User ID=%s;Password=%s;Persist Security Info=True";
	ADOConnection->ConnectionString = AConnectionString +
	  Format(S, args2, 2);
  }
  ADOConnection->Connected = true;
}
//---------------------------------------------------------------------------
void TServerModeDemoDataDM::CreateDatabase()
{
	String ASQL = "IF DB_ID(N\'%s\') IS NULL CREATE DATABASE \"%s\";";
	TVarRec args[2] = {GetDatabaseName(), GetDatabaseName()};
	ExecSQL(Format(ASQL, args, 2));
}
//---------------------------------------------------------------------------
bool TServerModeDemoDataDM::TableExists()
{
  String ASQL;
  ASQL = "IF DB_ID(N'" + GetDatabaseName() + "') IS NOT NULL AND OBJECT_ID(N'" + GetDatabaseName() +
	".dbo." + GetTableName() + "') IS NOT NULL" + sLineBreak +
	"  SELECT 1;" + sLineBreak +
	"ELSE" + sLineBreak +
	"  SELECT -1;";
  ADOQuery->Active = False;
  ADOQuery->SQL->Text = ASQL;
  ADOQuery->Open();
  if ((!ADOQuery->Eof)&&(ADOQuery->Fields->Fields[0]->AsInteger == 1))
	return true;
  else
	return false;
}
//---------------------------------------------------------------------------
void TServerModeDemoDataDM::CreateTable()
{
  String ASQL;
  ASQL = "IF OBJECT_ID(N\'" + GetDatabaseName() + ".dbo." + GetTableName() + "\') IS NULL" + sLineBreak +
	"CREATE TABLE \"dbo\".\"" + GetTableName() + "\"(" +
	" \"OID\" int IDENTITY(1,1) NOT NULL, \"Subject\" nvarchar(100) NULL," +
	"\"From\" nvarchar(100) NULL," +
	" \"Sent\" datetime NULL," +
	" \"Size\" bigint NULL," +
	" \"HasAttachment\" bit NULL," +
	" \"Priority\" int NULL," +
	" CONSTRAINT \"PK_' + ATableName + '\" PRIMARY KEY CLUSTERED" +
	"(" +
	" \"OID\" ASC" +
	")WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON \"PRIMARY\"" +
	") ON \"PRIMARY\";";
  ExecSQL(ASQL);
  ExecSQL("CREATE NONCLUSTERED INDEX iSubject_ServerModeGridTableDemo ON \"ServerModeGridTableDemo\" (\"Subject\");");
  ExecSQL("CREATE NONCLUSTERED INDEX iFrom_ServerModeGridTableDemo ON \"ServerModeGridTableDemo\" (\"From\");");
  ExecSQL("CREATE NONCLUSTERED INDEX iSent_ServerModeGridTableDemo ON \"ServerModeGridTableDemo\" (\"Sent\");");
  ExecSQL("CREATE NONCLUSTERED INDEX iSize_ServerModeGridTableDemo ON \"ServerModeGridTableDemo\" (\"Size\");");
  ExecSQL("CREATE NONCLUSTERED INDEX iHasAttachment_ServerModeGridTableDemo ON \"ServerModeGridTableDemo\" (\"HasAttachment\");");
  ExecSQL("CREATE NONCLUSTERED INDEX iPriority_ServerModeGridTableDemo ON \"ServerModeGridTableDemo\" (\"Priority\");");
}
//---------------------------------------------------------------------------
void TServerModeDemoDataDM::ExecSQL(String ASQL)
{
  ADOQuery->Active = false;
  ADOQuery->SQL->Text = ASQL;
  ADOQuery->ExecSQL();
}
//---------------------------------------------------------------------------
String TServerModeDemoDataDM::GetInsertSQL(){
  String Users[] = { //17
	"Peter Dolan",
	"Ryan Fischer",
	"Richard Fisher",
	"Tom Hamlett",
	"Mark Hamilton",
	"Steve Lee",
	"Jimmy Lewis",
	"Jeffrey W McClain",
	"Andrew Miller",
	"Dave Murrel",
	"Bert Parkins",
	"Mike Roller",
	"Ray Shipman",
	"Paul Bailey",
	"Brad Barnes",
	"Carl Lucas",
	"Jerry Campbell"
  };
  String Subjects[] = { //21
	"Integrating Developer Express MasterView control into an Accounting System.",
    "Web Edition: Data Entry Page. There is an issue with date validation.",
	"Payables Due Calculator is ready for testing.",
	"Web Edition: Search Page is ready for testing.",
	"Main Menu: Duplicate Items. Somebody has to review all menu items in the system.",
	"Receivables Calculator. Where can I find the complete specs?",
	"Ledger: Inconsistency. Please fix it.",
	"Receivables Printing module is ready for testing.",
	"Screen Redraw. Somebody has to look at it.",
	"Email System. What library are we going to use?",
	"Cannot add new vendor. This module doesn""""t work!",
	"History. Will we track sales history in our system?",
	"Main Menu: Add a File menu. File menu item is missing.",
	"Currency Mask. The current currency mask in completely unusable.",
	"Drag & Drop operations are not available in the scheduler module.",
	"Data Import. What database types will we support?",
	"Reports. The list of incomplete reports.",
	"Data Archiving. We still don""""t have this features in our application.",
	"Email Attachments. Is it possible to add multiple attachments? I haven""""t found a way to do this.",
	"Check Register. We are using different paths for different modules.",
	"Data Export. Our customers asked us for export to Microsoft Excel"
  };
  String S = FormatDateTime("yyyymmdd hh:mm:ss", IncSecond(Now(), -Random(315360000)));
  return "INSERT INTO \"" + GetTableName() + "\" (\"Subject\", \"From\", \"Sent\", \"Size\", \"HasAttachment\", \"Priority\")" +
	"VALUES (\'" + Subjects[Random(21)] + "\',\'" + Users[Random(17)] + "\',\'" + S + "\'," +
	IntToStr(Random(100000)) + "," + IntToStr(Random(2)) + "," + IntToStr(Random(3)) + ");";
}
//---------------------------------------------------------------------------
int TServerModeDemoDataDM::GetRecordsCount()
{
  ADOQuery->Active = false;
  String ASQL = "IF DB_ID(N\'%s\') IS NOT NULL AND OBJECT_ID(N\'%0:s.dbo.%1:s\') IS NOT NULL SELECT COUNT(*) FROM %0:s.dbo.%1:s; ELSE SELECT 0;";
  TVarRec args[2] = {GetDatabaseName(), GetTableName()};
  ADOQuery->SQL->Text = Format(ASQL, args, 2);
  ADOQuery->Open();
  if (!ADOQuery->Eof)
	return ADOQuery->Fields->Fields[0]->AsInteger;
  else
	return 0;
}

