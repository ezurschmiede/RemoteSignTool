object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Remote SignTool Server'
  ClientHeight = 495
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 562
    Height = 233
    Align = alTop
    BevelEdges = [beBottom]
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 701
    object edSigntoolPath: TLabeledEdit
      AlignWithMargins = True
      Left = 10
      Top = 25
      Width = 542
      Height = 23
      Margins.Left = 10
      Margins.Top = 25
      Margins.Right = 10
      Align = alTop
      EditLabel.Width = 148
      EditLabel.Height = 15
      EditLabel.Caption = 'Path to original signtool.exe'
      TabOrder = 0
      Text = ''
      ExplicitLeft = 6
      ExplicitTop = 27
      ExplicitWidth = 647
    end
    object edHttpPort: TLabeledEdit
      AlignWithMargins = True
      Left = 10
      Top = 117
      Width = 542
      Height = 23
      Margins.Left = 10
      Margins.Top = 20
      Margins.Right = 10
      Align = alTop
      EditLabel.Width = 53
      EditLabel.Height = 15
      EditLabel.Caption = 'HTTP Port'
      NumbersOnly = True
      TabOrder = 1
      Text = '8099'
      ExplicitLeft = 16
      ExplicitTop = 148
      ExplicitWidth = 73
    end
    object btStart: TButton
      AlignWithMargins = True
      Left = 100
      Top = 199
      Width = 362
      Height = 25
      Margins.Left = 100
      Margins.Top = 10
      Margins.Right = 100
      Align = alTop
      Caption = 'Test and start server'
      TabOrder = 2
      OnClick = btStartClick
      ExplicitLeft = 503
      ExplicitTop = 146
      ExplicitWidth = 136
    end
    object edSigntoolCmdLine: TLabeledEdit
      AlignWithMargins = True
      Left = 10
      Top = 71
      Width = 542
      Height = 23
      Margins.Left = 10
      Margins.Top = 20
      Margins.Right = 10
      Align = alTop
      EditLabel.Width = 314
      EditLabel.Height = 15
      EditLabel.Caption = 'Default signtool parameters (if not overridden by client call)'
      TabOrder = 3
      Text = ''
      ExplicitLeft = 16
      ExplicitTop = 65
      ExplicitWidth = 627
    end
    object edCross: TLabeledEdit
      AlignWithMargins = True
      Left = 10
      Top = 163
      Width = 542
      Height = 23
      Margins.Left = 10
      Margins.Top = 20
      Margins.Right = 10
      Align = alTop
      EditLabel.Width = 312
      EditLabel.Height = 15
      EditLabel.Caption = 'Corss certificate for Driver signing (path to file or file name)'
      TabOrder = 4
      Text = 'GlobalSign Root CA.crt'
      ExplicitLeft = 16
      ExplicitTop = 106
      ExplicitWidth = 627
    end
  end
  object memLog: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 236
    Width = 556
    Height = 256
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 695
    ExplicitHeight = 328
  end
  object httpServ: TIdHTTPServer
    Bindings = <>
    DefaultPort = 8099
    OnAfterBind = httpServAfterBind
    OnCommandGet = httpServCommandGet
    Left = 32
    Top = 232
  end
end
