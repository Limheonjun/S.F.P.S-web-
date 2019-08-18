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
	
	
//	@RequestMapping(value = "/test.do")
//	@ResponseBody
//	public String test() throws Exception {
//		List<HashMap> list = chartService.selectSensorDataByDay("chart.selectSensorDataByDay");
//		System.out.println(list);
//		ObjectMapper mapper = new ObjectMapper();
//		String jsonText = mapper.writeValueAsString(list);
//		return jsonText;
//	}
	
	@RequestMapping(value = "/chart.do", method=RequestMethod.POST)
	@ResponseBody
	public List<HashMap> getSensorData(@RequestBody HashMap<String, Object> map) throws Exception {
		List<HashMap> list = chartService.selectSensorDataByPeriod("chart.select"+map.get("table")+"ByPeriod", map);
		return list;
	}
	
//	@RequestMapping(value = "/sensordetectioncheckchart.do", method=RequestMethod.POST)
//	@ResponseBody
//	public List<HashMap> getSensorDetectionCheck(@RequestBody HashMap<String, Object> map) throws Exception {
//		List<HashMap> list = chartService.selectSensorDetectionCheckByPeriod("chart.selectSensorDetectionCheckByPeriod", map);
//		return list;
//	}
//	
//	@RequestMapping(value = "/tensorflowcheckchart.do", method=RequestMethod.POST)
//	@ResponseBody
//	public List<HashMap> getTensorflowCheck(@RequestBody HashMap<String, Object> map) throws Exception {
//		List<HashMap> list = chartService.selectTensorflowCheckByPeriod("chart.selectTensorflowCheckByPeriod", map);
//		return list;
//	}
//	
//	@RequestMapping(value = "/telecomcheckchart.do", method=RequestMethod.POST)
//	@ResponseBody
//	public List<HashMap> getTelecomCheck(@RequestBody HashMap<String, Object> map) throws Exception {
//		List<HashMap> list = chartService.selectTelecomCheckByPeriod("chart.selectTelecomCheckByPeriod", map);
//		return list;
//	}

}
