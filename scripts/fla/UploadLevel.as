package fla
{
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import com.AUI.CloseButton;
   import com.AUI.Toast;
   import com.AUI.Window;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class UploadLevel extends Window
   {
       
      
      public var _title:TextField;
      
      public var _nameKey:TextField;
      
      public var _nameVal:TextField;
      
      public var _enNameKey:TextField;
      
      public var _enNameVal:TextField;
      
      public var _creatorKey:TextField;
      
      public var _creatorVal:TextField;
      
      public var _state:TextField;
      
      public var _close:CloseButton;
      
      public var _done:Button;
      
      private var _layout:String;
      
      private var _shots:int;
      
      private var _image:ByteArray;
      
      public function UploadLevel(param1:String, param2:int, param3:ByteArray)
      {
         super();
         _layout = param1;
         _shots = param2;
         _image = param3;
         _close.visible = false;
         _title.defaultTextFormat = _G.windowTitle;
         _title.text = Language.id(1030);
         _nameKey.text = Language.id(1001) + " =";
         _enNameKey.text = Language.id(1002) + " =";
         _creatorKey.text = Language.id(1003) + " =";
         _nameVal.text = "";
         _enNameVal.text = "";
         _creatorVal.text = "";
         _state.text = "";
         _nameVal.maxChars = 7;
         _enNameVal.maxChars = 7;
         _creatorVal.maxChars = 7;
         _enNameVal.restrict = "a-z A-Z 0-9\\-";
         _done.addEventListener(AuiDefine.CLICK,onClickDone);
      }
      
      override protected function onAddedToStage(param1:Event) : void
      {
         super.onAddedToStage(param1);
      }
      
      override protected function onRemovedFromStage(param1:Event) : void
      {
         super.onRemovedFromStage(param1);
      }
      
      private function onClickDone(param1:Event) : void
      {
         var _loc7_:String = _nameVal.text;
         var _loc4_:String = _enNameVal.text;
         var _loc2_:String = _loc4_ + "_" + new Date().time + ".png";
         var _loc5_:String = _creatorVal.text;
         var _loc6_:String = _layout;
         var _loc8_:String = _shots.toString();
         var _loc3_:String = _G.getISO_639_3166();
         if(_loc7_ == "" || _loc4_ == "" || _loc5_ == "")
         {
            Toast.show(Language.id(1036));
            return;
         }
         var _loc9_:String = encodeURI("http://min87.com/fancy/tq9/addLevel.php?version=1&uuid=" + _G.player.getUUID() + "&lang=" + Language.field + "&name=" + _loc7_ + "&enName=" + _loc4_ + "&upload_name=" + _loc2_ + "&layout=" + _loc6_ + "&shots=" + _loc8_ + "&creatorName=" + _loc5_ + "&creatorLocale=" + _loc3_);
         postBin(_loc9_,_image,onUpload);
         _state.text = Language.id(1032);
         _done.enabled = false;
      }
      
      public function onUpload(param1:Event) : void
      {
         _state.text = "";
         if(param1.type != "complete")
         {
            _state.text = Language.id(1033);
            _done.enabled = true;
            _close.visible = true;
            return;
         }
         var _loc2_:URLLoader = param1.target as URLLoader;
         if(_loc2_.data != "")
         {
            _state.text = _loc2_.data;
            _done.enabled = true;
            _close.visible = true;
            return;
         }
         close();
         game.hud.alert(Language.id(1034));
      }
      
      private function postBin(param1:String, param2:ByteArray, param3:Function = null) : void
      {
         trace(param1);
         var _loc6_:ByteArray = new ByteArray();
         _loc6_.writeUTFBytes("--AMIN2312\r\nContent-Disposition: form-data; name=\"upload_file\"; filename=\"upload_file\"\r\nContent-Type: application/octet-stream\r\n\r\n");
         _loc6_.writeBytes(param2);
         _loc6_.writeUTFBytes("\r\n");
         _loc6_.writeUTFBytes("--AMIN2312--");
         var _loc5_:URLRequest = new URLRequest(param1);
         _loc5_.method = "POST";
         _loc5_.requestHeaders.push(new URLRequestHeader("Content-Type","multipart/form-data; boundary=AMIN2312"));
         _loc5_.data = _loc6_;
         var _loc4_:URLLoader = new URLLoader();
         if(param3 != null)
         {
            _loc4_.addEventListener("complete",param3);
            _loc4_.addEventListener("ioError",param3);
            _loc4_.addEventListener("securityError",param3);
         }
         _loc4_.load(_loc5_);
      }
   }
}
