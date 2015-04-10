package cn.touchmedia.sean.dualscreen;

import java.io.IOException;
import java.util.Map;
import java.util.Queue;
import java.util.Map.Entry;
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
@RequestMapping("/pepsi")
public class PepsiController {
	
	private final Queue<DeferredResult<String>> q2mRequests = 
			new ConcurrentLinkedQueue<DeferredResult<String>>();
	
	private final Map<DeferredResult<String>, String> m2qRequests = 
			new ConcurrentHashMap<DeferredResult<String>, String>();

	@RequestMapping(value="/m2q", method=RequestMethod.POST)
	@ResponseBody
	public void mobileToQscreen( HttpServletRequest request ) {
		try {
			String message = IOUtils.toString(request.getReader());
			System.out.println("receive: " + message);
//			for( DeferredResult<String> dr : m2qRequests ) {
//				dr.setResult(message);
//			}
			
			for( Entry<DeferredResult<String>, String> entry : m2qRequests.entrySet() ) {
				String result = entry.getValue() + "(\"" + message + "\")";
				entry.getKey().setResult(result);
			}
		} catch ( IOException e ) {
			throw new RuntimeException(e);
		}
	}
	
	@RequestMapping(value="/qget", method=RequestMethod.GET,
			produces = "text/plain; charset=utf-8" )
	@ResponseBody
	public DeferredResult<String> qGet(@RequestParam("callbackparam") String callbackparam, ModelMap model) {
		System.out.println("qget");
		final DeferredResult<String> deferredResult = new DeferredResult<String>();
		deferredResult.onCompletion(new Runnable() {
			
			@Override
			public void run() {
				m2qRequests.remove(deferredResult);
			}
		});
		
		this.m2qRequests.put(deferredResult, callbackparam);
		return deferredResult;
	}
	
	@RequestMapping(value="q2m", method=RequestMethod.GET)
	@ResponseBody
	public void qscreenToMobile( 
			@RequestParam("callbackparam") String callbackparam,
			@RequestParam("message") String message) {

			//String message = IOUtils.toString(request.getReader());
			System.out.println("q2m: " + message);
//			for( Entry<DeferredResult<String>, String> entry : q2mRequests.entrySet() ) {
//				//String result = entry.getValue() + "({\"message\":\"" + message + "\"})";
//				entry.getKey().setResult(message);
//			}
			for( DeferredResult<String> dr : q2mRequests) {
				dr.setResult(message);
			}
		
	}
	
	@RequestMapping(value="/mget", method=RequestMethod.GET)
	@ResponseBody
	public DeferredResult<String> mGet() {
		final DeferredResult<String> deferredResult = new DeferredResult<String>();
		deferredResult.onCompletion(new Runnable() {

			@Override
			public void run() {
				q2mRequests.remove(deferredResult);
			}
			
		});
		this.q2mRequests.add(deferredResult);
		return deferredResult;
	}
	
	@RequestMapping(value="/msend", method=RequestMethod.GET)
	public String mobile() {
		return "pepsiSend";
	}
	
	@RequestMapping(value="/msend2", method=RequestMethod.GET)
	public String msend2() {
		return "kkk";
	}
	
	@RequestMapping(value="/finish", method=RequestMethod.GET)
	public String finish() {
		return "finish";
	}
	
}
