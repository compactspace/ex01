package kr.happyjob.study.common.comnUtils;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

public class ApiResponseUtil {

	public static <T> ResponseEntity<Map<String, Object>> createResponse(String result, T payload, HttpStatus status) {
		Map<String, Object> response = new HashMap<>();
		response.put("result", result);
		if (payload != null) {
			response.put("payload", payload); // 데이터가 있을 경우 추가
		}
		return new ResponseEntity<>(response, status);
	}

}
