package fla.play
{
   import com.adobe.images.PNGEncoder;
   import fla.Guide2;
   import fla.play.__ball.VisualBall;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Matrix;
   import fls.SoundEffect;
   
   public class CreateMain extends PlayMain
   {
      
      public static var mode:int;
       
      
      public var _ui:CreateUI;
      
      public var _body:CreateBody;
      
      public function CreateMain(param1:int)
      {
         super();
         PlayMain.self = this;
         mode = param1;
      }
      
      override protected function onAddedToStage(param1:Event) : void
      {
         super.onAddedToStage(param1);
         SoundEffect.init();
         _ui.init();
         _body.init();
         if(mode == 0)
         {
            enterRackUpMode();
         }
         else
         {
            enterTestMode();
         }
         if(_G.player.getFlagAt(2) == false)
         {
            _G.player.setFlag(2,true);
            game.hud.addToCenter(new Guide2());
         }
      }
      
      override protected function onRemovedFromStage(param1:Event) : void
      {
         super.onRemovedFromStage(param1);
      }
      
      public function enterRackUpMode() : void
      {
         mode = 0;
         _ui._test.enabled = true;
         _ui._shotCustomPart._button.enabled = true;
         _body._cue.visible = false;
         _body._cue.active = false;
         _body._spin.lock = true;
         _body._halo.stop();
         var _loc2_:Array = _body._table.visualBalls;
         var _loc4_:int = 0;
         var _loc3_:* = _loc2_;
         for each(var _loc1_ in _loc2_)
         {
            _loc1_.logicalBall.movable = true;
         }
      }
      
      public function enterTestMode() : void
      {
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:PNGEncoder = new PNGEncoder();
         _loc3_ = new BitmapData(665,375,true,0);
         _loc5_ = new Matrix();
         _loc5_.translate(-42,-44);
         _loc3_.draw(_body,_loc5_);
         _loc5_ = new Matrix();
         _loc5_.scale(0.240601503759398,0.24);
         _loc6_ = new BitmapData(160,90,true,0);
         _loc6_.draw(_loc3_,_loc5_);
         mode = 1;
         _ui._test.enabled = false;
         _ui._shotCustomPart._button.enabled = false;
         _ui._image = PNGEncoder.encode(_loc6_);
         _body._cue.moveToCueBall();
         _body._cue.visible = true;
         _body._cue.active = true;
         _body._spin.lock = false;
         _body.shineHalo();
         var _loc2_:Array = _body._table.visualBalls;
         var _loc8_:int = 0;
         var _loc7_:* = _loc2_;
         for each(var _loc1_ in _loc2_)
         {
            _loc1_.logicalBall.movable = false;
         }
      }
      
      override public function get body() : PlayBody
      {
         return _body;
      }
      
      override public function get ui() : PlayUI
      {
         return _ui;
      }
      
      override public function getGameMode() : int
      {
         return 2;
      }
      
      override public function getLayout() : Array
      {
         return _G.player.model.createLayout;
      }
   }
}
