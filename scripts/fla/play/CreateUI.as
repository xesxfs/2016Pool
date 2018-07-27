package fla.play
{
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import fla.Home;
   import fla.play.__ball.VisualBall;
   import fla.play.ui.ShotCustomPart;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class CreateUI extends PlayUI
   {
       
      
      public var _test:Button;
      
      public var _restart:Button;
      
      public var _shotCustomPart:ShotCustomPart;
      
      public var _back:Button;
      
      public var _image:ByteArray;
      
      public function CreateUI()
      {
         super();
         _test.addEventListener(AuiDefine.CLICK,onClickTest);
         _restart.addEventListener(AuiDefine.CLICK,onClickReset);
         _back.addEventListener(AuiDefine.CLICK,onClickBack);
      }
      
      override protected function onAddedToStage(param1:Event) : void
      {
         super.onAddedToStage(param1);
      }
      
      public function init() : void
      {
         _shotCustomPart.init(_G.player.model.createShots);
      }
      
      private function onClickBack(param1:Event) : void
      {
         e = param1;
         var func:Function = function(param1:Boolean):void
         {
            v = param1;
            if(v == false)
            {
               return;
            }
            return;
            §§push(setTimeout(function():void
            {
               game.self.setContentView(new Home());
            },1));
         };
         if(_test.enabled == true)
         {
            game.hud.confirm(Language.id(7300),func);
         }
         else
         {
            func(true);
         }
      }
      
      private function onClickReset(param1:Event) : void
      {
         CreateMain.mode = 0;
         PlayMain.self.body.onReplay(null);
      }
      
      private function onClickTest(param1:Event) : void
      {
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Array = _G.player.model.createLayout;
         var _loc4_:Array = PlayMain.self.body._table.visualBalls;
         _loc9_ = 0;
         _loc8_ = _loc4_.length;
         while(_loc9_ < _loc8_)
         {
            _loc3_ = _loc4_[_loc9_];
            _loc2_ = new Point(_loc3_.logicalBall.position.x,_loc3_.logicalBall.position.y);
            _loc2_ = PlayBody.centerPos.getVisualPoint(_loc2_);
            _loc5_ = parseFloat(_loc2_.x.toFixed(3));
            _loc6_ = parseFloat(_loc2_.y.toFixed(3));
            _loc7_[_loc9_ * 2 + 0] = _loc5_;
            _loc7_[_loc9_ * 2 + 1] = _loc6_;
            _loc9_++;
         }
         (PlayMain.self as CreateMain).enterTestMode();
      }
   }
}
