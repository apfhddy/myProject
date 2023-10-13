package page;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public class Page_DAO {
	private SqlSession sqlSession;
	
	public Page_DAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<Page_DTO> getList(int k){
		return sqlSession.selectList("page.getList",k);
	}
	
	public Map<String,Object> getPage(int k) {
		return sqlSession.selectOne("page.getPage", k);
	}
	
	public void savePage(Map<String,Object> map){
		sqlSession.update("page.savePage",map);
	}
	
	public int nextSeq() {
		return sqlSession.selectOne("page.nextSeq");
	}
	
	public void addPage(Page_DTO dto) {
		sqlSession.insert("page.addPage",dto);
	}
	
	public int nextOrderNo(int k) {
		return sqlSession.selectOne("page.nextOrderNo",k);
	}
	
	public int deletePage(int k) {
		return sqlSession.delete("page.deletePage",k);
	}
	
	public int childrenAdd(Map<String,Object> map) {
		return sqlSession.update("page.childrenAdd",map);
	}
	
	public void updateOrder(Map<String,Object> map) {
		sqlSession.update("page.updateOrder",map);
	}
	
	public void updateParent(Map<String,Object> map) {
		sqlSession.update("page.updateParent",map);
	}
}
