package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

	// 댓글 등록 처리
	@PostMapping("/replyRegister")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	public String replyRegister(String username, Reply reply, RedirectAttributes rttr) throws Exception {
		Member member = memberservice.readByNo(username);
		reply.setUserNo(member.getUserNo());

		int count = replyService.register(reply);

		if (count != 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
		} else {
			rttr.addFlashAttribute("msg", "FAIL");
		}
		return "redirect:/board/read?boardNo=" + reply.getBoardNo();
	}

	// 댓글 삭제 처리
	@PostMapping("/replyRemove")
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	public String replyRemove(Reply reply, RedirectAttributes rttr) throws Exception {
		int count = replyService.replyRemove(reply);

		if (count != 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
		} else {
			rttr.addFlashAttribute("msg", "FAIL");
		}
		return "redirect:/board/read?boardNo=" + reply.getBoardNo();
	}

	// 댓글 수정 처리
	@PostMapping("/modify")
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	public String repliesUpdate(Reply reply) throws Exception {
		replyService.modify(reply);
		return "redirect:/board/read?boardNo=" + reply.getBoardNo();
	}

}
