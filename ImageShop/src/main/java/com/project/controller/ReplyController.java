package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.domain.Board;
import com.project.domain.Member;
import com.project.domain.Reply;
import com.project.service.MemberService;
import com.project.service.ReplyService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j


@RequestMapping("/reply")
public class ReplyController {
	@Autowired
	private MemberService memberservice;

	@Autowired
	private ReplyService replyService;

	// 게시글 등록 처리
	@PostMapping("/replyRegister")
	public String replyRegister(String username, Reply reply, RedirectAttributes rttr) throws Exception {
		Member member = memberservice.readByNo(username);
		reply.setUserNo(member.getUserNo());

		int count = replyService.register(reply);
		
		if (count != 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
		} else {
			rttr.addFlashAttribute("msg", "FAIL");
		}
		return "redirect:/board/read?boardNo="+reply.getBoardNo();
	}
	

}
