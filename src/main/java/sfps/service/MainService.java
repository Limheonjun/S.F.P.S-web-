package sfps.service;

import java.util.List; 
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import sfps.dao.MainDao;
import sfps.vo.InstallLocation;

@Service("MainService")
public class MainService{

	Logger log = Logger.getLogger(this.getClass()); 
	
	@Resource(name="MainDao") 
	private MainDao mainDao; 
	

	public List<InstallLocation> selectInstallLocation() throws Exception {
		return mainDao.selectInstallLocation();
	}

	
}
