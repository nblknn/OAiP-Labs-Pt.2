Library LIBRARY5_1;

Uses
    System.SysUtils;

Type
    TStackPointer = ^TStack;

    TStack = Record
        Num: Integer;
        Next: TStackPointer;
    End;

Var
    Head: TStackPointer;

Procedure CreateStack();
Begin
    New(Head);
    Head.Next := Nil;
End;

Procedure StackPush(Num: Integer);
Var
    NewElement: TStackPointer;
Begin
    New(NewElement);
    NewElement.Num := Num;
    NewElement.Next := Head;
    Head := NewElement;
End;

Function StackPop(): Integer;
Var
    DeletedElement: TStackPointer;
Begin
    DeletedElement := Head;
    Head := DeletedElement.Next;
    StackPop := DeletedElement.Num;
    Dispose(DeletedElement);
End;

Procedure DestroyStack();
Begin
    While (Head <> Nil) Do
        StackPop();
    Dispose(Head);
End;

{$R *.res}

Exports CreateStack, StackPush, StackPop, DestroyStack;

Begin

End.
