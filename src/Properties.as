/*
 * Copyright 2007-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * The <code>Properties</code> class represents a collection of properties
	 * in the form of key-value pairs. All keys and values are of type
	 * <code>String</code>
	 *
	 * <p>
	 * <b>Author:</b> Christophe Herreman<br/>
	 * <b>Version:</b> $Revision: 21 $, $Date: 2008-11-01 22:58:42 +0100 (za, 01 nov 2008) $, $Author: dmurat $<br/>
	 * <b>Since:</b> 0.1
	 * </p>
	 */
	public class Properties extends EventDispatcher {

		private var _properties:Object;
		private var _loader:URLLoader;

		/**
		 * Creates a new <code>Properties</code> object.
		 */
		public function Properties() {
			super(this);
			_properties = {};
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, onLoaderComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}

		/**
		 * Gets the value of property that corresponds to the given <code>key</code>.
		 * If no property was found, <code>null</code> is returned.
		 *
		 * @param key the name of the property to get
		 * @returns the value of the property with the given key, or null if none was found
		 */
		public function getProperty(key:String):String {
			return _properties[key];
		}

		/**
		 * Sets a property. If the property with the given key already exists,
		 * it will be replaced by the new value.
		 *
		 * @param key the key of the property to set
		 * @param value the value of the property to set
		 */
		public function setProperty(key:String, value:String):void {
			_properties[key] = value;
		}

		/**
		 * Returns an array with the keys of all properties. If no properties
		 * were found, an empty array is returned.
		 *
		 * @return an array with all keys
		 */
		public function get propertyNames():Array {
			var result:Array = [];
			for (var key:String in _properties) {
				result.push(key);
			}
			return result;
		}

		/**
		 * Loads a collection of properties from an external file.
		 * Each property must be on a new line and in the form <i>key</i>=
		 * <i>value</i>.
		 * All keys and values are trimmed. Blank lines that do not contain
		 * properties are ignored. When the loading (and parsing) is done, a
		 * Event.COMPLETE event is dispatched.
		 *
		 * @param url the url of the properties file
		 */
		public function load(url:String):void {
			// add a pseudo random number to avoid caching
			url += ("?" + Math.round(Math.random() * 1000000));
			var request:URLRequest = new URLRequest(url);
			_loader.load(request);
		}

		/**
		 * Handles the complete event of the urlloader.
		 */
		private function onLoaderComplete(event:Event):void {
			var parser:PropertiesParser = new PropertiesParser();
			var parsedProperties:Properties = parser.parseProperties(String(_loader.data));
			var keys:Array = parsedProperties.propertyNames;

			for each (var key:String in keys) {
				setProperty(key, parsedProperties.getProperty(key));
			}

			dispatchEvent(new Event(Event.COMPLETE));
		}

		private function onIOError(event:IOErrorEvent):void {
			dispatchEvent(event);
		}
	}
}
