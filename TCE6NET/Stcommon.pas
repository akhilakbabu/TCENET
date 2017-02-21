unit Stcommon;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs, SysUtils,Messages,TCEglobals, GlobalToTcAndTcextra;

function checkGrSub(a:string): integer;
function CountStudWithSub(place:integer):integer;
function CalcIDlen:smallint;

//Procedure CheckCurrentYear;

implementation

uses     tcommon,tcommon2,main;

function checkGrSub(a:string): integer;
var
 i:  integer;
begin
 result:=0;
 for i:=1 to GroupSubs[0] do
  if subcode[GroupSubs[i]]=a then
   begin
    result:=i;
    break;
   end;
end;


function CountStudWithSub(place:integer):integer;
var
 i,j:     smallint;
begin
 result:=0;
 if place=0 then exit;
 for i:=1 to numstud do
  for j:=1 to chmax do
   if place=Stud[i].Choices[j] then
    begin
     inc(result);
     break;
    end;
end;

function CalcIDlen: smallint;
var
  i,IDlen:    smallint;
begin
 IDlen:=1;
 for i:=0 to years-1 do
  if IDlen<yearStat[i].IDlen then IDlen:=yearStat[i].IDlen;
 if IDlen>szID then IDlen:=szID;
 result:=IDlen;
end;



end.
