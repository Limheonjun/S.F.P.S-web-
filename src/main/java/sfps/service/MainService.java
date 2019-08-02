package sfps.service;

import java.util.List; 
import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import sfps.dao.MainDao;
import sfps.vo.InstallLocationVO;
import sfps.vo.SensorCheckVO;
import sfps.vo.SensorDataVO;
import sfps.vo.SensorDetectionCheckVO;
import sfps.vo.TelecomCheckVO;
import sfps.vo.TensorflowCheckVO;

@Service("MainService")
public class MainService{

	Logger log = Logger.getLogger(this.getClass()); 
	
	@Resource(name="MainDao") 
	private MainDao mainDao; 
	

	public List<InstallLocationVO> selectInstallLocation(String queryId) throws Exception {
		return mainDao.selectInstallLocation(queryId);
	}
	
	public List<SensorDataVO> selectSensorData(String queryId) throws Exception {
		return mainDao.selectSensorData(queryId);
	}
	
	public List<SensorDetectionCheckVO> selectSensorDetectionCheck(String queryId) throws Exception {
		return mainDao.selectSensorDetectionCheck(queryId);
	}
	
	public List<TelecomCheckVO> selectTelecomCheck(String queryId) throws Exception {
		return mainDao.selectTelecomCheck(queryId);
	}
	
	public List<TensorflowCheckVO> selectTensorflowCheck(String queryId) throws Exception {
		return mainDao.selectTensorflowCheck(queryId);
	}
	
	public List<SensorCheckVO> selectSensorCheck(String queryId) throws Exception {
		return mainDao.selectSensorCheck(queryId);
	}

	
}
