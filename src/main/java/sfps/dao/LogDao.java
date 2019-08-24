package sfps.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import sfps.vo.SensorCheckVO;
import sfps.vo.SensorDataVO;
import sfps.vo.SensorDetectionCheckVO;
import sfps.vo.TelecomCheckVO;
import sfps.vo.TensorflowCheckVO;

@Repository("LogDao")
public class LogDao {
	protected Log log = LogFactory.getLog(MainDao.class);
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	protected void printQueryId(String queryId) {
		if(log.isDebugEnabled()){
			log.debug("\t QueryId  \t:  " + queryId);
		}
	}
	
	public List<SensorDataVO> selectSensorData(String queryId)throws Exception {
		printQueryId(queryId);
		return sqlSession.selectList(queryId);
	}
	
	public List<SensorCheckVO> selectSensorCheck(String queryId)throws Exception {
		printQueryId(queryId);
		return sqlSession.selectList(queryId);
	}
	
	public List<SensorDetectionCheckVO> selectSensorDetectionCheck(String queryId)throws Exception {
		printQueryId(queryId);
		return sqlSession.selectList(queryId);
	}
	
	public List<TelecomCheckVO> selectTelecomCheck(String queryId)throws Exception {
		printQueryId(queryId);
		return sqlSession.selectList(queryId);
	}
	
	public List<TensorflowCheckVO> selectTensorflowCheck(String queryId)throws Exception {
		printQueryId(queryId);
		return sqlSession.selectList(queryId);
	}
}