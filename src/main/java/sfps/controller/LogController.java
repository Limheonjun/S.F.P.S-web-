package sfps.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
		System.out.println("test");
		ModelAndView mv = new ModelAndView("/log/log");	
		List<SensorDataVO> list = logService.selectSensorData("sfps.selectSensorData");
		mv.addObject("list", list);
		return mv;
	}
	
	@RequestMapping(value = "/sensor_log.do")
	public ModelAndView loadSensor() throws Exception {
		ModelAndView mv = new ModelAndView("/log/sensor_log");	
		List<SensorDataVO> list = logService.selectSensorData("sfps.selectSensorData");
		mv.addObject("list", list);
		return mv;
	}
	
	@RequestMapping(value = "/telecom_log.do")
	public ModelAndView loadTelecom() throws Exception {
		ModelAndView mv = new ModelAndView("/log/telecom_log");	
		List<TelecomCheckVO> list = logService.selectTelecomCheck("sfps.selectTelecomCheck");
		mv.addObject("list", list);
		return mv;
	}
	
	@RequestMapping(value = "/tensorflow_log.do")
	public ModelAndView loadTensorflow() throws Exception {
		ModelAndView mv = new ModelAndView("/log/tensorflow_log");	
		List<TensorflowCheckVO> list = logService.selectTensorflowCheck("sfps.selectTensorflowCheck");
		mv.addObject("list", list);
		return mv;
	}
	
	@RequestMapping(value = "/sensordetection_log.do")
	public ModelAndView loadSensorDetection() throws Exception {
		ModelAndView mv = new ModelAndView("/log/sensordetection_log");	
		List<SensorDetectionCheckVO> list = logService.selectSensorDetectionCheck("sfps.selectSensorDetectionCheck");
		mv.addObject("list", list);
		return mv;
	}
}
