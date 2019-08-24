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
	
	@RequestMapping(value = "/chart.do", method=RequestMethod.POST)
	@ResponseBody
	public List<HashMap> getChartData(@RequestBody HashMap<String, Object> map) throws Exception {
		System.out.println("map : "+map);
		List<HashMap> list = chartService.selectSensorDataByPeriod("chart.selectSensorDataByDay", map);
		System.out.println("list : " + list);
		return list;
	}
	
	@RequestMapping(value = "/test.do", method=RequestMethod.POST)
	@ResponseBody
	public List<HashMap> getDonut(@RequestBody HashMap<String, Object> map) throws Exception {
		System.out.println("map : "+map);
		List<HashMap> list = chartService.selectSensorDataByPeriod("chart.selectSensorDetectionCheck", map);
		System.out.println("list : " + list);
		return list;
	}
}
