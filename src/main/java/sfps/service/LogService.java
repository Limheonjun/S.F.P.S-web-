package sfps.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import sfps.dao.LogDao;
import sfps.dao.MainDao;
import sfps.vo.SensorCheckVO;
import sfps.vo.SensorDataVO;
import sfps.vo.SensorDetectionCheckVO;
import sfps.vo.TelecomCheckVO;
import sfps.vo.TensorflowCheckVO;

@Service("LogService")
public class LogService{

	Logger log = Logger.getLogger(this.getClass()); 
	
	@Resource(name="LogDao") 
	private LogDao logDao; 
	

	public List<SensorDataVO> selectSensorData(String queryId, HashMap<String, Object> map) throws Exception {
		return logDao.selectSensorData(queryId, map);
	}
	
	public List<SensorDetectionCheckVO> selectSensorDetectionCheck(String queryId, HashMap<String, Object> map) throws Exception {
		return logDao.selectSensorDetectionCheck(queryId, map);
	}
	
	public List<TelecomCheckVO> selectTelecomCheck(String queryId, HashMap<String, Object> map) throws Exception {
		return logDao.selectTelecomCheck(queryId, map);
	}
	
	public List<TensorflowCheckVO> selectTensorflowCheck(String queryId, HashMap<String, Object> map) throws Exception {
		return logDao.selectTensorflowCheck(queryId, map);
	}
	
	public List<SensorCheckVO> selectSensorCheck(String queryId, HashMap<String, Object> map) throws Exception {
		return logDao.selectSensorCheck(queryId, map);
	}
	
	public int getListCount(String queryId)throws Exception {
		return logDao.getListCount(queryId);
	}
}
