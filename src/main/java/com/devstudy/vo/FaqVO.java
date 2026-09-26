package com.devstudy.vo;

public class FaqVO{
	
	private Long faqIdx;
    private String question;
    private String answer;
	public Long getFaqIdx() {
		return faqIdx;
	}
	public void setFaqIdx(Long faqIdx) {
		this.faqIdx = faqIdx;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}

}