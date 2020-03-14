package pojo;

import java.sql.Date;

public class Province {
	private String name;
	private int nowIp, nowSp;
	private int allIp, allSp, allCure, allDead;
	private Date date;

	public String getName() {
		return name;
	}

	public int getNowIp() {
		return nowIp;
	}

	public int getNowSp() {
		return nowSp;
	}

	public int getAllIp() {
		return allIp;
	}

	public int getAllSp() {
		return allSp;
	}

	public int getAllCure() {
		return allCure;
	}

	public int getAlldead() {
		return allDead;
	}

	public Date getDate() {
		return date;
	}

	public void setName(String param) {
		name = param;
	}

	public void setNowIp(int param) {
		nowIp = param;
	}

	public void setNowSp(int param) {
		nowSp = param;
	}

	public void setAllIp(int param) {
		allIp = param;
	}

	public void setAllSp(int param) {
		allSp = param;
	}

	public void setAllCure(int param) {
		allCure = param;
	}

	public void setAllDead(int param) {
		allDead = param;
	}

	public void setDate(Date param) {
		date = param;
	}
}
