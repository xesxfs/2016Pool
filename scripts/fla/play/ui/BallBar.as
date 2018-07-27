package fla.play.ui
{
   import com.greensock.TweenMax;
   import fla.play.__ball.FaceTool;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   
   public class BallBar extends Sprite
   {
       
      
      public var _balls:Sprite;
      
      public function BallBar()
      {
         super();
         addEventListener("addedToStage",onAddedToStage);
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         removeEventListener("addedToStage",onAddedToStage);
         _balls = new Sprite();
         _loc4_ = 0;
         while(_loc4_ < 9)
         {
            _loc2_ = this.getChildAt(_loc4_);
            FaceTool.setSize(12);
            _loc3_ = new Bitmap(FaceTool.drawByNo(_loc4_ + 1));
            _loc3_.smoothing = true;
            _loc3_.x = _loc2_.x + 3;
            _loc3_.y = _loc2_.y + 2;
            _loc3_.alpha = 0.25;
            _loc3_.filters = [new ColorMatrixFilter([0.3,0.6,0,0,0,0.3,0.6,0,0,0,0.3,0.6,0,0,0,0,0,0,1,0])];
            _balls.addChild(_loc3_);
            _loc4_++;
         }
         addChild(_balls);
      }
      
      public function shine(param1:int) : void
      {
         if(param1 == 0)
         {
            return;
         }
         var _loc2_:Bitmap = _balls.getChildAt(param1 - 1) as Bitmap;
         _loc2_.filters = null;
         _loc2_.alpha = 0;
         TweenMax.to(_loc2_,0.8,{"alpha":1});
      }
   }
}
