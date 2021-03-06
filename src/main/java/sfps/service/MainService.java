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
		
	public void insertSensorData(String queryId, SensorDataVO vo) throws Exception{
		mainDao.insertSensorData(queryId, vo);
	}
	
	public void insertSensorDetectionCheck(String queryId, SensorDetectionCheckVO vo) throws Exception{
		mainDao.insertSensorDetectionCheck(queryId, vo);
	}
	
	public void insertTensorflowCheck(String queryId, TensorflowCheckVO vo) throws Exception{
		mainDao.insertTensorflowCheck(queryId, vo);
	}

	
}
