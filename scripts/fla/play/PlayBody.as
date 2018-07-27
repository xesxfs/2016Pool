package fla.play
{
   import com.AUI.AuiDefine;
   import com.adobe.images.PNGEncoder;
   import com.greensock.TweenMax;
   import fla.play.__ball.Halo;
   import fla.play.__ball.LogicalBall;
   import fla.play.__ball.Position;
   import fla.play.__ball.Table#214;
   import fla.play.__ball.VisualBall;
   import fla.play.__components.__HQ;
   import fla.play.__cue.Cue;
   import fla.play.__cue.CueEvent;
   import fla.play.__locale.BallLocale;
   import fla.play.__locale.__Fn;
   import fla.play.__rule.BallRule9;
   import fla.play.__rule.events.GameEvent;
   import fla.play.__world.CollisionEvent;
   import fla.play.__world.PocketEvent;
   import fla.play.effect.PotEffect;
   import fla.play.ui.Spin;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.net.FileReference;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import fls.SoundEffect;
   
   public class PlayBody extends Sprite
   {
      
      private static const __0y:Boolean = false;
      
      public static var centerPos:Position;
       
      
      public var _rule:BallRule9;
      
      public var _cue:Cue;
      
      public var _table:Table#214;
      
      public var backdrop:Sprite;
      
      public var railCanvas:Sprite;
      
      public var _halo:Halo;
      
      public var _spin:Spin;
      
      private var __Fw:Sprite;
      
      private var _allowDrag:Sprite;
      
      private var __Ad:__HQ;
      
      public var shotCount:int = 0;
      
      public var turnCount:int = 0;
      
      public function PlayBody()
      {
         super();
         centerPos = new Position(new Point(375,232),2.285);
         __Fw = new Sprite();
         addEventListener("addedToStage",onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         addEventListener("removedFromStage",onRemovedFromStage);
      }
      
      public function init() : void
      {
         _allowDrag = new Sprite();
         _table.canvas.addChild(_allowDrag);
         _spin = PlayMain.self.ui._spin;
         addChild(__Fw);
         ballRule = new BallRule9();
         _rule.reset();
         _rule.world.addEventListener("tableBallBallCollision",onBallBallCollision);
         _rule.world.addEventListener("tableBallCushionCollision",onBallCushionCollision);
         _rule.world.addEventListener("shotFin",onShotFin);
         _rule.world.addEventListener("shotMiss",onShotMiss);
         _rule.world.addEventListener("shotNotPot",onShotNotPot);
         _rule.world.addEventListener("ballEnteredPocket",onPot);
         _rule.addEventListener("rackup",onRackUp);
         _rule.addEventListener("turnGivenTo",onTurnTo);
         _rule.addEventListener("gameOverWinnerIs",onGameOver);
         _halo = new Halo((_table.visualBalls[0] as VisualBall).radius);
         _halo.visible = false;
         addChild(_halo);
         _cue.power = 0;
         _cue.visible = false;
         _cue.active = false;
         _spin.lock = false;
         _rule.world.__6m();
         _rule.newGame();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         removeEventListener("removedFromStage",onRemovedFromStage);
         _halo.stop();
         _halo.visible = false;
      }
      
      private function xxx(param1:KeyboardEvent) : void
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1.keyCode == 32)
         {
            _halo.visible = false;
            _loc2_ = new BitmapData(665,375,true,0);
            _loc5_ = new Matrix();
            _loc5_.translate(-42,-44);
            _loc2_.draw(this,_loc5_);
            _loc3_ = new PNGEncoder();
            _loc4_ = new FileReference();
            _loc4_.save(PNGEncoder.encode(_loc2_));
         }
      }
      
      private function onBallCushionCollision(param1:CollisionEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = param1.array;
         for each(_loc3_ in param1.array)
         {
            _loc2_ = Number(_loc2_ + _loc3_.force);
         }
         SoundEffect.playBallCushionCollision(_loc2_);
      }
      
      private function onBallBallCollision(param1:CollisionEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = param1.array;
         for each(_loc3_ in param1.array)
         {
            _loc2_ = Number(_loc2_ + _loc3_.force);
         }
         SoundEffect.playBallBallCollision(_loc2_);
      }
      
      private function onCueShot(param1:CueEvent) : void
      {
         shotCount = Number(shotCount) + 1;
         SoundEffect.playCueCollision(_cue.power);
         var _loc2_:Number = _cue.power;
         var _loc3_:Number = _cue.logicalRotation;
         _rule.init(_loc2_,_loc3_,_spin.__D6,_spin.__61);
         _cue.active = false;
         _cue.visible = false;
         _cue.power = 0;
         _spin.reset();
      }
      
      protected function onShotFin(param1:Event) : void
      {
         _halo.stop();
      }
      
      protected function onShotMiss(param1:Event) : void
      {
      }
      
      protected function onShotNotPot(param1:Event) : void
      {
      }
      
      protected function onPot(param1:PocketEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         SoundEffect.playPocket();
         if(param1.ball.number != 0)
         {
            _loc2_ = _table.visualBalls[param1.ball.number];
            _loc3_ = new PotEffect();
            _loc3_.x = _loc2_.face.x;
            _loc3_.y = _loc2_.face.y;
            addChild(_loc3_);
            PlayMain.self.ui._ballBar.shine(param1.ball.number);
         }
      }
      
      public function onReplay(param1:Event) : void
      {
      }
      
      protected function onRackUp(param1:GameEvent) : void
      {
         SoundEffect.playRack();
      }
      
      protected function onTurnTo(param1:GameEvent) : void
      {
         turnCount = Number(turnCount) + 1;
         initShot();
      }
      
      protected function onGameOver(param1:GameEvent) : void
      {
         _cue.visible = false;
         _cue.active = false;
         _spin.lock = true;
      }
      
      protected function onBallDragBegin(param1:Event) : void
      {
      }
      
      protected function onBallDraging(param1:Event) : void
      {
         var _loc3_:Point = new Point(stage.mouseX,stage.mouseY);
         _loc3_ = root.globalToLocal(_loc3_);
         var _loc2_:LogicalBall = (param1.target as VisualBall).logicalBall;
         respotBall(_loc2_,centerPos.getLogicalX(_loc3_.x),centerPos.getLogicalY(_loc3_.y));
      }
      
      protected function onBallDragEnd(param1:Event) : void
      {
      }
      
      protected function onBallStateChanged(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1.target is LogicalBall)
         {
            _loc2_ = param1.target as LogicalBall;
            _loc3_ = _table.visualBalls[_loc2_.number];
            if(_loc2_.movable)
            {
               __Fw.addChild(_loc3_.ballInHandSprite);
            }
            else
            {
               __Fw.removeChild(_loc3_.ballInHandSprite);
            }
         }
      }
      
      public function shineHalo() : void
      {
         _halo.x = centerPos.getVisualXPosition(_rule.lowestBall.position.x);
         _halo.y = centerPos.getVisualYPosition(_rule.lowestBall.position.y);
         _halo.start();
      }
      
      public function showSimplePanel(param1:String, param2:int = 20, param3:int = 16777215, param4:int = 13369344, param5:Number = 1) : void
      {
         var _loc13_:Sprite = new Sprite();
         var _loc7_:TextField = new TextField();
         _loc7_.mouseEnabled = false;
         _loc7_.autoSize = "left";
         _loc7_.defaultTextFormat = new TextFormat("_sans",param2,param3,null,null,null,null,null,"center");
         _loc7_.htmlText = param1.replace("\r\n","\n");
         _loc7_.x = 8;
         _loc7_.y = 4;
         var _loc9_:int = 8 + _loc7_.width + 8;
         var _loc11_:int = 4 + _loc7_.height + 4;
         var _loc12_:Sprite = new Sprite();
         _loc12_.graphics.beginFill(param4,param5);
         _loc12_.graphics.drawRoundRect(0,0,_loc9_,_loc11_,10,10);
         _loc13_.addChild(_loc12_);
         _loc13_.addChild(_loc7_);
         _loc13_.alpha = 0.2;
         _loc13_.x = int((game.w - _loc13_.width) / 2);
         _loc13_.y = _table._canvas.y + int((_table._canvas.height - _loc13_.height) / 2);
         _loc13_.mouseEnabled = false;
         _loc13_.mouseChildren = false;
         this.addChild(_loc13_);
         _table.filters = [new ColorMatrixFilter([0.3,0.6,0,0,0,0.3,0.6,0,0,0,0.3,0.6,0,0,0,0,0,0,1,0])];
         this.addEventListener(AuiDefine.CLICK,onReplay);
         TweenMax.to(_loc13_,0.3,{"alpha":1});
      }
      
      public function initShot() : void
      {
         _cue.moveToCueBall();
         _cue.power = 0;
         _cue.visible = true;
         _cue.active = true;
         _spin.visible = true;
      }
      
      private function respotBall(param1:LogicalBall, param2:Number, param3:Number) : void
      {
         if(ballRule == null)
         {
            return;
         }
         ballRule.world.respotBall(param1,param2,param3,3);
      }
      
      public function set ballRule(param1:BallRule9) : void
      {
         var _loc6_:* = null;
         var _loc2_:* = null;
         if(_rule != null)
         {
            return;
         }
         _rule = param1;
         var _loc5_:Bitmap = Asset.getBitmapBy(Asset.CueTextureFile);
         _cue = new Cue(_loc5_.bitmapData,_rule.world,centerPos,this);
         _cue.addEventListener("shoot",onCueShot);
         PlayMain.self.addChild(_cue);
         PlayMain.self.addChild(_cue.visualGuide);
         if(_table != null)
         {
            _table.initBalls = param1.world.balls;
            _table.renderBalls();
            var _loc8_:int = 0;
            var _loc7_:* = _table.visualBalls;
            for each(_loc6_ in _table.visualBalls)
            {
               _loc6_.addEventListener("visualBallDraggedBegin",onBallDragBegin);
               _loc6_.addEventListener("visualBallDragged",onBallDraging);
               _loc6_.addEventListener("visualBallDraggedEnd",onBallDragEnd);
               _loc2_ = _loc6_.logicalBall;
               _loc2_.addEventListener("ballMovableStateChanged",onBallStateChanged);
            }
         }
      }
      
      public function get ballRule() : BallRule9
      {
         return _rule;
      }
   }
}
