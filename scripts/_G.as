package
{
   import com.ALIB.FileCache;
   import com.greensock.TweenMax;
   import fla.role.Player;
   import flash.display.DisplayObject;
   import flash.filters.GlowFilter;
   import flash.globalization.StringTools;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.net.SharedObject;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.text.TextFormat;
   import flash.ui.Multitouch;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   import fls.SOUND_CLICK;
   
   public class _G
   {
      
      public static var conf:Object;
      
      public static var fc:FileCache = new FileCache();
      
      public static var archive:SharedObject;
      
      public static var player:Player;
      
      public static var letterSpacing1:TextFormat = new TextFormat();
      
      public static var windowTitle:TextFormat = new TextFormat("_sans",22,16777215,true);
      
      public static var _BGMSound:Sound;
      
      public static var _BGMChannel:SoundChannel;
      
      public static var _BGMLoader:URLLoader;
       
      
      public function _G()
      {
         super();
      }
      
      public static function get isMobile() : Boolean
      {
         return Multitouch.maxTouchPoints != 0;
      }
      
      public static function init() : void
      {
         letterSpacing1.letterSpacing = 1;
         windowTitle.letterSpacing = 1;
         archive = SharedObject.getLocal("_tq_9");
         if(!archive.data.inited)
         {
            archive.data.inited = true;
            archive.data.setting = {
               "soundOn":true,
               "bgmOn":true
            };
            archive.data.player = {};
            archive.data.caches = {};
         }
         var _loc2_:Boolean = archive.data.setting.soundOn;
         var _loc1_:SoundTransform = SoundMixer.soundTransform;
         _loc1_.volume = !!_loc2_?game.shell.VOL:0;
         SoundMixer.soundTransform = _loc1_;
         player = new Player();
         player.init(archive.data.player);
         Language.init(fc.csv.selectAllArray("langSupports"));
         Language.field = player.getLangField();
      }
      
      public static function saveArchive() : void
      {
         archive.data.player = player.archived();
         archive.flush();
      }
      
      public static function getCache(param1:String) : *
      {
         if(param1 in archive.data.caches)
         {
            return archive.data.caches[param1];
         }
         return null;
      }
      
      public static function setCache(param1:String, param2:*) : void
      {
         if(isMobile == false)
         {
            return;
         }
         archive.data.caches[param1] = param2;
         archive.flush();
      }
      
      public static function playTick() : void
      {
         new SOUND_CLICK().play();
      }
      
      public static function playBGM(param1:Sound, param2:Number = 1, param3:int = 2147483647) : void
      {
         if(_BGMSound != null && getQualifiedClassName(_BGMSound) == getQualifiedClassName(param1))
         {
            return;
         }
         stopBGM();
         try
         {
            _BGMSound = param1;
            _BGMChannel = _BGMSound.play(0,param3);
         }
         catch(e:Error)
         {
         }
         var _loc5_:Boolean = archive.data.setting.bgmOn;
         var _loc4_:SoundTransform = _BGMChannel.soundTransform;
         _loc4_.volume = !!_loc5_?param2:0;
         _BGMChannel.soundTransform = _loc4_;
      }
      
      public static function playBGMBytes(param1:ByteArray, param2:Number = 1, param3:int = 2147483647) : void
      {
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         stopBGM();
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeBytes(param1);
         _loc5_.position = 0;
         try
         {
            _BGMSound = new Sound();
            _BGMSound.loadCompressedDataFromByteArray(_loc5_,_loc5_.length);
            _BGMChannel = _BGMSound.play(0,2147483647);
         }
         catch(e:Error)
         {
         }
         var _loc6_:Boolean = archive.data.setting.bgmOn;
         var _loc4_:SoundTransform = _BGMChannel.soundTransform;
         _loc4_.volume = !!_loc6_?param2:0;
         _BGMChannel.soundTransform = _loc4_;
      }
      
      public static function playBGMUrl(param1:String, param2:Number = 1, param3:int = 2147483647) : void
      {
         url = param1;
         volume = param2;
         times = param3;
         if(url == null)
         {
            return;
         }
         var bytes:ByteArray = getCache(url);
         if(bytes)
         {
            playBGMBytes(bytes,game.shell.bgmVol);
         }
         else
         {
            if(_BGMLoader)
            {
               _BGMLoader.close();
            }
            _BGMLoader = new URLLoader();
            _BGMLoader.dataFormat = "binary";
            _BGMLoader.load(new URLRequest(url));
            _BGMLoader.addEventListener("complete",function():void
            {
               setCache(url,_BGMLoader.data);
               playBGMBytes(_BGMLoader.data,game.shell.bgmVol);
            });
         }
      }
      
      public static function stopBGM() : void
      {
         _BGMSound = null;
         if(_BGMChannel)
         {
            try
            {
               _BGMChannel.stop();
               return;
            }
            catch(e:Error)
            {
               return;
            }
         }
      }
      
      public static function getISO_639_3166() : String
      {
         var _loc1_:String = new StringTools("i-default").actualLocaleIDName;
         return _loc1_;
      }
      
      public static function getISO3166() : String
      {
         return getISO_639_3166().split("-")[1];
      }
      
      public static function getISO639() : String
      {
         return getISO_639_3166().split("-")[0];
      }
      
      public static function random(param1:int = 1) : Number
      {
         return Math.random();
      }
      
      public static function shineObject(param1:DisplayObject, param2:Number = 0.6, param3:int = 30) : void
      {
         param1.filters = [new GlowFilter(16776960,0.2,1,1,3)];
         TweenMax.to(param1,0.6,{
            "glowFilter":{
               "color":16776960,
               "alpha":1,
               "blurX":8,
               "blurY":8
            },
            "yoyo":true,
            "repeat":param3
         });
      }
   }
}
