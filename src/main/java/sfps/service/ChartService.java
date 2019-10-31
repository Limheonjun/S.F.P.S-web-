package sfps.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import sfps.dao.ChartDao;
import sfps.vo.ChartVO;


@Service("ChartService")
public class ChartService {
Logger log = Logger.getLogger(this.getClass()); 
	
	@Resource(name="ChartDao") 
	private ChartDao chartDao; 
	
	public List<HashMap> selectSensorData(String queryId, HashMap<String, Object> map) throws Exception {
		return chartDao.selectSensorData(queryId, map);
	}
	
}
