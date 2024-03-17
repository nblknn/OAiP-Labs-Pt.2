Library LIBRARY5_2;

Uses
    System.SysUtils, Vcl.ExtCtrls, Vcl.Graphics, Vcl.ComCtrls;

Type
    PNode = ^TNode;

    TNode = Record
        Value: Integer;
        Right, Left: PNode;
    End;

Var
    Root: PNode = Nil;

Procedure CreateTree(RootValue: Integer);
Begin
    New(Root);
    Root.Value := RootValue;
    Root.Right := Nil;
    Root.Left := Nil;
End;

Procedure FindPlace(Node, NewNode: PNode);
Begin
    If NewNode.Value > Node.Value Then
        If Node.Right <> Nil Then
            FindPlace(Node.Right, NewNode)
        Else
            Node.Right := NewNode
    Else If Node.Left <> Nil Then
        FindPlace(Node.Left, NewNode)
    Else
        Node.Left := NewNode
End;

Procedure AddNode(Value: Integer);
Var
    NewNode: PNode;
Begin
    New(NewNode);
    NewNode.Value := Value;
    NewNode.Right := Nil;
    NewNode.Left := Nil;
    FindPlace(Root, NewNode);
End;

Procedure DestroyNode(Var Node: PNode);
Begin
    If Node.Right <> Nil Then
        DestroyNode(Node.Right);
    If Node.Right = Nil Then
    Begin
        If Node.Left <> Nil Then
            DestroyNode(Node.Left);
        If Node.Left = Nil Then
        Begin
            Dispose(Node);
            Node := Nil;
        End
    End;
End;

Procedure DestroyTree();
Begin
    DestroyNode(Root);
End;

Function IsValueInTree(Value: Integer): Boolean;
Var
    Temp: PNode;
    IsInTree: Boolean;
Begin
    IsInTree := False;
    If Root <> Nil Then
    Begin
        Temp := Root;
        While (Temp <> Nil) And Not IsInTree Do
        Begin
            If Value = Temp.Value Then
                IsInTree := True
            Else If Value > Temp.Value Then
                Temp := Temp.Right
            Else
                Temp := Temp.Left;
        End;
    End;
    IsValueInTree := IsInTree;
End;

Function FindTreeHeight(Node: PNode): Integer;
Var
    LeftHeight, RightHeight: Integer;
Begin
    If Node = Nil Then
        FindTreeHeight := 0
    Else
    Begin
        LeftHeight := FindTreeHeight(Node.Left);
        RightHeight := FindTreeHeight(Node.Right);
        If (RightHeight < LeftHeight) Then
            FindTreeHeight := LeftHeight + 1
        Else
            FindTreeHeight := RightHeight + 1;
    End;
End;

Function FindNodeHeight(Value: Integer): Integer;
Var
    NodeHeight: Integer;
    Temp: PNode;
Begin
    NodeHeight := 1;
    Temp := Root;
    While Temp <> Nil Do
    Begin
        If Value > Temp.Value Then
            Temp := Temp.Right
        Else
            Temp := Temp.Left;
        Inc(NodeHeight);
    End;
    FindNodeHeight := NodeHeight;
End;

/// //////////////////////VISUALISATION/////////////////////////////////////
Type
    TCoordinates = Record
        X, Y: Integer;
    End;

Const
    Offset: Array [1 .. 7] Of Integer = (1, 2, 3, 6, 12, 24, 48);
    Radius = 20;

Var
    RootCoord: TCoordinates = (X: Radius + 5; Y: Radius + 5);

Procedure DrawNode(Value: Integer; Image: TImage; Coord: TCoordinates);
Begin
    With Image.Canvas Do
        With Coord Do
        Begin
            Ellipse(X - 20, Y - 20, X + 20, Y + 20);
            TextOut((X - 4) - (Length(IntToStr(Value)) - 1) * 4, Y - 10,
              IntToStr(Value));
            Draw(0, 0, Image.Picture.Bitmap);
        End;
End;

Procedure DrawTree(Node: PNode; ParentCoord: TCoordinates; TreeHeight: Integer;
  Image: TImage);
Var
    Coord: TCoordinates;
Begin
    If Node.Left <> Nil Then
        With Coord Do
        Begin
            X := ParentCoord.X - Radius * Offset[TreeHeight];
            Y := ParentCoord.Y + 60;
            With Image.Canvas Do
            Begin
                MoveTo(ParentCoord.X - Radius, ParentCoord.Y);
                LineTo(X, Y - Radius);
                DrawNode(Node.Left.Value, Image, Coord);
            End;
            DrawTree(Node.Left, Coord, TreeHeight - 1, Image);
        End;
    If Node.Right <> Nil Then
        With Coord Do
        Begin
            X := ParentCoord.X + Radius * Offset[TreeHeight];
            Y := ParentCoord.Y + 60;
            With Image.Canvas Do
            Begin
                MoveTo(ParentCoord.X + Radius, ParentCoord.Y);
                LineTo(X, Y - Radius);
                DrawNode(Node.Right.Value, Image, Coord);
            End;
            DrawTree(Node.Right, Coord, TreeHeight - 1, Image);
        End;
End;

Procedure VisualizeTree(Image: TImage);
Var
    TreeHeight: Integer;
Begin
    With Image Do
    Begin
        Height := 420;
        Width := 3850;
        Canvas.Brush.Color := Clwhite;
        Canvas.Rectangle(0, 0, Width - 1, Height - 1);
    End;
    TreeHeight := FindTreeHeight(Root);
    If TreeHeight > 1 Then
        RootCoord.X := Offset[TreeHeight] * Radius * 2 + 5;
    DrawNode(Root.Value, Image, RootCoord);
    DrawTree(Root, RootCoord, TreeHeight, Image);
End;

Procedure WriteNodeToFile(Node: PNode; Offset: String; NodeType: Char;
  Var FOut: TextFile);
Begin
    Writeln(FOut, Offset, '[', NodeType, '] ', Node.Value);
    If (Node.Right <> Nil) Then
        WriteNodeToFile(Node.Right, Offset + '  ', 'R', FOut);
    If (Node.Left <> Nil) Then
        WriteNodeToFile(Node.Left, Offset + '  ', 'L', FOut);
End;

Procedure WriteTreeToFile(Var FOut: TextFile);
Begin
    WriteNodeToFile(Root, '', '-', FOut);
End;
/// //////////////////////TASK///////////////////////////////////

Procedure AddNodeToListView(ListView: TListView;
  NodeValue, RightChildren, LeftChildren: Integer);
Var
    NewItem: TListItem;
Begin
    NewItem := ListView.Items.Add;
    NewItem.Caption := IntToStr(NodeValue);
    With NewItem.SubItems Do
    Begin
        Add(IntToStr(LeftChildren));
        Add(IntToStr(RightChildren));
    End;
End;

Procedure CountChildren(Node: PNode; Var CurCount: Integer);
Begin
    If Node = Nil Then
        CurCount := 0
    Else
    Begin
        If Node.Right <> Nil Then
        Begin
            Inc(CurCount);
            CountChildren(Node.Right, CurCount);
        End;
        If Node.Left <> Nil Then
        Begin
            Inc(CurCount);
            CountChildren(Node.Left, CurCount);
        End;
    End;
End;

Procedure FindUnequalNodes(Node: PNode; ListView: TListView);
Var
    RightChildren, LeftChildren: Integer;
Begin
    RightChildren := 1;
    LeftChildren := 1;
    CountChildren(Node.Right, RightChildren);
    CountChildren(Node.Left, LeftChildren);
    If RightChildren <> LeftChildren Then
        AddNodeToListView(ListView, Node.Value, RightChildren, LeftChildren);
    If Node.Right <> Nil Then
        FindUnequalNodes(Node.Right, ListView);
    If Node.Left <> Nil Then
        FindUnequalNodes(Node.Left, ListView);
End;

Procedure ShowUnequalNodes(ListView: TListView);
Var
    I: Integer;
Begin
    For I := ListView.Items.Count - 1 DownTo 0 Do
        ListView.Items[I].Delete;
    If Root <> Nil Then
        FindUnequalNodes(Root, ListView);
End;

{$R *.res}

Exports CreateTree, AddNode, DestroyTree, IsValueInTree, FindNodeHeight, VisualizeTree,
    WriteTreeToFile, ShowUnequalNodes;

Begin

End.
