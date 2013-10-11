package data
{
	import com.adobe.protocols.dict.Database;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import mx.utils.ObjectProxy;
	
	public class CharData extends Sprite
	{
		
		[Bindable]public var nome:String;
		public var lvl:Number;
		public var race:String;
		public var location:String;
		public var sex:Number;
		public var currentExp:Number;
		public var nextLevExp:Number;
		public var bit:Bitmap;
		public var fileName:String;
		public var lastSave:String;
		public var _isComplete:Boolean = false;
		
		public function CharData(file:File= null):void
		{
			load(file)
			
		}
		
		[Bindable(event="DATA_COMPLETE")]
		public function get isComplete():Boolean
		{
			
			return _isComplete;
			
		}
		
		public function getProperty(prop:String):*
		{
			
			return this['prop']
			
		}
		
		public  function load(file:File):void
		{
			try
			{
				var inBytes:ByteArray = new ByteArray(); 
				var inStream:FileStream = new FileStream();
				var w:int;
				var h:int;
				var l:uint;
				var tmpArr:ByteArray = new ByteArray()
				var ni:int;
				inBytes = new ByteArray()
				inStream.open(file, FileMode.READ); 
				inStream.readBytes(inBytes); 
				trace("done")
				inStream.close();
				inBytes.endian = Endian.LITTLE_ENDIAN
				inBytes.position = 0
				trace('Constant', inBytes.readUTFBytes(13))
				trace(inBytes.position)
				trace('headerSize',inBytes.readInt())
				trace(inBytes.position)
				trace('version',inBytes.readInt())
				trace(inBytes.position)
				trace('saveNumber',inBytes.readInt())
				trace(inBytes.position)
				trace('playerName size', ni = inBytes.readShort())
				trace(inBytes.position)
				trace('playerName',nome = inBytes.readUTFBytes(ni))
				trace(inBytes.position)
				trace('playerLevel', lvl = inBytes.readInt());
				trace(inBytes.position);
				trace('playerLocationSize', ni = inBytes.readShort())
				trace(inBytes.position);
				trace('playerLocation', location = inBytes.readUTFBytes(ni));
				trace(inBytes.position);
				trace('gameDateSize',ni = inBytes.readShort())
				trace(inBytes.position);
				trace('gameDate', inBytes.readUTFBytes(ni))
				trace(inBytes.position);
				trace('playerRaceSize',ni = inBytes.readShort())
				trace(inBytes.position);
				trace('playerRace',race = inBytes.readUTFBytes(ni))
				trace(inBytes.position);
				trace('playerSexs',sex = inBytes.readShort())
				trace(inBytes.position);
				trace("currentExp", currentExp = inBytes.readFloat())
				trace(inBytes.position);
				trace('nextLevelExp',nextLevExp = inBytes.readFloat())
				trace(inBytes.position);
				trace('fileTime',inBytes.readDouble())
				trace(inBytes.position);
				trace('shotWidth',w = inBytes.readInt())
				trace(inBytes.position);
				trace('shotheight',h = inBytes.readInt())
				trace(inBytes.position);
				l = 3*w*h
				
				var bitmapData:BitmapData;
				var bitmapBA:ByteArray = new ByteArray();
				var bitmap:Bitmap;
				//bitmapBA.endian = Endian.LITTLE_ENDIAN
				inBytes.readBytes(bitmapBA,0,l)
				trace('screenShotData done')
				trace(inBytes.position);
				trace('formVersion',inBytes.readByte())
				trace('21',inBytes.position);
				bitmapData = new BitmapData(w, h);
				bitmapBA.position = 0
				bitmapBA.endian = Endian.LITTLE_ENDIAN
				
				for(var i:Number =0; i<h; i++)
				{
					for(var j:Number =0; j<w; j++)
					{
						var alphaValue = 0
						var redValue = bitmapBA.readByte();
						var greenValue = bitmapBA.readByte();
						var blueValue = bitmapBA.readByte();
						var color:uint = alphaValue << 32 | redValue << 16 | greenValue << 8 | blueValue;
						bitmapData.setPixel(j,i,color);
						//bitmapData.setPixel32(j,i, color);
					}
				}
				
				bitmapData.lock()
				bit = new Bitmap(bitmapData)
				lastSave = getRealDate(file.creationDate)
				
			}
			catch(err:Error)
			{
				trace("Errore nel caricamento del file ")
			}
			fileName = "empty"
			_isComplete = true
			dispatchEvent(new Event("DATA_COMPLETE"))
			/*var tmpObj:Object = new Object;
			tmpObj.nome = nome
			tmpObj.lvl = lvl
			tmpObj.location = location
			tmpObj.race = race
			tmpObj.sex = sex
			tmpObj.currentExp = currentExp
			tmpObj.nextLevExp = nextLevExp
			tmpObj.img = bit
			tmpObj.filePath = file.nativePath*/

			
			
		}
		
		private function getRealDate(date:Date):String
		{
			var str:String = doubleDigitFormat(date.hours)+":"+doubleDigitFormat(date.minutes) +' ' + weekDayLabels[date.day] + " " + date.date + " " + monthLabels[date.month] + " " + date.fullYear
			return str
		}
		
		private var monthLabels:Array = new Array("January",
			"February",
			"March",
			"April",
			"May",
			"June",
			"July",
			"August",
			"September",
			"October",
			"November",
			"December");

		private var weekDayLabels:Array = new Array("Sunday",
			"Monday",
			"Tuesday",
			"Wednesday",
			"Thursday",
			"Friday",
			"Saturday");
		
		private function doubleDigitFormat(num:uint):String {
			if(num < 10) {
				return ("0" + num);
			}
			return num as String;
		}
		
		private  function removeExtension(fileName:String):String
		{
			var i:Number = fileName.indexOf(".")
				return fileName.substring(0,i)
			
		}
	}
}