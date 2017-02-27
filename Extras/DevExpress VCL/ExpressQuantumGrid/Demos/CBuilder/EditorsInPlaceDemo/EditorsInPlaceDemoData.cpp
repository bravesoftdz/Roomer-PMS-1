//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "EditorsInPlaceDemoData.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxClasses"
#pragma link "cxGridTableView"
#pragma link "cxStyles"
#pragma link "cxGridCardView"
#pragma resource "*.dfm"
TEditorsInPlaceDemoDataDM *EditorsInPlaceDemoDataDM;
//---------------------------------------------------------------------------
__fastcall TEditorsInPlaceDemoDataDM::TEditorsInPlaceDemoDataDM(TComponent* Owner)
  : TDataModule(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TEditorsInPlaceDemoDataDM::tblCarsCalcFields(TDataSet *DataSet)
{
  tblCarsCar->AsString = tblCarsTrademark->AsString + " " +
	tblCarsModel->AsString;
}
//---------------------------------------------------------------------------
void __fastcall TEditorsInPlaceDemoDataDM::tblCarsTransmissSpeedCountSetText(
	  TField *Sender, const String Text)
{
  if (Text != "")
	tblCarsTransmissSpeedCount->AsInteger = StrToInt(Text[1]);
}
//---------------------------------------------------------------------------
void __fastcall TEditorsInPlaceDemoDataDM::DataModuleCreate(TObject *Sender)
{
   String APath = ExtractFilePath(Application->ExeName) + "..\\..\\Data\\";
   tblCars->LoadFromFile(APath + "Cars.xml");
   tblCities->LoadFromFile(APath + "Cities.xml");
   tblCustomers->LoadFromFile(APath + "Customers.xml");
   tblOrders->LoadFromFile(APath + "Orders.xml");
}

