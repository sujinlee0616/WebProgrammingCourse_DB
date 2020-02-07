package com.sist.dao;
// VO : 음악정보 한 개에 관한 정보를 가지고 있는 애. (한 줄에 대한 정보를 갖고 있음) ★★★ ==> VO : 리스트 출력 
// VO를 50개 묶고 싶다? ==> ArrayList 이용 ==> ArrayList : 목록 출력 
/*
 *  mno NUMBER,
    rank NUMBER,
    title VARCHAR2(500),
    singer VARCHAR2(200),
    album VARCHAR2(300),
    poster VARCHAR2(260),
    idcrement NUMBER,
    state CHAR(4),
    key VARCHAR2(100)
*/
// 캡슐화 코딩!!
public class MusicVO {
	private int mno;
	private int rank;
	private String title;
	private String singer;
	private String album;
	private String poster;
	private int idcrement;
	private String state;
	private String key;
	
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSinger() {
		return singer;
	}
	public void setSinger(String singer) {
		this.singer = singer;
	}
	public String getAlbum() {
		return album;
	}
	public void setAlbum(String album) {
		this.album = album;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public int getIdcrement() {
		return idcrement;
	}
	public void setIdcrement(int idcrement) {
		this.idcrement = idcrement;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	
	
}
