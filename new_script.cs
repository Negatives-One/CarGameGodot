using Godot;
using System;
using System.Runtime.CompilerServices;

public class new_script : Node
{
    [Export] private float value = 0f;
    public override void _Ready()
    {
        GD.Print("UAAAAAAAAAAAA");
    }

    public override void _Process(float delta)
    {
        
    }

    public override void _PhysicsProcess(float delta)
    {
        
    }

    public override void _Input(InputEvent @event)
    {
        
    }
}
