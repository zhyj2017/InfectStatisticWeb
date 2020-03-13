package dao;

import java.sql.Date;
import pojo.Province;

public interface ProvinceDAO {
	void add(Province province);

	void update(Province province);

	void delete(String name, Date date);

	Province get(String name, Date date);

	Province[] getListByDate(Date date);
	
	Province[] getListByName(String name);
}
