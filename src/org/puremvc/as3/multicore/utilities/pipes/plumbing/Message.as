/*
 PureMVC AS3/MultiCore Utility – Pipes
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.multicore.utilities.pipes.plumbing
{
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	/**
	 * Pipe Message.
	 * <P>
	 * Messages travelling through a Pipeline can
	 * be filtered, and queued. In a queue, they may
	 * be sorted by priority. Based on type, they 
	 * may written thru or acted upon by any pipline 
	 * element.</P>
	 */ 
	public class Message implements IPipeMessage
	{

		// High priority Messages are sorted to the front of the queue 
		public static const PRIORITY_HIGH:int = 1;
		// Medium priority Messages order vanilla shakes and medium fries
		public static const PRIORITY_MED:int = 5;
		// Low priority Messages are sorted to the back of the queue 
		public static const PRIORITY_LOW:int = 10;
		
		/**
		 * Normal Message type.
		 */
		public static const NORMAL:int = 0;
		
		// TBD: Messages in a queue can be sorted by priority.
		protected var priority:int;

		// Messages are handled differently according to type
		protected var type:int;
		
		// Header properties describe any meta data about the message for the recipient
		protected var header:Object;

		// Body of the message is the precious cargo
		protected var body:Object;

		// Constructor
		public function Message( type:int, header:Object=null, body:Object=null, priority:int=5 )
		{
			setType( type );
			setHeader( header );
			setBody( body );
			setPriority( priority );
		}
		
		// Get the type of this message
		public function getType():int
		{
			return this.type;
		}
		
		// Set the type of this message
		public function setType( type:int ):void
		{
			this.type = type;
		}
		
		// Get the priority of this message
		public function getPriority():int
		{
			return priority;
		}

		// Set the priority of this message
		public function setPriority( priority:int ):void
		{
			this.priority = priority;
		}
		
		// Get the header of this message
		public function getHeader():Object
		{
			return header;
		}

		// Set the header of this message
		public function setHeader( header:Object ):void
		{
			this.header = header;
		}
		
		// Get the body of this message
		public function getBody():Object
		{
			return body;
		}

		// Set the body of this message
		public function setBody( body:Object ):void
		{
			this.body = body;
		}

	}
}