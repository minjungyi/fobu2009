package main.java.fobu.admin.bbs.service;

import main.java.fobu.common.util.StringUtil;


/**
 * 
 * 
 * @author min
 * @since 2013. 01. 10.
 */
public class BbsVO {

	private String idx;					//게시판 관리 IDX
	private String ref;					//게시판 그룹 참조값
	private String lvl;					//게시판 글 레벨
	private String stp;					//게시판 그룹 순서
    private String typeCode;            //게시판 타입코드
	private String title;				//게시판 제목
	private String content;				//게시판 내용
	private String createDt;			//게시판 등록일
	private String creater;				//등록자 ID
	private String createrNm;			//등록자 
	private String modifyDt;			//게시판 수정일
	private String modifier;			//수정자 ID
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getRef() {
		return ref;
	}
	public void setRef(String ref) {
		this.ref = ref;
	}
	public String getLvl() {
		return lvl;
	}
	public void setLvl(String lvl) {
		this.lvl = lvl;
	}
	public String getStp() {
		return stp;
	}
	public void setStp(String stp) {
		this.stp = stp;
	}
	public String getTypeCode() {
		return typeCode;
	}
	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreateDt() {
		return createDt;
	}
	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}
	public String getCreater() {
		return creater;
	}
	public void setCreater(String creater) {
		this.creater = creater;
	}
	public String getCreaterNm() {
		return createrNm;
	}
	public void setCreaterNm(String createrNm) {
		this.createrNm = createrNm;
	}
	public String getModifyDt() {
		return modifyDt;
	}
	public void setModifyDt(String modifyDt) {
		this.modifyDt = modifyDt;
	}
	public String getModifier() {
		return modifier;
	}
	public void setModifier(String modifier) {
		this.modifier = modifier;
	}
}
