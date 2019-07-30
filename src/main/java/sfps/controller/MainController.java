package sfps.controller;

import java.util.Iterator;  
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import net.sf.json.JSONArray;
import sfps.service.MainService;
import sfps.vo.InstallLocation;

@Controller
public class MainController {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "MainService")
	private MainService mainService;
	
	@RequestMapping(value = "/map.do")
	public ModelAndView showMap() throws Exception {
		List<InstallLocation> list = mainService.selectInstallLocation();
		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(list);
		ModelAndView mv = new ModelAndView("/map");
		mv.addObject("list", jsonText);
		return mv;
	}
	
	@RequestMapping(value = "/main.do")
	public ModelAndView showMain() throws Exception {
		ModelAndView mv = new ModelAndView("/main");
		List<InstallLocation> list = mainService.selectInstallLocation();
		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(list);
		mv.addObject("list", jsonText);
		return mv;
	}


}
