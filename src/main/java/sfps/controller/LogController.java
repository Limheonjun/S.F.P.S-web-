package sfps.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import sfps.service.LogService;
import sfps.vo.SensorDataVO;
import sfps.vo.SensorDetectionCheckVO;
import sfps.vo.TelecomCheckVO;
import sfps.vo.TensorflowCheckVO;

@Controller
public class LogController {
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "LogService")
	private LogService logService;
	
	@RequestMapping(value = "/log.do")
	public ModelAndView loadLog() throws Exception {
		ModelAndView mv = new ModelAndView("/log/log");	
		return mv;
	}
	
	@RequestMapping(value = "/sensorLog.do")
	@ResponseBody
	public List<SensorDataVO> loadSensor(@RequestBody HashMap<String, Object> map) throws Exception {	
		if(map.get("location") == "") map.put("location", null);
		List<SensorDataVO> list = logService.selectSensorData("sfps.selectSensorData", map);
		return list;
	}
	
	@RequestMapping(value = "/telecomLog.do")
	@ResponseBody
	public List<TelecomCheckVO> loadTelecom(@RequestBody HashMap<String, Object> map) throws Exception {
		if(map.get("location") == "") map.put("location", null);
		if(map.get("result") == "") map.put("result", null);
		List<TelecomCheckVO> list = logService.selectTelecomCheck("sfps.selectTelecomCheck", map);
		return list;
	}
	
	@RequestMapping(value = "/tensorflowLog.do")
	@ResponseBody
	public List<TensorflowCheckVO> loadTensorflow(@RequestBody HashMap<String, Object> map) throws Exception {
		if(map.get("location") == "") map.put("location", null);
		if(map.get("result") == "") map.put("result", null);
		List<TensorflowCheckVO> list = logService.selectTensorflowCheck("sfps.selectTensorflowCheck", map);
		return list;
	}
	
	@RequestMapping(value = "/sensordetectionLog.do")
	@ResponseBody
	public List<SensorDetectionCheckVO> loadSensorDetection(@RequestBody HashMap<String, Object> map) throws Exception {
		System.out.println(map);
		if(map.get("location") == "") map.put("location", null);
		if(map.get("result") == "") map.put("result", null);
		List<SensorDetectionCheckVO> list = logService.selectSensorDetectionCheck("sfps.selectSensorDetectionCheck", map);
		return list;
	}
}
