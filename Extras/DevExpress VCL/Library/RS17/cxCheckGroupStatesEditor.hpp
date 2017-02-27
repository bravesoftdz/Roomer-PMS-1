// CodeGear C++Builder
// Copyright (c) 1995, 2012 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'cxCheckGroupStatesEditor.pas' rev: 24.00 (Win32)

#ifndef CxcheckgroupstateseditorHPP
#define CxcheckgroupstateseditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <cxButtons.hpp>	// Pascal unit
#include <cxCheckListBox.hpp>	// Pascal unit
#include <cxContainer.hpp>	// Pascal unit
#include <cxControls.hpp>	// Pascal unit
#include <cxLookAndFeelPainters.hpp>	// Pascal unit
#include <cxGraphics.hpp>	// Pascal unit
#include <cxLookAndFeels.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <cxEdit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Cxcheckgroupstateseditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TcxCheckGroupStatesEditorDlg;
class PASCALIMPLEMENTATION TcxCheckGroupStatesEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Cxchecklistbox::TcxCheckListBox* clbStates;
	Vcl::Extctrls::TPanel* Panel1;
	Cxbuttons::TcxButton* btnOK;
	Cxbuttons::TcxButton* btnCancel;
	void __fastcall FormShow(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TcxCheckGroupStatesEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TcxCheckGroupStatesEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TcxCheckGroupStatesEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TcxCheckGroupStatesEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TcxCheckGroupStatesEditorDlg* cxCheckGroupStatesEditorDlg;
}	/* namespace Cxcheckgroupstateseditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_CXCHECKGROUPSTATESEDITOR)
using namespace Cxcheckgroupstateseditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CxcheckgroupstateseditorHPP
