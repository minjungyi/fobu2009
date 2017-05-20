package main.java.fobu.admin.operationBbs.service;



/**
 * 
 * 
 * @author min
 * @since 2013. 01. 10.
 */
public class OperationBbsVO {

	private String seq;							//작업요청게시판 seq
	private String title;						//작업요청게시판 제목
	private String content;						//작업요청게시판 내용
	private String operationType;				//작업요청게시판 작업상태
	private String operator;					//작업요청게시판 작업자ID
	private String operatorNm;					//작업요청게시판 작업자
	private String completeDt;					//작업요청게시판 작업완료일자
	private String addFile1;					//작업요청게시판 첨부파일1
	private String addFile2;					//작업요청게시판 첨부파일2
	private String addFile3;					//작업요청게시판 첨부파일3
	private String createDt;					//작업요청게시판 작성일자
	private String creater;						//작업요청게시판 작성자ID
	private String createrNm;					//작업요청게시판 작성자
	private String modifyDt;					//작업요청게시판 수정일자
	private String modifier;					//작업요청게시판 수정자ID

	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
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
	public String getOperationType() {
		return operationType;
	}
	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getOperatorNm() {
		return operatorNm;
	}
	public void setOperatorNm(String operatorNm) {
		this.operatorNm = operatorNm;
	}
	public String getCompleteDt() {
		return completeDt;
	}
	public void setCompleteDt(String completeDt) {
		this.completeDt = completeDt;
	}
	public String getAddFile1() {
		return addFile1;
	}
	public void setAddFile1(String addFile1) {
		this.addFile1 = addFile1;
	}
	public String getAddFile2() {
		return addFile2;
	}
	public void setAddFile2(String addFile2) {
		this.addFile2 = addFile2;
	}
	public String getAddFile3() {
		return addFile3;
	}
	public void setAddFile3(String addFile3) {
		this.addFile3 = addFile3;
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
