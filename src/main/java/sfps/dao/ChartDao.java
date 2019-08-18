package sfps.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import sfps.vo.ChartVO;

@Repository("ChartDao")
public class ChartDao {
	protected Log log = LogFactory.getLog(MainDao.class);
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	protected void printQueryId(String queryId) {
		if(log.isDebugEnabled()){
			log.debug("\t QueryId  \t:  " + queryId);
		}
	}
	
	public List<HashMap> selectSensorDataByPeriod(String queryId, HashMap<String, Object> map)throws Exception {
		printQueryId(queryId);
		return sqlSession.selectList(queryId, map);
	}
	
	public List<HashMap> selectSensorDetectionCheckByPeriod(String queryId, HashMap<String, Object> map)throws Exception {
		printQueryId(queryId);
		return sqlSession.selectList(queryId, map);
	}
	
	public List<HashMap> selectTensorflowCheckByPeriod(String queryId, HashMap<String, Object> map)throws Exception {
		printQueryId(queryId);
		return sqlSession.selectList(queryId, map);
	}
	
	public List<HashMap> selectTelecomCheckByPeriod(String queryId, HashMap<String, Object> map)throws Exception {
		printQueryId(queryId);
		return sqlSession.selectList(queryId, map);
	}

}
