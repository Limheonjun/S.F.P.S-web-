package sfps.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.databind.ObjectMapper;

import sfps.service.MainService;
import sfps.vo.InstallLocationVO;
import sfps.vo.SensorDataVO;
import sfps.vo.SensorDetectionCheckVO;
import sfps.vo.TensorflowCheckVO;

@Controller
public class MainController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "MainService")
	private MainService mainService;
	
	@RequestMapping(value = "/map.do",  method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView showMap(@RequestBody HashMap<String, Object> map) throws Exception {
//		List<InstallLocationVO> list = mainService.selectInstallLocation("sfps.selectInstallLocation");
//		ObjectMapper mapper = new ObjectMapper();
//		String jsonText = mapper.writeValueAsString(list);
//		ModelAndView mv = new ModelAndView("/right/top/map");
//		mv.addObject("list", jsonText);
		System.out.println("Map : "+map);
		ModelAndView mv = new ModelAndView("/main");
		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(map);
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
		ModelAndView mv = new ModelAndView("/left/status");	
		return mv;
	}
	
	@RequestMapping(value = "/sensordata.do", method=RequestMethod.POST)
	public void insertSensorData(@RequestBody SensorDataVO vo) throws Exception {
		mainService.insertSensorData("sfps.insertSensorData", vo);
	}
	
	@RequestMapping(value = "/sensordetectioncheck.do", method=RequestMethod.POST)
	public void insertSensorDetectionCheck(@RequestBody SensorDetectionCheckVO vo) throws Exception {
		mainService.insertSensorDetectionCheck("sfps.insertSensorDetectionCheck", vo);
	}
	
	@RequestMapping(value = "/tensorflowcheck.do", method=RequestMethod.POST)
	public void insertTensorflowCheck(@RequestBody TensorflowCheckVO vo) throws Exception {
		mainService.insertTensorflowCheck("sfps.insertTensorflowCheck", vo);
	}
	
	
}
