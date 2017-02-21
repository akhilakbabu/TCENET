unit Tcommon4;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs, SysUtils,Messages,grids,Ttable,TCEglobals;

procedure Etsort2;
procedure Etsort3;
procedure CountETnum1;

implementation
uses tcommon,tcommon2,main,newclass,lostclss,mrgclass,
     unavalro,roomswap,curextra,adstfsel,astfsldg,printers,pstextra,
     findte,teshow,findro,roshow,abtes;


procedure CountETnum1;
var
 i:       integer;
 astr:    string;
begin
 Etnum1:=0;
 if Etnum>0 then
  for i:=1 to Etnum do
   begin
    astr:=copy(etsub[i],1,2);
    if astr<>'00' then
     begin
      inc(Etnum1);
      Etpointer[Etnum1]:=i;
     end;
   end; {for i}
end;


procedure Etnumbers2;
var
 i,j:       integer;
 astr:    string;
begin
 Etnum1:=0;
 if Etnum>0 then
  for i:=1 to Etnum do
   begin
    J:=Etpointer2[i];
    astr:=copy(etsub[j],1,2);
    if astr<>'00' then
     begin
      inc(Etnum1);
      Etpointer2[Etnum1]:=J;
     end;
   end; {for i}
end;

function getfacname(a:integer): string;
begin
 result:='';
 if a=-1 then result:='All Faculties'
   else if (a>0) and (a<=FacNum)
     then result:=facName[a];
end;


procedure Etsort2;
var
 i,D,H,J,L,A,B:       integer;
 tmpstr1,tmpstr2:     string;

label  label1,label2,label3,label4;

begin
 CountETnum1;
 if Etnum1=0 then exit;
 if assorttype=0 then assorttype:=1;
 if assorttype=5 then assorttype:=6;
 
 D:=1;
label1:
 inc(D,D);
 if D<Etnum1 then goto label1;
label4:
 D:=(D-1) div 2;
 if D=0 then goto label2;      // Note this sort wont work if only 2 items
 H:=Etnum1-D;
 for i:=1 to H do
 begin
  J:=i;
label3:
  L:=J+D;
  A:=Etpointer[L]; B:=Etpointer[J];
    case assorttype of
     1: begin
         tmpStr1:=uppercase(etsub[A]);
         tmpStr2:=uppercase(etsub[B]);
        end;
     2: begin
         tmpStr1:=uppercase(ETname[A]);
         tmpStr2:=uppercase(ETname[B]);
        end;
     3: begin
         tmpStr1:=uppercase(Etcomment[A]);
         tmpStr2:=uppercase(Etcomment[B]);
        end;
     4: begin
         tmpStr1:=uppercase(getfacname(ETfaculty[A]));
         tmpStr2:=uppercase(getfacname(ETfaculty[B]));
        end;
     6: begin
         tmpStr1:=inttostr(ETPriority[A])+uppercase(etsub[A]);
         tmpStr2:=inttostr(ETPriority[B])+uppercase(etsub[B]);
        end;
     7: begin
         tmpStr1:=inttostr(ETPriority[A])+uppercase(ETname[A]);
         tmpStr2:=inttostr(ETPriority[B])+uppercase(ETname[B]);
        end;
     8: begin
         tmpStr1:=inttostr(ETPriority[A])+uppercase(Etcomment[A]);
         tmpStr2:=inttostr(ETPriority[B])+uppercase(Etcomment[B]);
        end;
     9: begin
         tmpStr1:=inttostr(ETPriority[A])+uppercase(getfacname(ETfaculty[A]));
         tmpStr2:=inttostr(ETPriority[B])+uppercase(getfacname(ETfaculty[B]));
        end;
    end; {case}

  if tmpStr1<tmpStr2 then
  begin
   Etpointer[J]:=A;
   Etpointer[L]:=B;
   dec(J,D);
   if J>0 then goto label3;
  end;
 end; {for i}
 goto label4;
label2: {"end sort"}
end;

procedure Etsort3;
var
 i,D,H,J,L,A,B:       integer;
 tmpstr1,tmpstr2:     string;

label  label1,label2,label3,label4;

begin
 if Etnum=0 then
 begin
  Etnum1:=0;
  exit;
 end;
 for i:=1 to Etnum do Etpointer2[i]:=i;
 if asselsorttype=0 then asselsorttype:=1;
 if asselsorttype=5 then asselsorttype:=6;
 
 D:=1;
label1:
 inc(D,D);
 if D<Etnum then goto label1;
label4:
 D:=(D-1) div 2;
 if D=0 then goto label2;
 H:=Etnum-D;
 for i:=1 to H do
 begin
  J:=i;
label3:
  L:=J+D;
  A:=Etpointer2[L]; B:=Etpointer2[J];
    case asselsorttype of
     1: begin
         tmpStr1:=uppercase(etsub[A]);
         tmpStr2:=uppercase(etsub[B]);
        end;
     2: begin
         tmpStr1:=uppercase(ETname[A]);
         tmpStr2:=uppercase(ETname[B]);
        end;
     3: begin
         tmpStr1:=uppercase(Etcomment[A]);
         tmpStr2:=uppercase(Etcomment[B]);
        end;
     4: begin
         tmpStr1:=uppercase(getfacname(ETfaculty[A]));
         tmpStr2:=uppercase(getfacname(ETfaculty[B]));
        end;
     6: begin
         tmpStr1:=inttostr(ETPriority[A])+uppercase(etsub[A]);
         tmpStr2:=inttostr(ETPriority[B])+uppercase(etsub[B]);
        end;
     7: begin
         tmpStr1:=inttostr(ETPriority[A])+uppercase(ETname[A]);
         tmpStr2:=inttostr(ETPriority[B])+uppercase(ETname[B]);
        end;
     8: begin
         tmpStr1:=inttostr(ETPriority[A])+uppercase(Etcomment[A]);
         tmpStr2:=inttostr(ETPriority[B])+uppercase(Etcomment[B]);
        end;
     9: begin
         tmpStr1:=inttostr(ETPriority[A])+uppercase(getfacname(ETfaculty[A]));
         tmpStr2:=inttostr(ETPriority[B])+uppercase(getfacname(ETfaculty[B]));
        end;
    end; {case}

  if tmpStr1<tmpStr2 then
  begin
   Etpointer2[J]:=A;
   Etpointer2[L]:=B;
   dec(J,D);
   if J>0 then goto label3;
  end;
 end; {for i}
 goto label4;
label2: {"end sort"}
 Etnumbers2;
end;

end.
