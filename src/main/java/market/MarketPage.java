package market;

import java.util.List;

import org.springframework.stereotype.Component;

import common.PageVO;


@Component
public class MarketPage extends PageVO {

	private List<MarketVO> list;

	public List<MarketVO> getList() {
		return list;
	}

	public void setList(List<MarketVO> list) {
		this.list = list;
	}




	
	
	
	
}
