/*
 PureMVC AS3/MultiCore Utility – Pipes
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.multicore.utilities.pipes.plumbing
{
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	
	/** 
	 * Pipe Queue.
	 * <P>
	 * The Queue always stores inbound messages until you send it
	 * a Queue Flush message, at which point it writes the
	 * queue out in FIFO order.</P>
	 * <P>
	 * To tell the Queue to flush the queue to the output 
	 * PipeFitting in FIFO order, send an <code>IPipeMessage</code> of type:
	 * <code>Queue.FLUSH</code></P>
	 * <P>
	 * NOTE: There can effectively be only one Queue on a given 
	 * pipeline, since the first queue in the pipeline acts on 
	 * any Queue Control Flush message.</P> 
	 */
	public class Queue extends Pipe
	{
		public static const FLUSH:int = 1;

		public function Queue( output:IPipeFitting=null )
		{
			super( output );
		}
		
		/**
		 * Handle the incoming message.
		 * <P>
		 * Normal messages are enqueued.</P>
		 * <P>
		 * The Queue Flush message type tells the Queue
		 * to write all stored messages in FIFO order to the 
		 * ouptut PipeFitting, then return to normal enqueing
		 * operation.</P> 
		 */ 
		override public function write( message:IPipeMessage ):Boolean
		{
			var success:Boolean = true;
			switch ( message.getType() )	
			{
				// Store normal messages
				case Message.NORMAL:
					this.store( message );
					break;
					
				// Flush the queue
				case Queue.FLUSH:
					success = this.flush();		
					break;
			}
			return success;
		} 
		
		/**
		 * Store a message.
		 * @param message the IPipeMessage to enqueue.
		 * @return int the new count of messages in the queue
		 */
		protected function store( message:IPipeMessage ):void
		{
			messages.push( message );
		}

		/**
		 * Flush the queue.
		 * <P>
		 * NOTE: This empties the queue.</P>
		 * @return Boolean true if all messages written successfully.
		 */
		protected function flush():Boolean
		{
			var success:Boolean=true;
			var message:IPipeMessage = messages.shift() as IPipeMessage;
			while ( message != null ) 
			{
				var ok:Boolean = output.write( message );
				if ( !ok ) success = false;
				message = messages.shift() as IPipeMessage;
			} 
			return success;
		}

		protected var messages:Array = new Array();
	}
}