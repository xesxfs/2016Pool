package fla.play.__rule
{
   import fla.play.__world.World;
   import flash.events.IEventDispatcher;
   
   public interface IBallGame extends IEventDispatcher
   {
       
      
      function init(param1:Number, param2:Number, param3:Number, param4:Number) : void;
      
      function newGame() : void;
      
      function rackUp() : void;
      
      function get world() : World;
   }
}
