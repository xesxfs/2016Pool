package fla.play.__components
{
   import fla.play.__ball.Position;
   import flash.display.Sprite;
   
   public class __0V extends Sprite
   {
       
      
      public function __0V(param1:Number, param2:Array, param3:Position)
      {
         super();
         graphics.lineStyle(1,65280);
         var _loc4_:* = 0;
         while(_loc4_ < param2.length)
         {
            graphics.drawCircle(param3.getVisualXPosition(param2[_loc4_].x),param3.getVisualYPosition(param2[_loc4_].y),param3.__A2(param1));
            _loc4_++;
         }
      }
   }
}
