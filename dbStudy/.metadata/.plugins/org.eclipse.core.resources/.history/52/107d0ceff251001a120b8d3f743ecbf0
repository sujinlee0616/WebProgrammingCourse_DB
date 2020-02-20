package com.sist.movie;
import java.util.*;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class MovieManager {
	public ArrayList<MovieVO> movieListData()
	{
		ArrayList<MovieVO> list = new ArrayList<MovieVO>();
		// 몇 개가 들어올지 모르니까 ArrayList 사용
		try {
			// 1페이지부터 마지막 페이지(3p)까지 긁어옴
			MovieDAO dao=new MovieDAO();
			//for(int i=1;i<=6;i++) // 페이지 수. 1페이지인 애는 주석처리. 
			{
				Document doc=Jsoup.connect("https://movie.daum.net/boxoffice/yearly").get();
				// movieId 긁으려고 a태그 가져오자. 
				Elements link=doc.select("div.info_tit a"); // 다 똑같이 a태그니까 Elements 사용가능  
				// <a href="/moviedb/main?movieId=122091" class="name_movie #title">남산의 부장들</a>
				// Elements : HTML의 element(tag)들을 말함.   
				for(int j=0;j<link.size();j++)
				{
					try {
						Element elem=link.get(j);
						//System.out.println((i)+"-"+elem.attr("href")); // a 태그의 속성(ex.href)을 가져오고 싶으면  'attr'을 사용해야함.
						//System.out.println((i)+"-"+elem.text()); // 이렇게 하면 a 태그의 값을 가져옴 ==> 영화제목			
						String mLink="https://movie.daum.net"+elem.attr("href"); // mLink에 영화 상세페이지 링크 저장  
						Document doc2 = Jsoup.connect(mLink).get(); //doc2는 URL(mLink)에 접속해 Document(HTML)를 가져온다. 
						//System.out.println(doc2); //doc2가 mLink의 Document 가져오는 것 확인 
						
						// 영화 정보 각각 가져와서 담기 
						/*
						 * private String title;
						 * private double score;
						 * private String genre;
						 * private String regdate;
						 * private String time;
						 * private String grade;
						 * private String director;
						 * private String actor;
						 * private String story;
						*/						
						// 제목, 평점, 장르, .... 등 우리가 가져오려고 하는 정보들이 같은 태그를 사용하지 않기 떄문에
						// 이 정보들을 한번에 Elements로 가져올 수 없다
						// ==> 같은 정보들만 같은 태그를 가지고 있으므로 (ex. 모든 영화제목은 strong 태그 사용) 정보 종류별로 Element 각각 만들어준다. 
						Element title=doc2.selectFirst("div.subject_movie strong.tit_movie"); 
						//selectFirst : 첫번째 태그 가져옴. div.subject_movie 안에 strong이 여러개일 것 같아서 selectFirst 사용했다.
						System.out.println(title.text());
						Element score= doc2.selectFirst("div.subject_movie em.emph_grade");
						System.out.println(score.text());
						Element genre=doc2.select("dl.list_movie dd.txt_main").get(0);  //dd.txt_main이 여러개 ==> get(#)로 가져왔음  
						System.out.println(genre.text());
						Element regdate=doc2.select("dl.list_movie dd.txt_main").get(1); 
						System.out.println(regdate.text());
						
						Element timeAndGrade=doc2.select("dl.list_movie dd").get(3); 
						System.out.println(timeAndGrade.text()); // 102분, 전체관람가  
						// 시간이랑 관람등급 붙어나오므로 StringTokenizer로 두 개 분리해주자.
						// 인셉션은 재개봉일자가 세번째 dd여서  ,기준으로 StringTokenizer 할 수 없음 
						// try catch 안 해주면 인셉션 전까지만 데이터 가져옴. 
						// try catch 하면 오류난 부분(인셉션)에서 for문 증감식으로 다시 올라간 다음 다시 수행함. ==> 인셉션 한 바퀴 빼고 다음부터 다시 for문 돈다.
						String temp=timeAndGrade.text();
						StringTokenizer st=new StringTokenizer(temp,","); 
						String strTime=st.nextToken();
						String strGrade=st.nextToken().trim();
						System.out.println(strTime);
						System.out.println(strGrade);
						
						Element director=doc2.select("dl.list_movie dd.type_ellipsis").get(0);
						System.out.println(director.text());
						Element actor=doc2.select("dl.list_movie dd.type_ellipsis").get(1);
						System.out.println(actor.text());
						Element story=doc2.selectFirst("div.desc_movie p");
						System.out.println(story.text());
						
						MovieVO vo = new MovieVO();
						vo.setTitle(title.text());
						vo.setScore(Double.parseDouble(score.text()));
						vo.setGrade(strGrade);
						vo.setTime(strTime);
						vo.setActor(actor.text());
						vo.setDirector(director.text());
						vo.setGenre(genre.text());
						vo.setRegdate(regdate.text());
						vo.setStory(story.text());
						
						dao.movieInsert(vo);
						
					} catch (Exception ex) {}				
					
				}
			}
			System.out.println("DataBase Insert End....");
		} catch (Exception ex) {}
		return list;
		
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		MovieManager m = new MovieManager();
		m.movieListData();
	}

}



/* <Jsoup으로 값 추출>
 * 구성요소.text(); : 구성요소 값을 반환(태그는 포함하지 않음)
 * 구성요소.attr("속성이름"); : 구성요소 "속성이름"에 대한 값을 반환
 * 구성요소.html(); : 구성요소 값을 반환(태그도 포함)
 * 구성요소.outerHtml(); : 구성요소를 반환(태그와 값 모두)
 * 
 * ex) 
 * <div class="a">
 * 		<p>aaaa</p>
 * 		<a href="https://www.daum.net/">bbb</a>
 * </div>
 * 
 * 위의 값들을 추출해보자...
 * div.a p 	=> text() 		==> aaaa
 * div.a a 	=> attr("href") ==> https://www.daum.net/
 * div.a 	=> text() 		==> aaaa bbb
 * 			   html()		==> <p>aaaa</p>
 * 								<a href="https://www.daum.net/">bbb</a>
 */