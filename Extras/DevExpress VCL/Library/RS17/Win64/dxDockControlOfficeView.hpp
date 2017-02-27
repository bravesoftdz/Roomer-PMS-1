// CodeGear C++Builder
// Copyright (c) 1995, 2012 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxDockControlOfficeView.pas' rev: 24.00 (Win64)

#ifndef DxdockcontrolofficeviewHPP
#define DxdockcontrolofficeviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <dxDockControl.hpp>	// Pascal unit
#include <dxDockControlNETView.hpp>	// Pascal unit
#include <cxLookAndFeelPainters.hpp>	// Pascal unit
#include <cxGraphics.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dxdockcontrolofficeview
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TdxDockControlOfficePainter;
class PASCALIMPLEMENTATION TdxDockControlOfficePainter : public Dxdockcontrolnetview::TdxDockControlNETPainter
{
	typedef Dxdockcontrolnetview::TdxDockControlNETPainter inherited;
	
protected:
	__classmethod virtual void __fastcall CreateColors();
	__classmethod virtual void __fastcall RefreshColors();
	__classmethod virtual void __fastcall ReleaseColors();
	virtual System::Uitypes::TColor __fastcall GetBorderColor(void);
	virtual System::Uitypes::TColor __fastcall GetCaptionColor(bool IsActive);
	virtual System::Uitypes::TColor __fastcall GetCaptionFontColor(bool IsActive);
	virtual System::Uitypes::TColor __fastcall GetCaptionSignColor(bool IsActive, Cxlookandfeelpainters::TcxButtonState AState);
	virtual bool __fastcall NeedRedrawOnResize(void);
	
public:
	__classmethod virtual bool __fastcall HasLookAndFeelStyle(Cxlookandfeelpainters::TcxLookAndFeelStyle AStyle);
	virtual void __fastcall DrawBorder(Cxgraphics::TcxCanvas* ACanvas, System::Types::TRect &ARect);
	virtual void __fastcall DrawCaptionButtonSelection(Cxgraphics::TcxCanvas* ACanvas, System::Types::TRect &ARect, bool AIsActive, Cxlookandfeelpainters::TcxButtonState AState);
	virtual void __fastcall DrawCaptionMaximizeButton(Cxgraphics::TcxCanvas* ACanvas, System::Types::TRect &ARect, bool IsActive, bool IsSwitched, Cxlookandfeelpainters::TcxButtonState AState);
	virtual void __fastcall DrawClient(Cxgraphics::TcxCanvas* ACanvas, System::Types::TRect &ARect);
	virtual void __fastcall DrawHideBar(Cxgraphics::TcxCanvas* ACanvas, System::Types::TRect &ARect, Dxdockcontrol::TdxAutoHidePosition APosition);
	virtual void __fastcall DrawHideBarButton(Cxgraphics::TcxCanvas* ACanvas, Dxdockcontrol::TdxDockSiteHideBarButton* AButton, Dxdockcontrol::TdxAutoHidePosition APosition);
	virtual void __fastcall DrawHideBarButtonBackground(Cxgraphics::TcxCanvas* ACanvas, Dxdockcontrol::TdxDockSiteHideBarButton* AButton, Dxdockcontrol::TdxAutoHidePosition APosition);
	virtual void __fastcall DrawHideBarButtonSection(Cxgraphics::TcxCanvas* ACanvas, Dxdockcontrol::TdxDockSiteHideBarButtonSection* AButtonSection, Dxdockcontrol::TdxAutoHidePosition APosition);
	virtual void __fastcall DrawHideBarScrollButton(Cxgraphics::TcxCanvas* ACanvas, const System::Types::TRect &ARect, Cxlookandfeelpainters::TcxButtonState AState, Cxlookandfeelpainters::TcxArrowDirection AArrow);
public:
	/* TdxDockControlPainter.Create */ inline __fastcall virtual TdxDockControlOfficePainter(Dxdockcontrol::TdxCustomDockControl* ADockControl) : Dxdockcontrolnetview::TdxDockControlNETPainter(ADockControl) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TdxDockControlOfficePainter(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Dxdockcontrolofficeview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_DXDOCKCONTROLOFFICEVIEW)
using namespace Dxdockcontrolofficeview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DxdockcontrolofficeviewHPP
