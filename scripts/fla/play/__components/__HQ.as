package fla.play.__components
{
   import fla.play.__ball.Position;
   import flash.display.Sprite;
   
   public class __HQ extends Sprite
   {
       
      
      public function __HQ(param1:Array, param2:Position)
      {
         super();
         graphics.lineStyle(1,16777215);
         graphics.moveTo(param2.getVisualXPosition(param1[0].x),param2.getVisualYPosition(param1[0].y));
         var _loc3_:* = 1;
         while(_loc3_ < param1.length)
         {
            graphics.lineTo(param2.getVisualXPosition(param1[_loc3_].x),param2.getVisualYPosition(param1[_loc3_].y));
            _loc3_++;
         }
         graphics.lineTo(param2.getVisualXPosition(param1[0].x),param2.getVisualYPosition(param1[0].y));
      }
   }
}
