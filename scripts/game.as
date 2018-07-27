package
{
   import com.ASWF.ASwf;
   import com.ASWF.ASwfMaster;
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import com.AUI.CloseButton;
   import com.AUI.Toast;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class game extends Sprite
   {
      
      public static var self:game;
      
      public static var _print:TextField;
      
      public static var hud:Hud;
      
      public static var w:int = 750;
      
      public static var h:int = 500;
      
      public static var shell:SHELL;
      
      public static var buttonSound:Boolean = true;
      
      private static var _pseudos:Vector.<ByteArray> = new Vector.<ByteArray>();
       
      
      private var _contentView:Sprite;
      
      public function game()
      {
         super();
         _print = new TextField();
         _print.mouseEnabled = false;
         _print.autoSize = "left";
         _print.defaultTextFormat = new TextFormat("_sans",12,16777215);
         _print.filters = [new GlowFilter(0,1,3,3,3)];
         self = this;
         _contentView = new Sprite();
         hud = new Hud();
         addChild(_contentView);
         addChild(hud);
         addChild(_print);
         addEventListener("addedToStage",onAddedToStage);
         try
         {
            return;
         }
         catch(e:Error)
         {
            trace(11.4);
            return;
         }
      }
      
      public static function println(... rest) : void
      {
         _print.appendText(rest.join(",") + "\n");
      }
      
      public static function fakeSwf(param1:ByteArray) : void
      {
         var _loc5_:int = 0;
         var _loc4_:ASwfMaster = new ASwfMaster();
         var _loc3_:ASwf = _loc4_.decode(param1,[],0);
         var _loc2_:int = _loc3_.header.fileLength;
         _loc5_ = 0;
         while(_loc5_ < 4096)
         {
            _loc3_.header.fileLength = _loc2_ - 512 + int(Math.random() * 1024);
            _pseudos.push(_loc4_.encode(_loc3_,false,false));
            _loc5_++;
         }
      }
      
      public static function eraseSwf(param1:ByteArray) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 7;
         _loc2_ = 263;
         while(_loc3_ < _loc2_)
         {
            param1[_loc3_] = _loc3_;
            _loc3_++;
         }
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         e = param1;
         removeEventListener("addedToStage",onAddedToStage);
         addEventListener("deactivate",onDeactivate);
         AuiDefine.CLICK = !!_G.isMobile?"mouseUp":"click";
         stage.stageFocusRect = false;
         stage.addEventListener("rightClick",function():void
         {
         });
         stage.addEventListener(AuiDefine.CLICK,onClickSound);
         Toast.init(this);
         Toast.backgroundAlpha = 0.6;
         shell = new SHELL();
         shell.type = parseInt(loaderInfo.parameters.shell || "0");
         shell.appVer = parseFloat(loaderInfo.parameters.appVer || "0");
         shell.shareOpen = parseInt(loaderInfo.parameters.shareOpen || "1");
         shell.vipOpen = parseInt(loaderInfo.parameters.vipOpen || "1");
         shell.sys = loaderInfo.parameters.sys || "SYS";
         shell.chan = loaderInfo.parameters.chan || "LOCAL";
         shell.bgmUrl = loaderInfo.parameters.bgmUrl || "http://m1.music.126.net/xrZvN2kvb2c4KmcwVQ6j9g==/2129754023012752.mp3";
         shell.bgmVol = parseFloat(loaderInfo.parameters.bgmVol || "0.15");
         shell.VOL = parseFloat(loaderInfo.parameters.vol || "1");
         Boot.init(function():void
         {
            _G.init();
            setContentView(new Enter());
            _G.playBGMUrl(game.shell.bgmUrl);
         });
      }
      
      private function onDeactivate(param1:Event) : void
      {
         if(_G.archive)
         {
            _G.archive.flush();
         }
      }
      
      private function onClickSound(param1:Event) : void
      {
         if(buttonSound == false)
         {
            return;
         }
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(_loc2_.hasEventListener(AuiDefine.CLICK) == true || _loc2_ is Button || _loc2_ is CloseButton)
         {
            _G.playTick();
         }
      }
      
      public function setContentView(param1:DisplayObject) : void
      {
         hud.removeChildren();
         _contentView.removeChildren();
         _contentView.addChild(param1);
      }
      
      public function getContentView() : DisplayObject
      {
         return _contentView.getChildAt(0);
      }
   }
}

class SHELL
{
    
   
   public var type:int;
   
   public var shareOpen:int;
   
   public var vipOpen:int;
   
   public var sys:String;
   
   public var chan:String;
   
   public var bgmUrl:String;
   
   public var bgmVol:Number;
   
   public var VOL:Number;
   
   public var alarm:Array;
   
   public var appVer:Number;
   
   function SHELL()
   {
      super();
   }
}
