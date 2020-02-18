package com.sist.manager;
import java.text.SimpleDateFormat;
import java.util.*;
import com.sist.vo.*;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import com.sist.dao.*;

public class MovieManager {
	MovieDAO dao = MovieDAO.newInstance(); //싱글톤 객체 생성 
	// 전역변수로 잡아서 movieListData()에서도 쓰고 newsAllData()에서도 쓰겠다. 
	
	// ===================================== Movie =====================================
	public ArrayList<MovieVO> movieListData()
	{
		ArrayList<MovieVO> list = new ArrayList<MovieVO>();
		
		try {
			int k=1;
			//for(int i=1;i<=7;i++) // 페이지 수. 1페이지인 애는 주석처리. 
			{
				Document doc=Jsoup.connect("https://movie.daum.net/boxoffice/yearly").get();
				// Document doc=Jsoup.connect("https://movie.daum.net/boxoffice/yearly").get();
				// 긁는 애들 타입별로 밑에서 type 숫자 바꿔준다.
				Elements link=doc.select("div.info_tit a"); 
 
				for(int j=0;j<link.size();j++)
				{
					try {
						Element elem=link.get(j);	
						String mLink="https://movie.daum.net"+elem.attr("href"); // mLink에 영화 상세페이지 링크 저장  
						Document doc2 = Jsoup.connect(mLink).get(); //doc2는 URL(mLink)에 접속해 Document(HTML)를 가져온다. 
						 
						Element title=doc2.selectFirst("div.subject_movie strong.tit_movie"); 
						System.out.println(title.text());
						Element score= doc2.selectFirst("div.subject_movie em.emph_grade");
						System.out.println(score.text());
						Element genre=doc2.select("dl.list_movie dd.txt_main").get(0);  //dd.txt_main이 여러개 ==> get(#)로 가져왔음  
						System.out.println(genre.text());
						Element regdate=doc2.select("dl.list_movie dd.txt_main").get(1); 
						System.out.println(regdate.text());
						Element timeAndGrade=doc2.select("dl.list_movie dd").get(3); 
						System.out.println(timeAndGrade.text()); // 102분, 전체관람가  
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
						Element poster=doc2.selectFirst("a.area_poster img.img_summary");
						
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
						vo.setPoster(poster.attr("src"));
						vo.setType(5);
						
						dao.movieInsert(vo);
						
						// 데이터 몇 개 들어갔는지 확인
						System.out.println("k="+k);
						k++;
						
					} catch (Exception ex) {}				
					
				}
			}
			System.out.println("DataBase Insert End....");
		} catch (Exception ex) {}
		return list;
		
	}
	
	
	// ===================================== News =====================================
	public ArrayList<NewsVO> newsAllData()
	{
		ArrayList<NewsVO> list = new ArrayList<NewsVO>();
		Date date=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
		String today=sdf.format(date);
		
		try 
		{			
			for(int i=1;i<=18;i++) //총 18페이지니까
			{
				Document doc = Jsoup.connect("https://movie.daum.net/magazine/new?tab=nws&regdate="+today+"&page="+i).get(); 
				// Document: HTML 가져온다.
				// doc: https://movie.daum.net/magazine/new에서 소스보기 하면 나오는 HTML들이 저장됨.
				// https://movie.daum.net/magazine/new?tab=nws&regdate=20200218&page=4 
				
				Elements title=doc.select("ul.list_line strong.tit_line a");
				Elements poster=doc.select("ul.list_line a.thumb_line span.thumb_img");
				Elements link=doc.select("ul.list_line strong.tit_line a");
				// temp는 작성자와 등록일을 동시에 가지고 있음 
				Elements temp=doc.select("span.cont_line span.state_line");
				Elements content=doc.select("span.cont_line a.desc_line");
				
				for(int j=0;j<title.size();j++)
				{
					// 잘 나오는지 확인 
					System.out.println(title.get(j).text());
					
					String ss=poster.get(j).attr("style");
					ss=ss.substring(ss.indexOf("(")+1, ss.lastIndexOf(")"));
					System.out.println(ss);
					
					System.out.println(link.get(j).attr("href"));
					// temp를 작성자와 등록일로 나누기 
					// 뉴스엔・발행일자20.02.18
					String str=temp.get(j).text();
					String author=str.substring(0, str.indexOf("・"));
					String regdate=str.substring(str.lastIndexOf("자")+1);
					System.out.println(author);
					System.out.println(regdate);
					//System.out.println(temp.get(j).text());
					System.out.println(content.get(j).text());
					System.out.println("================================");
					
					// DB에 넣는다 
					NewsVO vo=new NewsVO();
					vo.setTitle(title.get(j).text());
					vo.setLink(link.get(j).attr("href"));
					vo.setContent(content.get(j).text());
					vo.setPoster(ss);
					vo.setRegdate(regdate);
					vo.setAuthor(author);
					
					// 오라클 전송
					dao.newsInsert(vo);
					
				}
			}
			System.out.println("Save End ...");
					
		} 
		catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
		
		return list;
	}
	
	public static void main(String[] args) {
		MovieManager m = new MovieManager();
		
		// 함수 실행 - 어디에다가 데이터 넣을지에 따라서 알맞은 함수를 실행시킨다. 
		//m.movieListData();
		//m.newsAllData();
	}

}

