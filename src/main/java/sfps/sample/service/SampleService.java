package sfps.sample.service;

import java.util.List;
import java.util.Map;

import sfps.vo.InstallLocation;

public interface SampleService {

	List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception;
	List<InstallLocation> selectInstallLocation() throws Exception;

}
