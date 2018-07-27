package com.ASWF
{
   import flash.utils.ByteArray;
   
   public class ASwfMaster
   {
       
      
      public var tagConfigs:Vector.<ATagConfig>;
      
      private const TWIPS:int = 20;
      
      public function ASwfMaster()
      {
         var _loc1_:int = 0;
         tagConfigs = new Vector.<ATagConfig>(1024);
         super();
         _loc1_ = 0;
         while(_loc1_ < tagConfigs.length)
         {
            tagConfigs[_loc1_] = new ATagConfig();
            _loc1_++;
         }
         tagConfigs[0].introduce = "End";
         tagConfigs[1].introduce = "ShowFrame";
         tagConfigs[2].introduce = "DefineShape";
         tagConfigs[4].introduce = "PlaceObject";
         tagConfigs[5].introduce = "RemoveObject";
         tagConfigs[6].introduce = "DefineBits";
         tagConfigs[7].introduce = "DefineButton";
         tagConfigs[8].introduce = "JPEGTables";
         tagConfigs[9].introduce = "SetBackgroundColor";
         tagConfigs[10].introduce = "DefineFont";
         tagConfigs[11].introduce = "DefineText";
         tagConfigs[12].introduce = "DoAction";
         tagConfigs[13].introduce = "DefineFontInfo";
         tagConfigs[14].introduce = "DefineSound";
         tagConfigs[15].introduce = "StartSound";
         tagConfigs[17].introduce = "DefineButtonSound";
         tagConfigs[18].introduce = "SoundStreamHead";
         tagConfigs[19].introduce = "SoundStreamBlock";
         tagConfigs[20].introduce = "DefineBitsLossless";
         tagConfigs[21].introduce = "DefineBitsJPEG2";
         tagConfigs[22].introduce = "DefineShape2";
         tagConfigs[23].introduce = "DefineButtonCxform";
         tagConfigs[24].introduce = "Protect";
         tagConfigs[26].introduce = "PlaceObject2";
         tagConfigs[28].introduce = "RemoveObject2";
         tagConfigs[32].introduce = "DefineShape3";
         tagConfigs[33].introduce = "DefineText2";
         tagConfigs[34].introduce = "DefineButton2";
         tagConfigs[35].introduce = "DefineBitsJPEG3";
         tagConfigs[36].introduce = "DefineBitsLossless2";
         tagConfigs[37].introduce = "DefineEditText";
         tagConfigs[39].introduce = "DefineSprite";
         tagConfigs[41].introduce = "StagProductInfo:a tag command for the Flash Generator customer serial id and cpu information.";
         tagConfigs[43].introduce = "FrameLabel";
         tagConfigs[45].introduce = "SoundStreamHead2";
         tagConfigs[46].introduce = "DefineMorphShape";
         tagConfigs[48].introduce = "DefineFont2";
         tagConfigs[56].introduce = "ExportAssets";
         tagConfigs[57].introduce = "ImportAssets";
         tagConfigs[58].introduce = "EnableDebugger";
         tagConfigs[59].introduce = "DoInitAction";
         tagConfigs[60].introduce = "DefineVideoStream";
         tagConfigs[61].introduce = "VideoFrame";
         tagConfigs[62].introduce = "DefineFontInfo2";
         tagConfigs[63].introduce = "StagDebugID:unique id to match up swf to swd";
         tagConfigs[64].introduce = "EnableDebugger2";
         tagConfigs[65].introduce = "ScriptLimits";
         tagConfigs[66].introduce = "SetTabIndex";
         tagConfigs[69].introduce = "FileAttributes";
         tagConfigs[70].introduce = "PlaceObject3";
         tagConfigs[71].introduce = "ImportAssets2";
         tagConfigs[73].introduce = "DefineFontAlignZones";
         tagConfigs[74].introduce = "CSMTextSettings";
         tagConfigs[75].introduce = "DefineFont3";
         tagConfigs[76].introduce = "SymbolClass";
         tagConfigs[77].introduce = "Metabody";
         tagConfigs[78].introduce = "DefineScalingGrid";
         tagConfigs[82].introduce = "DoABC";
         tagConfigs[83].introduce = "DefineShape4";
         tagConfigs[84].introduce = "DefineMorphShape2";
         tagConfigs[86].introduce = "DefineSceneAndFrameLabelData";
         tagConfigs[87].introduce = "DefineBinaryData";
         tagConfigs[88].introduce = "DefineFontName";
         tagConfigs[89].introduce = "StartSound2";
         tagConfigs[90].introduce = "DefineBitsJPEG4";
         tagConfigs[91].introduce = "DefineFont4";
      }
      
      public function decode(param1:ByteArray, param2:Array = null, param3:uint = 4294967295) : ASwf
      {
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc8_:ASwf = new ASwf();
         var _loc11_:* = new ASwfByteArray();
         _loc8_.bin = _loc11_;
         var _loc4_:* = _loc11_;
         param1.position = 0;
         if(param1[0] == 67)
         {
            _loc7_ = new ByteArray();
            _loc7_.writeBytes(param1,8);
            _loc7_.uncompress();
            _loc4_.writeBytes(param1,0,8);
            _loc4_.writeBytes(_loc7_);
            _loc4_[0] = 70;
         }
         else
         {
            _loc4_.writeBytes(param1);
         }
         _loc4_.position = 0;
         var _loc9_:ASwfHeader = _loc8_.header;
         _loc9_.compressed = _loc4_.readUnsignedByte();
         _loc9_.signedByte1 = _loc4_.readUnsignedByte();
         _loc9_.singedByte2 = _loc4_.readUnsignedByte();
         _loc9_.version = _loc4_.readUnsignedByte();
         _loc9_.fileLength = _loc4_.readUnsignedInt();
         _loc9_.frameSize.NBits = _loc4_.readUBits(5);
         _loc9_.frameSize.xMin = _loc4_.readSBits(_loc9_.frameSize.NBits);
         _loc9_.frameSize.xMax = _loc4_.readSBits(_loc9_.frameSize.NBits);
         _loc9_.frameSize.yMin = _loc4_.readSBits(_loc9_.frameSize.NBits);
         _loc9_.frameSize.yMax = _loc4_.readSBits(_loc9_.frameSize.NBits);
         _loc4_.syncBits();
         _loc4_.endian = "bigEndian";
         _loc9_.frameRate = _loc4_.readUnsignedShort();
         _loc4_.endian = "littleEndian";
         _loc9_.frameCount = _loc4_.readUnsignedShort();
         _loc9_.swfWidth = int(_loc9_.frameSize.xMax / 20);
         _loc9_.swfHeight = int(_loc9_.frameSize.yMax / 20);
         _loc9_.length = _loc4_.position;
         var _loc10_:int = 0;
         if(!param2)
         {
            _loc10_ = 0;
            while(_loc10_ < tagConfigs.length)
            {
               tagConfigs[_loc10_].decode = true;
               _loc10_++;
            }
         }
         else
         {
            _loc10_ = 0;
            while(_loc10_ < param2.length)
            {
               tagConfigs[param2[_loc10_]].decode = true;
               _loc10_++;
            }
         }
         var _loc5_:uint = 0;
         while(_loc4_.bytesAvailable && uint(param3))
         {
            _loc6_ = decodeTag(_loc4_,_loc5_);
            _loc8_.tags.push(_loc6_);
            _loc5_++;
         }
         return _loc8_;
      }
      
      private function decodeTag(param1:ASwfByteArray, param2:uint = 0) : ATag
      {
         var _loc8_:uint = param1.readUnsignedShort();
         var _loc7_:uint = _loc8_ >> 6;
         var _loc3_:* = _loc8_ & 63;
         var _loc9_:int = 0;
         var _loc6_:* = 0;
         if(_loc3_ == 63)
         {
            _loc9_ = param1.readInt();
            _loc6_ = _loc9_;
         }
         else
         {
            _loc6_ = _loc3_;
         }
         var _loc5_:ATagConfig = tagConfigs[_loc7_];
         if(_loc5_ == null)
         {
            throw new Error("unknown tag:",_loc7_);
         }
         var _loc4_:ATag = new _loc5_.mapper();
         _loc4_.index = param2;
         _loc4_.RECORDHEADER.type = _loc7_;
         _loc4_.RECORDHEADER.length6 = _loc3_;
         _loc4_.RECORDHEADER.length32 = _loc9_;
         if(_loc6_ && _loc5_.decode)
         {
            param1.readBytes(_loc4_.data,0,_loc6_);
            _loc4_.decode();
         }
         else
         {
            param1.position = param1.position + _loc6_;
         }
         return _loc4_;
      }
      
      public function encode(param1:ASwf, param2:Boolean = true, param3:Boolean = true) : ByteArray
      {
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc8_:ASwfByteArray = new ASwfByteArray();
         var _loc9_:ASwfHeader = param1.header;
         var _loc5_:uint = _loc9_.fileLength;
         _loc8_.writeByte(_loc9_.compressed);
         _loc8_.writeByte(_loc9_.signedByte1);
         _loc8_.writeByte(_loc9_.singedByte2);
         _loc8_.writeByte(_loc9_.version);
         _loc8_.writeUnsignedInt(_loc5_);
         _loc8_.writeUBits(_loc9_.frameSize.NBits,5);
         _loc8_.writeSBits(_loc9_.frameSize.xMin,_loc9_.frameSize.NBits);
         _loc8_.writeSBits(_loc9_.frameSize.xMax,_loc9_.frameSize.NBits);
         _loc8_.writeSBits(_loc9_.frameSize.yMin,_loc9_.frameSize.NBits);
         _loc8_.writeSBits(_loc9_.frameSize.yMax,_loc9_.frameSize.NBits);
         _loc8_.flushBits();
         _loc8_.endian = "bigEndian";
         _loc8_.writeShort(_loc9_.frameRate);
         _loc8_.endian = "littleEndian";
         _loc8_.writeShort(_loc9_.frameCount);
         _loc10_ = 0;
         _loc7_ = param1.tags.length;
         while(_loc10_ < _loc7_)
         {
            _loc4_ = param1.tags[_loc10_];
            _loc8_.writeBytes(_loc4_.encode());
            _loc10_++;
         }
         if(param3)
         {
            _loc5_ = _loc8_.length;
            _loc8_[4] = (_loc5_ & 255) >> 0;
            _loc8_[5] = (_loc5_ & 65280) >> 8;
            _loc8_[6] = (_loc5_ & 16711680) >> 16;
            _loc8_[7] = (_loc5_ & 4278190080) >> 24;
         }
         if(param2)
         {
            _loc8_[0] = 67;
            _loc6_ = new ByteArray();
            _loc6_.writeBytes(_loc8_,8);
            _loc6_.compress();
            _loc8_.length = 8;
            _loc8_.position = _loc8_.length;
            _loc8_.writeBytes(_loc6_);
         }
         else
         {
            _loc8_[0] = 70;
         }
         return _loc8_;
      }
   }
}
