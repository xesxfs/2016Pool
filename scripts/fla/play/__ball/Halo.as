package fla.play.__ball
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   
   public class Halo extends Sprite
   {
      
      private static const __Hh:Number = 2000;
       
      
      public function Halo(param1:Number)
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         graphics.lineStyle(2,16777215);
         graphics.drawCircle(-0.5,-0.5,param1);
         this.alpha = 0.9;
      }
      
      public function start() : void
      {
         this.visible = true;
         this.alpha = 0.8;
         this.scaleX = 1;
         this.scaleY = 1;
         TweenMax.to(this,0.8,{
            "alpha":0,
            "scaleX":2,
            "scaleY":2,
            "repeatDelay":0.6,
            "repeat":2147483647
         });
      }
      
      public function stop() : void
      {
         TweenMax.killTweensOf(this);
         this.visible = false;
      }
   }
}
