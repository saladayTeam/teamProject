package kr.co.saladay.admin.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.saladay.admin.model.vo.FAQ;

@Repository
public class FaqDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	/** fqlList 조회
	 * @return
	 */
	public List<FAQ> selectFaqList() {
		
		return sqlSession.selectList("faqMapper.selectFaqList");
	}
	
	
}
