package fla.play
{
   import com.ALIB.DynamicEvent;
   import com.AUI.Button;
   import fla.ChallEntry;
   import fla.LevelInfo;
   import fla.play.ui.ScorePart;
   import fla.play.ui.ShotPart;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.utils.setTimeout;
   
   public class ChallUI extends PlayUI
   {
       
      
      public var _back:Button;
      
      public var _share:Button;
      
      public var _restart:Button;
      
      public var _shotPart:ShotPart;
      
      public var _labelPart:Button;
      
      public var _scorePart:ScorePart;
      
      public function ChallUI()
      {
         super();
         _share.addEventListener("click",onClickShare);
         _share.visible = game.shell.shareOpen;
         _labelPart.addEventListener("click",onClickInfo);
         _back.addEventListener("click",onClickBack);
         _restart.addEventListener("click",onClickRestart);
      }
      
      override protected function onAddedToStage(param1:Event) : void
      {
         super.onAddedToStage(param1);
      }
      
      public function init() : void
      {
         _shotPart.init((PlayMain.self as ChallMain).getShots());
         _labelPart.data = PlayMain.self.row.name;
      }
      
      private function onClickInfo(param1:Event) : void
      {
         game.hud.addToCenter(new LevelInfo(PlayMain.self.row));
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
               game.self.setContentView(new ChallEntry(true));
            },1));
         };
         if(PlayMain.self.body.shotCount > 0)
         {
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
         game.hud.confirm(Language.id(7301),function(param1:Boolean):void
         {
            v = param1;
            if(v == false)
            {
               return;
            }
            return;
            §§push(setTimeout(function():void
            {
               var _loc1_:Object = PlayMain.self.row;
               game.self.setContentView(new ChallMain(_loc1_));
            },1));
         });
      }
      
      private function onClickShare(param1:Event) : void
      {
         e = param1;
         game.hud.confirm(Language.id(7302),function(param1:Boolean):void
         {
            v = param1;
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
