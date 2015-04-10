package cn.touchmedia.sean.dualscreen;

import java.io.IOException;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Queue;
import java.util.Set;
import java.util.concurrent.Callable;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.async.DeferredResult;

@Controller
@RequestMapping("/dualscreen")
public class DualScreenController {
	
	private final Queue<DeferredResult<String>> chatRequests = 
			new ConcurrentLinkedQueue<DeferredResult<String>>();

//	private final Queue<DeferredResult<ChatMessage>> crossRequests =
//			new ConcurrentLinkedQueue<DeferredResult<ChatMessage>>();
	
	private final Map<DeferredResult<String>, String> crossRequests = 
			new ConcurrentHashMap<DeferredResult<String>, String>();
	
//	@Autowired
//	MessageRepository messageRepository;
//	
//	public void setMessageRepository( MessageRepository messageRepository ) {
//		this.messageRepository = messageRepository;
//	}
	
	@RequestMapping( method=RequestMethod.POST )
	@ResponseBody
	public void postMessage( HttpServletRequest request) {
//		try {
//			String message = IOUtils.toString(request.getReader());
//			this.messageRepository.addMessage(message);
//		} catch( IOException e) {
//			throw new RuntimeException(e);
//		}
		try {
			String message = IOUtils.toString(request.getReader());
			for( DeferredResult<String> dr : chatRequests ) {
				dr.setResult(message);
			}
			
//			ChatMessage chatMessage = new ChatMessage();
//			chatMessage.setMessage(message);
//			for( DeferredResult<ChatMessage> dr : crossRequests ) {
//				dr.setResult(chatMessage);
//			}
			
			for( Entry<DeferredResult<String>, String> entry : crossRequests.entrySet() ) {
				String result = entry.getValue() + "({\"message\":\"" + message + "\"})";
				entry.getKey().setResult(result);
			}
			
		} catch( IOException e ) {
			throw new RuntimeException(e);
		}
		
	}
	
	@RequestMapping( method=RequestMethod.GET )
	@ResponseBody
	public DeferredResult<String> getMessage() {
		final DeferredResult<String> deferredResult = new DeferredResult<String>();
		deferredResult.onCompletion(new Runnable() {
			
			@Override
			public void run() {
				chatRequests.remove(deferredResult);
			}
		});
		
		this.chatRequests.add(deferredResult);
		return deferredResult;
		
//		return new Callable<String>() {
//
//			@Override
//			public String call() throws Exception {
//				return messageRepository.getMessage();
//			}
//			
//		};
	}
	
	@RequestMapping( value="/chat", method=RequestMethod.GET ) 
	public String chat() {
		return "chat";
	}
	
	@RequestMapping( value="/mobile", method=RequestMethod.GET )
	public String mobile() {
		return "mobile";
	}
	
	@RequestMapping( value="cross", method=RequestMethod.GET ) 
	@ResponseBody
	public DeferredResult<String> cross(@RequestParam("callbackparam") String callbackparam, ModelMap model) {
		final String func = callbackparam;
//		return new Callable<String>() {
//
//			@Override
//			public String call() throws Exception {
//				Thread.sleep(2000);
//				return func + "([{ \"name\":\"sean\"} ])";
//			}
//			
//		};
		
		
		final DeferredResult<String> deferredResult = new DeferredResult<String>();
		deferredResult.onCompletion(new Runnable() {
			
			@Override
			public void run() {
				crossRequests.remove(deferredResult);
			}
		});
		this.crossRequests.put(deferredResult, func);
		return deferredResult;
	}
	
}
