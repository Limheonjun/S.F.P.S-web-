package sfps.dao;

import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import sfps.vo.InstallLocationVO;
import sfps.vo.SensorCheckVO;
import sfps.vo.SensorDataVO;
import sfps.vo.SensorDetectionCheckVO;
import sfps.vo.TelecomCheckVO;
import sfps.vo.TensorflowCheckVO;


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

	public List<InstallLocationVO> selectInstallLocation(String queryId)throws Exception {
		printQueryId(queryId);
		return sqlSession.selectList("sfps.selectInstallLocation");
	}
	
	public void insertSensorData(String queryId, SensorDataVO vo) throws Exception{
		printQueryId(queryId);
		sqlSession.insert(queryId, vo);
	}
	
	public void insertSensorDetectionCheck(String queryId, SensorDetectionCheckVO vo) throws Exception{
		printQueryId(queryId);
		sqlSession.insert(queryId, vo);
	}
	
	public void insertTensorflowCheck(String queryId, TensorflowCheckVO vo) throws Exception{
		printQueryId(queryId);
		sqlSession.insert(queryId, vo);
	}

}
