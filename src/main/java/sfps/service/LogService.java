package sfps.service;

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
	

	public List<SensorDataVO> selectSensorData(String queryId) throws Exception {
		return logDao.selectSensorData(queryId);
	}
	
	public List<SensorDetectionCheckVO> selectSensorDetectionCheck(String queryId) throws Exception {
		return logDao.selectSensorDetectionCheck(queryId);
	}
	
	public List<TelecomCheckVO> selectTelecomCheck(String queryId) throws Exception {
		return logDao.selectTelecomCheck(queryId);
	}
	
	public List<TensorflowCheckVO> selectTensorflowCheck(String queryId) throws Exception {
		return logDao.selectTensorflowCheck(queryId);
	}
	
	public List<SensorCheckVO> selectSensorCheck(String queryId) throws Exception {
		return logDao.selectSensorCheck(queryId);
	}
	
}
