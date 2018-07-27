package fla.play
{
   import com.ALIB.DynamicEvent;
   import com.AUI.Button;
   import fla.Home;
   import fla.play.ui.ComboPart;
   import fla.play.ui.CountDownPart;
   import fla.play.ui.ScorePart;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.utils.setTimeout;
   
   public class FreeUI extends PlayUI
   {
       
      
      public var _back:Button;
      
      public var _share:Button;
      
      public var _restart:Button;
      
      public var _scorePart:ScorePart;
      
      public var _comboPart:ComboPart;
      
      public var _countDownPart:CountDownPart;
      
      public function FreeUI()
      {
         super();
         _share.addEventListener("click",onClickShare);
         _share.visible = game.shell.shareOpen;
         _back.addEventListener("click",onClickBack);
         _restart.addEventListener("click",onClickRestart);
      }
      
      override protected function onAddedToStage(param1:Event) : void
      {
         super.onAddedToStage(param1);
      }
      
      public function init() : void
      {
         _countDownPart.start(240,onTimeEnd);
      }
      
      private function onTimeEnd() : void
      {
         PlayMain.self.body._rule.gameOver(0);
      }
      
      private function onClickBack(param1:Event) : void
      {
         e = param1;
         var func:Function = function(param1:Boolean):void
         {
            v = param1;
            _countDownPart.pause(false);
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
         if(PlayMain.self.body.shotCount > 0)
         {
            _countDownPart.pause(true);
            game.hud.confirm(Language.id(7300),func);
         }
         else
         {
            func(true);
         }
      }
      
      private function onClickRestart(param1:Event) : void
      {
         e = param1;
         _countDownPart.pause(true);
         game.hud.confirm(Language.id(7301),function(param1:Boolean):void
         {
            v = param1;
            _countDownPart.pause(false);
            if(v == false)
            {
               return;
            }
            return;
            §§push(setTimeout(function():void
            {
               var _loc1_:Object = PlayMain.self.row;
               game.self.setContentView(new FreeMain());
            },1));
         });
      }
      
      private function onClickShare(param1:Event) : void
      {
         e = param1;
         _countDownPart.pause(true);
         game.hud.confirm(Language.id(7302),function(param1:Boolean):void
         {
            v = param1;
            _countDownPart.pause(false);
            if(v == false)
            {
               return;
            }
            return;
            §§push(setTimeout(function():void
            {
               _share.visible = false;
               PlayMain.self._bg.visible = true;
               var _loc2_:BitmapData = new BitmapData(game.w,game.h);
               _loc2_.draw(root);
               var _loc1_:DynamicEvent = new DynamicEvent("SHARE_SHOW");
               _loc1_.body = _loc2_;
               root.dispatchEvent(_loc1_);
               _share.visible = true;
               PlayMain.self._bg.visible = false;
            },1));
         });
      }
   }
}
