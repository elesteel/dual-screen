package cn.touchmedia.sean.dualscreen;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

import org.springframework.stereotype.Repository;

@Repository
public class InMemoryMessageRepository implements MessageRepository {
	BlockingQueue<String> messages = new LinkedBlockingQueue<String>();
	
	@Override
	public String getMessage() {
		try {
		    return messages.take();
		} catch ( InterruptedException e ) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public void addMessage(String message) {
		try {
			messages.put(message);
		} catch ( InterruptedException e ) {
			throw new RuntimeException(e);
		}

	}

}
