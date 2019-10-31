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

import sfps.service.ChartService;
import sfps.vo.ChartVO;
import sfps.vo.SensorDataVO;
import sfps.vo.TensorflowCheckVO;

@Controller
public class ChartController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "ChartService")
	private ChartService chartService;
	
	@RequestMapping(value = "/chart.do", method=RequestMethod.GET)
	public ModelAndView openChart() throws Exception {
		ModelAndView mv = new ModelAndView("/chart/chart");
		return mv;
	}

	
	@RequestMapping(value = "/sensordataChart.do", method=RequestMethod.POST)
	@ResponseBody
	public List<HashMap> getSensorData(@RequestBody HashMap<String, Object> map) throws Exception {
		System.out.println("map : "+map);
		if(map.get("location") == "") map.put("location", null);
		if(map.get("date") == "") map.put("date", null);
		List<HashMap> list = chartService.selectSensorData("chart.selectSensorData", map);
		System.out.println("list : " + list);
		return list;
	}
	
	@RequestMapping(value = "/sensordetectioncheckChart.do", method=RequestMethod.POST)
	@ResponseBody
	public List<HashMap> getSensorDetectionCheck(@RequestBody HashMap<String, Object> map) throws Exception {
		System.out.println("map : "+map);
		if(map.get("location") == "") map.put("location", null);
		if(map.get("date") == "") map.put("date", null);
		List<HashMap> list = chartService.selectSensorData("chart.selectSensorDetectionCheck", map);
		System.out.println("list : " + list);
		return list;
	}
	
	@RequestMapping(value = "/tensorflowcheckChart.do", method=RequestMethod.POST)
	@ResponseBody
	public List<HashMap> getTensorflowCheck(@RequestBody HashMap<String, Object> map) throws Exception {
		System.out.println("map : "+map);
		if(map.get("location") == "") map.put("location", null);
		if(map.get("date") == "") map.put("date", null);
		List<HashMap> list = chartService.selectSensorData("chart.selectTensorflowCheck", map);
		System.out.println("list : " + list);
		return list;
	}
	
	@RequestMapping(value = "/telecomcheckChart.do", method=RequestMethod.POST)
	@ResponseBody
	public List<HashMap> getTelecomCheck(@RequestBody HashMap<String, Object> map) throws Exception {
		System.out.println("map : "+map);
		if(map.get("location") == "") map.put("location", null);
		if(map.get("date") == "") map.put("date", null);
		List<HashMap> list = chartService.selectSensorData("chart.selectTelecomCheck", map);
		System.out.println("list : " + list);
		return list;
	}
}
