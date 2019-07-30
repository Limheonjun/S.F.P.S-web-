package sfps.dao;

import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import sfps.vo.InstallLocation;


@Repository("MainDao")
public class MainDao{
	protected Log log = LogFactory.getLog(MainDao.class);
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	protected void printQueryId(String queryId) {
		if(log.isDebugEnabled()){
			log.debug("\t QueryId  \t:  " + queryId);
		}
	}

	public List<InstallLocation> selectInstallLocation()throws Exception {
		//printQueryId(queryId);
		return sqlSession.selectList("location.selectInstallLocation");
	}

}
