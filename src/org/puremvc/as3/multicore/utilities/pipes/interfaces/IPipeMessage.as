/*
 PureMVC AS3/MultiCore Utility – Pipes
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.multicore.utilities.pipes.interfaces
{
	/** 
	 * The Pipe Message Interface
	 * <P>
	 * IPipeMessages are objects written intoto a pipeline, 
	 * composed of IPipeFittings. The message is passed from 
	 * one fitting to the next in syncrhonous fashion.</P> 
	 * <P>
	 * Depending on type, messages may be handled 
	 * differently by the fittings.</P>
	 */
	public interface IPipeMessage
	{
		function getType():String;
		function setType(type:String):void;
		
		function getPriority():int;
		function setPriority(priority:int):void;
		
		function getHeader():Object;
		function setHeader(header:Object):void;
		
		function getBody():Object;
		function setBody(body:Object):void;
	}
}