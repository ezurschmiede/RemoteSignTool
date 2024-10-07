program RemoteSignTool_Client;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Classes,
  System.IniFiles,
  {$IFDEF DEBUG}
  //Vcl.Dialogs,
  {$ENDIF DEBUG}
  IdBaseComponent,
  IdComponent,
  IdHTTP,
  signtool_client in 'signtool_client.pas';

var
  client: TRemoteSignToolClient;
  ini: TIniFile;
  FileList: TStringList;
  IgnoreFailed: Boolean;
  I: Integer;
begin
  try
    FileList := TStringList.Create;
    try
      ExitCode := 2;
      client := TRemoteSignToolClient.Create;
      try
        ini := TIniFile.Create(ChangeFileExt(ParamStr(0),'.ini'));
        try
          client.host := ini.ReadString('server','host','localhost');
          client.port := ini.ReadInteger('server','port',8099);
        finally
          ini.Free;
        end;

        IgnoreFailed := false;

        for I := 1 to ParamCount do
        begin
          if ParamStr(I) = '/skiperrors' then
            IgnoreFailed := true
          else
          if FileExists(ParamStr(I)) then
            FileList.Add(ParamStr(I));
        end;

        {$IFDEF DEBUG}
        //Vcl.Dialogs.ShowMessage(FileList.Text);
        //Halt;
        {$ENDIF DEBUG}

        if FileList.Count > 0 then
        begin
          for I := 0 to FileList.Count-1 do
          begin
            if client.SignFile(FileList[i], '') then
            begin
              WriteLn(FileList[i] + ' signed succesfully');
            end else
            begin
              WriteLn(ErrOutput, FileList[i] + ' error: ' + client.ErrorMessage);
              ExitCode := client.ErrorCode;

              if not IgnoreFailed then
                Exit;
            end;
          end;
        end else
        begin
          WriteLn(ErrOutput, 'Error: File not found or not specified');
          WriteLn('You must specify at least one file to sign!');
          ExitCode := 1;
          exit;
        end;
      finally
        client.Free;
      end;
    finally
      FileList.Free;
    end;
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      ExitCode := 1;
    end;
  end;
end.
