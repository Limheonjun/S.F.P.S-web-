package sfps.controller;

  
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.databind.ObjectMapper;

import sfps.service.MainService;
import sfps.vo.InstallLocationVO;
import sfps.vo.SensorDataVO;
import sfps.vo.SensorDetectionCheckVO;
import sfps.vo.TelecomCheckVO;
import sfps.vo.TensorflowCheckVO;

@Controller
public class MainController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "MainService")
	private MainService mainService;
	
	@RequestMapping(value = "/map.do")
	public ModelAndView showMap() throws Exception {
		List<InstallLocationVO> list = mainService.selectInstallLocation("sfps.selectInstallLocation");
		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(list);
		ModelAndView mv = new ModelAndView("/map");
		mv.addObject("list", jsonText);
		return mv;
	}
	
	@RequestMapping(value = "/main.do")
	public ModelAndView showMain() throws Exception {
		ModelAndView mv = new ModelAndView("/main");
		List<InstallLocationVO> list = mainService.selectInstallLocation("sfps.selectInstallLocation");
		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(list);
		mv.addObject("list", jsonText);
		return mv;
	}
	
	@RequestMapping(value = "/status.do")
	public ModelAndView chat() {
		ModelAndView mv = new ModelAndView("/status");	
		return mv;
	}
	
	@RequestMapping(value = "/contents.do")
	public ModelAndView loadContents() throws Exception {
		ModelAndView mv = new ModelAndView("/contents");
		List<InstallLocationVO> list = mainService.selectInstallLocation("sfps.selectInstallLocation");
		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(list);
		mv.addObject("list", jsonText);
		return mv;
	}
	
	
	@RequestMapping(value = "/log.do")
	public ModelAndView loadLog() throws Exception {
		ModelAndView mv = new ModelAndView("/log");	
		List<SensorDataVO> list = mainService.selectSensorData("sfps.selectSensorData");
		mv.addObject("list", list);
		return mv;
	}
	
	@RequestMapping(value = "/sensor_log.do")
	public ModelAndView loadSensor() throws Exception {
		ModelAndView mv = new ModelAndView("/sensor_log");	
		List<SensorDataVO> list = mainService.selectSensorData("sfps.selectSensorData");
		mv.addObject("list", list);
		return mv;
	}
	
	@RequestMapping(value = "/telecom_log.do")
	public ModelAndView loadTelecom() throws Exception {
		ModelAndView mv = new ModelAndView("/telecom_log");	
		List<TelecomCheckVO> list = mainService.selectTelecomCheck("sfps.selectTelecomCheck");
		mv.addObject("list", list);
		return mv;
	}
	
	@RequestMapping(value = "/tensorflow_log.do")
	public ModelAndView loadTensorflow() throws Exception {
		ModelAndView mv = new ModelAndView("/tensorflow_log");	
		List<TensorflowCheckVO> list = mainService.selectTensorflowCheck("sfps.selectTensorflowCheck");
		mv.addObject("list", list);
		return mv;
	}
	
	@RequestMapping(value = "/sensordetection_log.do")
	public ModelAndView loadSensorDetection() throws Exception {
		ModelAndView mv = new ModelAndView("/sensordetection_log");	
		List<SensorDetectionCheckVO> list = mainService.selectSensorDetectionCheck("sfps.selectSensorDetectionCheck");
		mv.addObject("list", list);
		return mv;
	}



}
