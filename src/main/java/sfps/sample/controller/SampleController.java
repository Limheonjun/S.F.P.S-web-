package sfps.sample.controller;

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
import sfps.common.common.CommandMap;
import sfps.sample.service.SampleService;
import sfps.vo.InstallLocation;

@Controller
public class SampleController {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "sampleService")
	private SampleService sampleService;

	@RequestMapping(value = "/sample/openSampleList.do")
	public ModelAndView openSampleList(Map<String, Object> commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sample/boardList");

		List<Map<String, Object>> list = sampleService.selectBoardList(commandMap);
		mv.addObject("list", list);

		log.debug("인터셉터 테스트");

		return mv;
	}

	@RequestMapping(value = "/sample/testMapArgumentResolver.do")
	public ModelAndView testMapArgumentResolver(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("");
		if (commandMap.isEmpty() == false) {
			Iterator<Entry<String, Object>> iterator = commandMap.getMap().entrySet().iterator();
			Entry<String, Object> entry = null;
			while (iterator.hasNext()) {
				entry = iterator.next();
				log.debug("key : " + entry.getKey() + ", value : " + entry.getValue());
			}
		}
		return mv;
	}
	
	@RequestMapping(value = "/map.do")
	public ModelAndView showMap() throws Exception {
		List<InstallLocation> list = sampleService.selectInstallLocation();
		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(list);
		ModelAndView mv = new ModelAndView("/map");
		mv.addObject("list", jsonText);
		return mv;
	}
	
	@RequestMapping(value = "/main.do")
	public ModelAndView showMain() throws Exception {
		ModelAndView mv = new ModelAndView("/main");
		List<InstallLocation> list = sampleService.selectInstallLocation();
		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(list);
		mv.addObject("list", jsonText);
		return mv;
	}


}
