package fla
{
   import com.ALIB.DynamicEvent;
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import com.AUI.Window;
   import fla.role.Player;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.text.TextField;
   
   public class Profile extends Window
   {
       
      
      public var _title:TextField;
      
      public var _scoreKey:TextField;
      
      public var _levelKey:TextField;
      
      public var _recordKey:TextField;
      
      public var _downloadKey:TextField;
      
      public var _scoreVal:TextField;
      
      public var _levelVal:TextField;
      
      public var _recordVal:TextField;
      
      public var _downloadVal:TextField;
      
      public var _share:Button;
      
      public var _bgmOn:Button;
      
      public var _bgmOff:Button;
      
      public var _soundOn:Button;
      
      public var _soundOff:Button;
      
      public var _help:Button;
      
      public var _translate:Button;
      
      public var _star:MovieClip;
      
      public function Profile()
      {
         super();
         _title.defaultTextFormat = _G.windowTitle;
         _share.addEventListener(AuiDefine.CLICK,onClickShare);
         _share.visible = game.shell.shareOpen;
         var bmgOn:Boolean = _G.archive.data.setting.bgmOn;
         _bgmOn.visible = !bmgOn;
         _bgmOff.visible = bmgOn;
         _bgmOn.addEventListener(AuiDefine.CLICK,onClickBGM);
         _bgmOff.addEventListener(AuiDefine.CLICK,onClickBGM);
         var soundOn:Boolean = _G.archive.data.setting.soundOn;
         _soundOn.visible = !soundOn;
         _soundOff.visible = soundOn;
         _soundOn.addEventListener(AuiDefine.CLICK,onClickSound);
         _soundOff.addEventListener(AuiDefine.CLICK,onClickSound);
         _help.addEventListener(AuiDefine.CLICK,function(param1:Event):void
         {
            game.hud.addToCenter(new Guide());
         });
         _translate.addEventListener(AuiDefine.CLICK,function():void
         {
            game.hud.alert("If you discover the translations are wrong,\nPlease tell me:classic_game_2015@126.com,\nThank you very much!~");
         });
      }
      
      override protected function onAddedToStage(param1:Event) : void
      {
         super.onAddedToStage(param1);
         _title.text = Language.id(1070);
         _scoreKey.text = Language.id(1071) + " =";
         _levelKey.text = Language.id(1072) + " =";
         _recordKey.text = Language.id(1073) + " =";
         _downloadKey.text = Language.id(1074) + " =";
         init();
      }
      
      override protected function onRemovedFromStage(param1:Event) : void
      {
         super.onRemovedFromStage(param1);
      }
      
      public function init() : void
      {
         var _loc1_:Player = _G.player;
         _scoreVal.text = _loc1_.getScore().toString();
         _levelVal.text = _loc1_.getLevel().toString();
         _recordVal.text = _loc1_.getNumRecord().toString();
         _downloadVal.text = _loc1_.getNumDownload().toString();
         _star.gotoAndStop(_G.player.getStar());
      }
      
      private function onClickBGM(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
         var _loc3_:* = param1.target == _bgmOn;
         var _loc2_:SoundTransform = _G._BGMChannel.soundTransform;
         _loc2_.volume = !!_loc3_?game.shell.bgmVol:0;
         _G._BGMChannel.soundTransform = _loc2_;
         _G.archive.data.setting.bgmOn = _loc3_;
         _bgmOn.visible = !_loc3_;
         _bgmOff.visible = _loc3_;
      }
      
      private function onClickSound(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
         var _loc3_:* = param1.target == _soundOn;
         var _loc2_:SoundTransform = SoundMixer.soundTransform;
         _loc2_.volume = !!_loc3_?game.shell.VOL:0;
         SoundMixer.soundTransform = _loc2_;
         _G.archive.data.setting.soundOn = _loc3_;
         _soundOn.visible = !_loc3_;
         _soundOff.visible = _loc3_;
      }
      
      private function onClickShare(param1:Event) : void
      {
         (game.self.getContentView() as Home)._bg.visible = true;
         var _loc3_:BitmapData = new BitmapData(game.w,game.h);
         _loc3_.draw(root);
         var _loc2_:DynamicEvent = new DynamicEvent("SHARE_SHOW");
         _loc2_.body = _loc3_;
         root.dispatchEvent(_loc2_);
         (game.self.getContentView() as Home)._bg.visible = false;
      }
   }
}
