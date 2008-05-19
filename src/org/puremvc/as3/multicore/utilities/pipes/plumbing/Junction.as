/*
 PureMVC AS3/MultiCore Utility – Pipes
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.multicore.utilities.pipes.plumbing
{
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	
	/**
	 * Pipe Junction.
	 * <P>
	 * Manages the input and output pipes for a Module. 
	 */
	public class Junction
	{
		// INPUT Pipe Type
		public static const INPUT:String 	= 'input';
		// OUTPUT Pipe Type
		public static const OUTPUT:String 	= 'output';
		
		// Schoolhouse rock, heh.
		public function Junction( )
		{
		}

		/**
		 * Register a pipe with the junction.
		 * <P>
		 * Pipes are registered by unique name and type,
		 * which must be either <code>Junction.INPUT</code>
		 * or <code>Junction.OUTPUT</code>.</P>
v		 * <P>
		 * NOTE: You cannot have an INPUT pipe and an OUTPUT
		 * pipe registered with the same name. All pipe names
		 * must be unique regardless of type.</P>
		 * 
		 * @return Boolean true if successfully registered. false if another pipe exists by that name.
		 */
		public function registerPipe( name:String, type:String, pipe:IPipeFitting ):Boolean
		{ 
			var success:Boolean = true;
			if ( pipesMap[name] == null )
			{
				pipesMap[name] = pipe;
				pipeTypesMap[name] = type;
				switch (type) {
					case INPUT:
						inputPipes.push(name);	
						break;						
					case OUTPUT:
						outputPipes.push(name);	
						break;					
					default:	
						success=false;
				}
			} else {
				success=false;
			}
			return success;
		}
		
		/**
		 * Does this junction have a pipe by this name?
		 * @param name the pipe to check for 
		 * @return Boolean whether as pipe is registered with that name.
		 */ 
		public function hasPipe( name:String ):Boolean
		{
			return ( pipesMap[name] == null );
		}
		
		/**
		 * Does this junction have an INPUT pipe by this name?
		 * @param name the pipe to check for 
		 * @return Boolean whether an INPUT pipe is registered with that name.
		 */ 
		public function hasInputPipe( name:String ):Boolean
		{
			return ( hasPipe(name) && (pipeTypesMap[name] == INPUT) );
		}

		/**
		 * Does this junction have an OUTPUT pipe by this name?
		 * @param name the pipe to check for 
		 * @return Boolean whether an OUTPUT pipe is registered with that name.
		 */ 
		public function hasOutputPipe( name:String ):Boolean
		{
			return ( hasPipe(name) && (pipeTypesMap[name] == OUTPUT) );
		}

		/**
		 * Remove the pipe with this name if it is registered.
		 * <P>
		 * NOTE: You cannot have an INPUT pipe and an OUTPUT
		 * pipe registered with the same name. All pipe names
		 * must be unique regardless of type.</P>
		 * 
		 * @param name the pipe to remove
		 */
		public function removePipe( name:String ):void 
		{
			if ( hasPipe(name) ) {
				var type:String = pipeTypesMap[name];
				var pipesList:Array;
				switch (type) {
					case INPUT:
						pipesList = inputPipes;
						break;						
					case OUTPUT:
						pipesList = outputPipes;	
						break;					
				}
				for (var i:int=0;i<pipesList.length;i++){
					if (pipesList[i] == name){
						pipesList.splice(i, 1);
						break;
					}
				}
				delete pipesMap[name];
				delete pipeTypesMap[name];
			}
		}

		/**
		 * Retrieve the named pipe.
		 * @param name the pipe to retrieve
		 * @return IPipeFitting the pipe registered by the given name if it exists
		 */
		public function retrievePipe( name:String ):IPipeFitting 
		{
			return pipesMap[name]  as IPipeFitting;
		}

		/**
		 * Add a PipeListener to an INPUT pipe.
		 * <P>
		 * NOTE: there can only be one PipeListener per pipe.
		 * and the listner function must accept an IPipeMessage
		 * as its sole argument.</P>
		 * 
		 * @param name the INPUT pipe to add a PipeListener to
		 * @param context the calling context or 'this' object  
		 * @param listener the function on the context to call
		 */
		public function addPipeListener( name:String, context:Object, listener:Function ):Boolean 
		{
			var success:Boolean=false;
			if ( hasInputPipe(name) )
			{
				var pipeListener:PipeListener = new PipeListener(context, listener);
				var pipe:IPipeFitting = pipesMap[name] as IPipeFitting;
				success = pipe.connect(pipeListener);
			} 
			return success;
		}
		
		// The names of the INPUT pipes
		protected var inputPipes:Array = new Array();
		// The names of the OUTPUT pipes
		protected var outputPipes:Array = new Array();
		// The map of pipe names to their pipes
		protected var pipesMap:Array = new Array();
		// The map of pipe names to their types
		protected var pipeTypesMap:Array = new Array();

	}
}

import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	
/**
 * A Pipe Listener.
 * <P>
 * This allows a class that does not implement IPipeFitting to
 * be the final recipient of the messages in a pipeline.</P>
 * 
 * @see Junction
 */ 
class PipeListener implements IPipeFitting
{
	private var context:Object;
	private var listener:Function;
	
	public function PipeListener( context:Object, listener:Function )
	{
		this.context = context;
		this.listener = listener;
	}
	
	// Can't connect anything beyond this
	public function connect(output:IPipeFitting):Boolean
	{
		return false;
	}

	// Write the message to the listener
	public function write(message:IPipeMessage):Boolean
	{
		listener.apply(context,message);
		return true;
	}
}
