// CodeGear C++Builder
// Copyright (c) 1995, 2012 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxGalleryDesigner.pas' rev: 24.00 (Win32)

#ifndef DxgallerydesignerHPP
#define DxgallerydesignerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ToolWin.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.ActnList.hpp>	// Pascal unit
#include <dxCore.hpp>	// Pascal unit
#include <cxGraphics.hpp>	// Pascal unit
#include <cxClasses.hpp>	// Pascal unit
#include <cxDesignWindows.hpp>	// Pascal unit
#include <dxMessages.hpp>	// Pascal unit
#include <dxGallery.hpp>	// Pascal unit
#include <DesignWindows.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dxgallerydesigner
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmGalleryDesigner;
class PASCALIMPLEMENTATION TfrmGalleryDesigner : public Cxdesignwindows::TcxDesignFormEditor
{
	typedef Cxdesignwindows::TcxDesignFormEditor inherited;
	
__published:
	Cxgraphics::TcxImageList* ilButtons;
	Vcl::Menus::TPopupMenu* ppmGalleryItems;
	Vcl::Menus::TMenuItem* ppmiAdd;
	Vcl::Menus::TMenuItem* ppmiDelete;
	Vcl::Menus::TPopupMenu* ppmDragDrop;
	Vcl::Menus::TMenuItem* ppmiCopy;
	Vcl::Menus::TMenuItem* ppmiMove;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* ppmiGroupVisible;
	Vcl::Menus::TMenuItem* ppmiGroupHeaderVisible;
	Cxgraphics::TcxImageList* ilGroupState;
	Vcl::Actnlist::TActionList* alMain;
	Vcl::Actnlist::TAction* actAddGroup;
	Vcl::Actnlist::TAction* actRemove;
	Vcl::Actnlist::TAction* actAddGroupItem;
	Vcl::Menus::TMenuItem* AddGroup1;
	Vcl::Actnlist::TAction* actMoveNodeUp;
	Vcl::Actnlist::TAction* actMoveNodeDown;
	Vcl::Actnlist::TAction* actGroupVisible;
	Vcl::Actnlist::TAction* actGroupHeaderVisible;
	Vcl::Comctrls::TTreeView* tvGalleryItems;
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Comctrls::TToolButton* tbAddGroup;
	Vcl::Comctrls::TToolButton* tbAddGroupItem;
	Vcl::Comctrls::TToolButton* tbDelete;
	Vcl::Comctrls::TToolButton* tbSeparator;
	Vcl::Comctrls::TToolButton* tbMoveNodeUp;
	Vcl::Comctrls::TToolButton* tbMoveNodeDown;
	Vcl::Actnlist::TAction* actClose;
	Cxgraphics::TcxImageList* ilHelper;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall tvGalleryItemsDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall tvGalleryItemsDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall tvGalleryItemsChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall tvGalleryItemsEdited(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, System::UnicodeString &S);
	void __fastcall ppmiCopyClick(System::TObject* Sender);
	void __fastcall ppmiMoveClick(System::TObject* Sender);
	void __fastcall ppmDragDropPopup(System::TObject* Sender);
	void __fastcall ppmGalleryItemsPopup(System::TObject* Sender);
	void __fastcall actAddGroupExecute(System::TObject* Sender);
	void __fastcall actRemoveExecute(System::TObject* Sender);
	void __fastcall actAddGroupItemExecute(System::TObject* Sender);
	void __fastcall actMoveNodeUpExecute(System::TObject* Sender);
	void __fastcall actMoveNodeDownExecute(System::TObject* Sender);
	void __fastcall actGroupVisibleExecute(System::TObject* Sender);
	void __fastcall actCloseExecute(System::TObject* Sender);
	
private:
	Vcl::Comctrls::TTreeNode* FDeletingNode;
	Vcl::Comctrls::TTreeNode* FDragDropTargetNode;
	System::Classes::TWndMethod FGalleryItemsWndProc;
	int FLockSelectionChangedCount;
	Dxgallery::_di_IdxGallery FGallery;
	bool __fastcall CanModify(void);
	void __fastcall GalleryItemsMenuSetup(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall GroupPopupMenuInitialize(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall RefreshImages(void);
	void __fastcall AddGroupNode(void);
	void __fastcall AddGroupItemNode(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall MoveGroupNode(Vcl::Comctrls::TTreeNode* ANode, bool MoveUp);
	void __fastcall MoveNodeDown(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall MoveNodeUp(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall MoveGroupItemNode(Vcl::Comctrls::TTreeNode* ANode, bool MoveUp);
	void __fastcall RemoveNode(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall SetGroupNodeGlyph(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall UpdateGroupNode(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall UpdateGroupItemNode(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall DoDragDrop(Vcl::Comctrls::TTreeNode* ATargetNode, bool DoCopy = false);
	void __fastcall GroupItemNodeDragDrop(Vcl::Comctrls::TTreeNode* ASourceNode, Vcl::Comctrls::TTreeNode* ATargetNode, bool DoCopy);
	void __fastcall GroupNodeDragDrop(Vcl::Comctrls::TTreeNode* ASourceNode, Vcl::Comctrls::TTreeNode* ATargetNode);
	Dxgallery::TdxGalleryGroup* __fastcall AddGalleryGroup(Vcl::Comctrls::TTreeNode* ANode);
	Dxgallery::TdxGalleryItem* __fastcall AddGalleryGroupItem(Vcl::Comctrls::TTreeNode* ANode, const System::UnicodeString ADescription);
	Dxgallery::TdxGalleryGroup* __fastcall GetGalleryGroup(Vcl::Comctrls::TTreeNode* ANode);
	Dxgallery::TdxGalleryItem* __fastcall GetGalleryItem(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall SynchronizeTreeView(void);
	bool __fastcall RemoveCorrespondingObject(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall SetGalleryGroupIndex(Vcl::Comctrls::TTreeNode* ANode, int AIndex);
	void __fastcall UpdateItemCaption(Vcl::Comctrls::TTreeNode* ANode, System::UnicodeString ACaption);
	void __fastcall MoveItem(Dxgallery::TdxGalleryItem* AItem, Dxgallery::TdxGalleryGroup* ATargetGroup, int AIndex);
	Dxgallery::TdxGalleryItem* __fastcall CopyItem(Dxgallery::TdxGalleryItem* AItem, Dxgallery::TdxGalleryGroup* ATargetGroup, int AIndex);
	void __fastcall SetDesignerModified(void);
	void __fastcall SelectCorrespondingObject(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall GalleryItemsWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall RestoreTreeViewWndProc(void);
	void __fastcall StoreTreeViewWndProc(void);
	bool __fastcall TreeViewWndProcHandler(Vcl::Comctrls::TTreeView* ATreeView, Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMDeleteDesignNode(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall UpdateActions(void);
	virtual void __fastcall UpdateCaption(void);
	virtual void __fastcall SetComponent(System::Classes::TComponent* AValue);
	
public:
	__fastcall virtual TfrmGalleryDesigner(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrmGalleryDesigner(void);
	virtual void __fastcall DoItemDeleted(System::Classes::TPersistent* AItem);
	virtual void __fastcall DoItemsModified(void);
	virtual void __fastcall SelectionsChanged(const Designintf::_di_IDesignerSelections ASelection);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmGalleryDesigner(System::Classes::TComponent* AOwner, int Dummy) : Cxdesignwindows::TcxDesignFormEditor(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmGalleryDesigner(HWND ParentWindow) : Cxdesignwindows::TcxDesignFormEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word WM_DELETEDESIGNERNODE = System::Word(0x8065);
extern PACKAGE void __fastcall EditGallery(System::Classes::TComponent* AGalleryOwner);
}	/* namespace Dxgallerydesigner */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_DXGALLERYDESIGNER)
using namespace Dxgallerydesigner;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DxgallerydesignerHPP
