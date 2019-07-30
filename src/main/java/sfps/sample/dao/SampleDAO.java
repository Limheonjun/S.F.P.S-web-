package sfps.sample.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import sfps.common.dao.AbstractDAO;
import sfps.vo.InstallLocation;


@Repository("sampleDAO")
public class SampleDAO extends AbstractDAO {

	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception{ 
		return (List<Map<String, Object>>)selectList("sample.selectBoardList", map); 
	}
	
	@SuppressWarnings("unchecked")
	public List<InstallLocation> selectLocations() throws Exception{
		return selectList("location.selectInstallLocation");
	}


}
