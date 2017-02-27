// CodeGear C++Builder
// Copyright (c) 1995, 2012 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxPSfmStlDsg.pas' rev: 24.00 (Win32)

#ifndef DxpsfmstldsgHPP
#define DxpsfmstldsgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <dxPgsDlg.hpp>	// Pascal unit
#include <dxPSDsgProxies.hpp>	// Pascal unit
#include <cxLookAndFeelPainters.hpp>	// Pascal unit
#include <cxButtons.hpp>	// Pascal unit
#include <cxControls.hpp>	// Pascal unit
#include <cxContainer.hpp>	// Pascal unit
#include <cxEdit.hpp>	// Pascal unit
#include <cxGraphics.hpp>	// Pascal unit
#include <cxGroupBox.hpp>	// Pascal unit
#include <dxCore.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <DesignWindows.hpp>	// Pascal unit
#include <cxListBox.hpp>	// Pascal unit
#include <cxLookAndFeels.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dxpsfmstldsg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TdxfmPrintStylesDesignWindow;
class PASCALIMPLEMENTATION TdxfmPrintStylesDesignWindow : public Designwindows::TDesignWindow
{
	typedef Designwindows::TDesignWindow inherited;
	
__published:
	Cxbuttons::TcxButton* btnAdd;
	Cxbuttons::TcxButton* btnDelete;
	Cxbuttons::TcxButton* btnMoveDown;
	Cxbuttons::TcxButton* btnMoveUp;
	Cxbuttons::TcxButton* btnPageSetup;
	Cxbuttons::TcxButton* btnRestoreDefaults;
	Cxbuttons::TcxButton* btnSelectAll;
	Cxlistbox::TcxListBox* lbxStyles;
	Vcl::Menus::TMenuItem* miAdd;
	Vcl::Menus::TMenuItem* miAddStandard;
	Vcl::Menus::TMenuItem* miBackground;
	Vcl::Menus::TMenuItem* miBackgroundClear;
	Vcl::Menus::TMenuItem* miBackgroundEffects;
	Vcl::Menus::TMenuItem* miCopy;
	Vcl::Menus::TMenuItem* miCut;
	Vcl::Menus::TMenuItem* miDelete;
	Vcl::Menus::TMenuItem* miEdit;
	Vcl::Menus::TMenuItem* miLine;
	Vcl::Menus::TMenuItem* miLine1;
	Vcl::Menus::TMenuItem* miLine2;
	Vcl::Menus::TMenuItem* miLine5;
	Vcl::Menus::TMenuItem* miMoveDown;
	Vcl::Menus::TMenuItem* miMoveUp;
	Vcl::Menus::TMenuItem* miPageSetup;
	Vcl::Menus::TMenuItem* miPaste;
	Vcl::Menus::TMenuItem* miRestoreDefaults;
	Vcl::Menus::TMenuItem* miSelectAll;
	Vcl::Menus::TMenuItem* miSetAsCurrent;
	Vcl::Menus::TMenuItem* miShowButtons;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* N2;
	Vcl::Menus::TMenuItem* N3;
	Vcl::Menus::TPopupMenu* pmStyles;
	Cxgroupbox::TcxGroupBox* pnlButtons;
	Cxgraphics::TcxImageList* ilMenu;
	void __fastcall AddClick(System::TObject* Sender);
	void __fastcall AddStandardClick(System::TObject* Sender);
	void __fastcall BackgroundClick(System::TObject* Sender);
	void __fastcall ClearBackgroundClick(System::TObject* Sender);
	void __fastcall EditClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall lbxStylesClick(System::TObject* Sender);
	void __fastcall lbxStylesDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall lbxStylesDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall lbxStylesDrawItem(Cxlistbox::TcxListBox* AControl, Cxgraphics::TcxCanvas* ACanvas, int AIndex, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState AState);
	void __fastcall lbxStylesEndDrag(System::TObject* Sender, System::TObject* Target, int X, int Y);
	void __fastcall lbxStylesKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall lbxStylesStartDrag(System::TObject* Sender, Vcl::Controls::TDragObject* &DragObject);
	void __fastcall miSetAsCurrentClick(System::TObject* Sender);
	void __fastcall miShowButtonsClick(System::TObject* Sender);
	void __fastcall MoveDownClick(System::TObject* Sender);
	void __fastcall MoveUpClick(System::TObject* Sender);
	void __fastcall PageSetupClick(System::TObject* Sender);
	void __fastcall pmStylesPopup(System::TObject* Sender);
	void __fastcall RestoreDefaultsClick(System::TObject* Sender);
	
private:
	Dxpgsdlg::TdxPrintStyleManager* FController;
	System::Uitypes::TCursor FSaveCursor;
	int FSaveDragIndex;
	Dxpgsdlg::TAbstractdxStyleManagerDesigner* __fastcall GetControllerDesigner(void);
	Dxpgsdlg::TBasedxPrintStyle* __fastcall GetCurrentStyle(void);
	System::UnicodeString __fastcall GetRegistryPath(void);
	bool __fastcall GetSelected(int Index);
	int __fastcall GetSelectedCount(void);
	Dxpgsdlg::TBasedxPrintStyle* __fastcall GetStyle(int Index);
	int __fastcall GetStyleCount(void);
	void __fastcall SetController(Dxpgsdlg::TdxPrintStyleManager* Value);
	void __fastcall SetSelected(int Index, bool Value);
	void __fastcall AddStyle(void);
	bool __fastcall CanAdd(void);
	bool __fastcall CanAddStandard(void);
	bool __fastcall CanBackgroundClear(void);
	bool __fastcall CanBackgroundEffects(void);
	bool __fastcall CanCopy(void);
	bool __fastcall CanCut(void);
	bool __fastcall CanDelete(void);
	bool __fastcall CanMoveDown(void);
	bool __fastcall CanMoveUp(void);
	bool __fastcall CanPaste(void);
	bool __fastcall CanPageSetup(void);
	bool __fastcall CanRestoreDefaults(void);
	bool __fastcall CanSelectAll(void);
	bool __fastcall CanSetAsCurrent(void);
	void __fastcall CheckAddStyle(void);
	void __fastcall CheckDeleteStyle(void);
	void __fastcall Copy(void);
	void __fastcall Cut(void);
	void __fastcall Delete(void);
	void __fastcall DeleteItem(Dxpgsdlg::TBasedxPrintStyle* AItem);
	void __fastcall DrawDragRect(void);
	System::Types::TPoint __fastcall GetMinWindowSize(void);
	void __fastcall GetSelections(const Designintf::_di_IDesignerSelections ASelections);
	int __fastcall IndexOf(Dxpgsdlg::TBasedxPrintStyle* AItem);
	void __fastcall InternalAddStyle(Dxpgsdlg::TdxPrintStyleClass AStyleClass);
	void __fastcall MoveSelection(int ADelta);
	void __fastcall Paste(void);
	void __fastcall PrepareAddStandardItem(Vcl::Menus::TMenuItem* MenuItem);
	void __fastcall RefreshList(void);
	void __fastcall RestoreLayout(void);
	void __fastcall Select(System::Classes::TPersistent* AItem, bool AddToSelection);
	void __fastcall SelectAll(void);
	void __fastcall SelectController(void);
	void __fastcall StartWait(void);
	void __fastcall StopWait(void);
	void __fastcall StoreLayout(void);
	void __fastcall UpdateCaption(void);
	void __fastcall UpdateControlsState(void);
	void __fastcall UpdateHScrollBar(void);
	void __fastcall UpdateItem(Dxpgsdlg::TBasedxPrintStyle* AItem);
	void __fastcall UpdateMenuState(void);
	void __fastcall UpdateSelections(const Designintf::_di_IDesignerSelections ASelections);
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Winapi::Messages::TWMGetMinMaxInfo &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCreate(Winapi::Messages::TWMNCCreate &Message);
	HIDESBASE MESSAGE void __fastcall WMNCDestroy(Winapi::Messages::TWMNCCreate &Message);
	
protected:
	DYNAMIC void __fastcall Activated(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual System::UnicodeString __fastcall UniqueName(System::Classes::TComponent* Comp);
	
public:
	__fastcall virtual TdxfmPrintStylesDesignWindow(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TdxfmPrintStylesDesignWindow(void);
	virtual bool __fastcall EditAction(Designintf::TEditAction Action);
	virtual void __fastcall ItemDeleted(const Designintf::_di_IDesigner ADesigner, System::Classes::TPersistent* Item);
	virtual void __fastcall ItemsModified(const Designintf::_di_IDesigner Designer);
	virtual void __fastcall SelectionChanged(const Designintf::_di_IDesigner ADesigner, const Designintf::_di_IDesignerSelections ASelection);
	virtual Designintf::TEditState __fastcall GetEditState(void);
	__property Dxpgsdlg::TBasedxPrintStyle* CurrentStyle = {read=GetCurrentStyle};
	__property Dxpgsdlg::TdxPrintStyleManager* Controller = {read=FController, write=SetController};
	__property Dxpgsdlg::TAbstractdxStyleManagerDesigner* ControllerDesigner = {read=GetControllerDesigner};
	__property System::UnicodeString RegistryPath = {read=GetRegistryPath};
	__property bool Selected[int Index] = {read=GetSelected, write=SetSelected};
	__property int SelectedCount = {read=GetSelectedCount, nodefault};
	__property int StyleCount = {read=GetStyleCount, nodefault};
	__property Dxpgsdlg::TBasedxPrintStyle* Styles[int Index] = {read=GetStyle};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TdxfmPrintStylesDesignWindow(System::Classes::TComponent* AOwner, int Dummy) : Designwindows::TDesignWindow(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TdxfmPrintStylesDesignWindow(HWND ParentWindow) : Designwindows::TDesignWindow(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall dxShowPrintStylesDesigner(Dxpgsdlg::TdxPrintStyleManager* AStyleController, Designintf::_di_IDesigner AFormDesigner);
}	/* namespace Dxpsfmstldsg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_DXPSFMSTLDSG)
using namespace Dxpsfmstldsg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DxpsfmstldsgHPP
