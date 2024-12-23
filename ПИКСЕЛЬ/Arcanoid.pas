unit Arcanoid;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Types, Math, Vcl.Menus, Vcl.Imaging.jpeg,
  Vcl.ExtDlgs, Vcl.MPlayer, Vcl.Imaging.pngimage;
type
  TBrick = class(TShape)
  public
    constructor Create(AOwner: TComponent); override;
  end;
  TForm2 = class(TForm)
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    Ball: TShape;
    Paddle: TShape;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    fon: TImage;
    music: TImage;
    Background: TImage;
    MediaPlayer1: TMediaPlayer;
    Image6: TImage;
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Timer1Timer(Sender: TObject);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Image3Click(Sender: TObject);
    procedure fonClick(Sender: TObject);
    procedure musicClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure BackgroundMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SafeAr;
    procedure RestartGame;
  private
    { Private declarations }
    procedure ResetBall;
    procedure HideGameOverElements;
  public
    { Public declarations }
    RecordFileName: string;
    RecordFile: TextFile;
    PlayerName: string;
    GameStarted: Boolean;
  end;
var
  Form2: TForm2;
  dx, dy: Integer;
  Bricks: array of TBrick;
  n: Integer;
  Level: Integer;
implementation
{$R *.dfm}
uses
  Main, Result;
procedure TForm2.SafeAr;
begin
  RecordFileName := ExtractFilePath(Application.ExeName) + '�������/Arcanoid.txt';
  AssignFile(RecordFile, RecordFileName);
  if FileExists(RecordFileName) then
    Append(RecordFile)
  else
    Rewrite(RecordFile);
  Writeln(RecordFile, PlayerName + '      |' + Label5.Caption);
  CloseFile(RecordFile);
end;
constructor TBrick.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Shape := stRoundRect;
  Width := 80;
  Height := 30;
  Brush.Color := RGB(Random(255), Random(255), Random(255));
end;
procedure TForm2.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_TOPMOST;
end;
procedure TForm2.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  Level := 1;
  n := 30;
  Top := 0;
  Left := 0;
  Width := GetSystemMetrics(SM_CXSCREEN);
  Height := GetSystemMetrics(SM_CYSCREEN);
  dx := 5;
  dy := 5;
  Paddle.Top := ClientHeight - Paddle.Height - 120;
  Ball.Top := Paddle.Top - Ball.Height;
  Ball.Left := Paddle.Left + (Paddle.Width - Ball.Width) div 2;
  GameStarted := False;
  SetLength(Bricks, n);
  for i := 0 to n - 1 do
  begin
    Bricks[i] := TBrick.Create(Self);
    Bricks[i].Parent := Self;
    Bricks[i].Top := ClientHeight div 2 - (Bricks[i].Height + 5) * 10 + (i div 10) * (Bricks[i].Height + 5);
    Bricks[i].Left := ClientWidth div 2 - (Bricks[i].Width + 5) * 5 + (i mod 10) * (Bricks[i].Width + 5);
  end;
  DoubleBuffered := True;
end;
procedure TForm2.ImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  Paddle.Left := X - Paddle.Width div 2;
  if not GameStarted then
  begin
    Ball.Left := Paddle.Left + (Paddle.Width - Ball.Width) div 2;
  end;
end;
procedure TForm2.Image3Click(Sender: TObject);
var
  i: Integer;
begin
  if Level = 1 then
  begin
    n := 50;
    ResetBall;
    Timer1.Interval := 10;
    Label1.Caption := '������� 2';
    Label2.Caption := '���� 50/';
    Label3.Caption := '0';
    Image1.Visible := False;
    Image3.Visible := False;
    Image4.Visible := False;
    SetLength(Bricks, n);
    for i := 0 to n - 1 do
    begin
      Bricks[i] := TBrick.Create(Self);
      Bricks[i].Parent := Self;
      Bricks[i].Top := ClientHeight div 2 - (Bricks[i].Height + 5) * 12 + (i div 5) * (Bricks[i].Height + 35);
      Bricks[i].Left := ClientWidth div 2 - (Bricks[i].Width + 5) * 8 + (i mod 10) * (Bricks[i].Width + 55);
    end;
    Inc(Level);
    HideGameOverElements;
  end
  else if Level = 2 then
  begin
    n := 70;
    ResetBall;
    Timer1.Interval := 1;
    Label1.Caption := '������� 3';
    Label2.Caption := '���� 70/';
    Label3.Caption := '0';
    Image1.Visible := False;
    Image3.Visible := False;
    Image4.Visible := False;
    SetLength(Bricks, n);
    for i := 0 to n - 1 do
    begin
      Bricks[i] := TBrick.Create(Self);
      Bricks[i].Parent := Self;
      Bricks[i].Top := ClientHeight div 2 - (Bricks[i].Height + 5) * 10 + (i div 10) * (Bricks[i].Height + 35);
      Bricks[i].Left := ClientWidth div 2 - (Bricks[i].Width - 25) * 10 + (i mod 10) * (Bricks[i].Width + 1);
    end;
    HideGameOverElements;
  end;
end;
procedure TForm2.Image4Click(Sender: TObject);
begin
  SafeAr;
  Form2.Hide;
  Form5.Show;
  HideGameOverElements;
  RestartGame;
end;
procedure TForm2.BackgroundMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not GameStarted then
  begin
    GameStarted := True;
    Timer1.Enabled := True;
    HideGameOverElements;
  end;
end;
procedure TForm2.Timer1Timer(Sender: TObject);
var
  i, totalBricks, score: Integer;
  allBricksDestroyed, ballHitBottom: Boolean;
begin
  if not GameStarted then Exit;
  Ball.Left := Ball.Left + dx;
  Ball.Top := Ball.Top + dy;
  totalBricks := 0;
  score := StrToInt(Label5.Caption);
  allBricksDestroyed := True;
  ballHitBottom := False;
  for i := 0 to n - 1 do
  begin
    if Ball.BoundsRect.IntersectsWith(Bricks[i].BoundsRect) and Bricks[i].Visible then
    begin
      dy := -dy;
      Bricks[i].Visible := False;
      Inc(totalBricks);
      Inc(score, 10);
    end;
    if Bricks[i].Visible then
      allBricksDestroyed := False;
  end;
  Label3.Caption := IntToStr(StrToInt(Label3.Caption) + totalBricks);
  Label5.Caption := IntToStr(score);
  if allBricksDestroyed then
  begin
    Image1.Visible := True;
    Image3.Visible := True;
    Image4.Visible := True;
    Timer1.Enabled := False;
    GameStarted := False;
    ResetBall;
  end;
  if Ball.Left <= 0 then
    dx := Abs(dx);
  if Ball.Left + Ball.Width >= ClientWidth then
    dx := -Abs(dx);
  if Ball.Top <= 0 then
    dy := Abs(dy);
  if Ball.BoundsRect.IntersectsWith(Paddle.BoundsRect) then
  begin
    dy := -Abs(dy);
    Image2.Visible := False;
  end
  else if Ball.Top + Ball.Height >= ClientHeight then
  begin
    ballHitBottom := True;
    Image4.Visible := False;
  end;
  if ballHitBottom then
  begin
    Image2.Visible := True;
    Image4.Visible := True;
    Image4.Top := 565;
    Image4.Left := 810;
    Timer1.Enabled := False;
    GameStarted := False;
  end;
end;
procedure TForm2.fonClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  if OpenDialog1.Execute then
  begin
    Timer1.Enabled := True;
    Background.Picture.LoadFromFile(OpenDialog1.FileName);
  end;
end;
procedure TForm2.musicClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  if OpenDialog1.Execute then
  begin
    Timer1.Enabled := True;
    MediaPlayer1.FileName := OpenDialog1.FileName;
    MediaPlayer1.Open;
    MediaPlayer1.Play;
  end;
end;
procedure TForm2.ResetBall;
begin
  Ball.Top := Paddle.Top - Ball.Height;
  Ball.Left := Paddle.Left + (Paddle.Width - Ball.Width) div 2;
end;
procedure TForm2.HideGameOverElements;
begin
  Image1.Visible := False;
  Image2.Visible := False;
  Image3.Visible := False;
  Image4.Visible := False;
end;
procedure TForm2.RestartGame;
var
  i: Integer;
begin
  Level := 1;
  n := 30;
  Paddle.Top := ClientHeight - Paddle.Height - 120;
  ResetBall;
  GameStarted := False;
  Label1.Caption := '������� 1';
  Label2.Caption := '���� 30/';
  Label3.Caption := '0';
  Label5.Caption := '0';
  SetLength(Bricks, n);
  for i := 0 to n - 1 do
  begin
    Bricks[i] := TBrick.Create(Self);
    Bricks[i].Parent := Self;
    Bricks[i].Top := ClientHeight div 2 - (Bricks[i].Height + 5) * 10 + (i div 10) * (Bricks[i].Height + 5);
    Bricks[i].Left := ClientWidth div 2 - (Bricks[i].Width + 5) * 5 + (i mod 10) * (Bricks[i].Width + 5);
  end;
  HideGameOverElements;
  Timer1.Enabled := False;
end;
end.

