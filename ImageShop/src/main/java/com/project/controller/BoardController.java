package com.project.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.commom.security.domain.CustomUser;
import com.project.common.domain.CodeLabelValue;
import com.project.common.domain.PageRequest;
import com.project.common.domain.Pagination;
import com.project.domain.Board;
import com.project.domain.Member;
import com.project.service.BoardService;
import com.project.service.ReplyService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private BoardService service;
	
	@Autowired
	private ReplyService replyservice;

	// 게시글 등록 페이지
	@GetMapping("/register")
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	public void registerForm(Model model, Authentication authentication) throws Exception {
		// 로그인한 사용자 정보 획득
		User user = (User) authentication.getPrincipal();
		CustomUser customUser = (CustomUser) user;
		Member member = customUser.getMember();

		Board board = new Board();
		// 로그인한 사용자 아이디를 등록 페이지에 표시
		board.setWriter(member.getUserId());
		model.addAttribute(board);
	}

	// 게시글 등록 처리
	@PostMapping("/register")
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	public String register(Board board, RedirectAttributes rttr) throws Exception {
		int count = service.register(board);
		if (count != 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
		} else {
			rttr.addFlashAttribute("msg", "FAIL");
		}
		return "redirect:/board/list";
	}

	// 게시글 목록 페이지
	@GetMapping("/list")

	public void list(@ModelAttribute("pgrq") PageRequest pageRequest, Model model) throws Exception {
		if (pageRequest.getPage() == 0) {
			pageRequest = new PageRequest();
		}
		// 4페이지를 보여주는 기능 디비에서 31~40 가져온다.
		model.addAttribute("list", service.list(pageRequest));
		// 페이지를 보여주는 기능 ([prev]1,2,3,[4],5,6,7,8,9,10 [next = true])
		Pagination pagiRequest = new Pagination();
		// 현재 페이지 4, 한페이지당 보여주는 갯수 10개셋팅
		pagiRequest.setPageRequest(pageRequest);
		// 리스트 전체갯수 세팅 다시계산
		pagiRequest.setTotalCount(service.count(pageRequest));
		// 화면 페이지를 보여주는 정보를 제공
		model.addAttribute("pagination", pagiRequest);

		// 검색 유형의 코드명과 코드값을 정의한다.
		List<CodeLabelValue> searchTypeCodeValueList = new ArrayList<CodeLabelValue>();
		searchTypeCodeValueList.add(new CodeLabelValue("n", "---"));
		searchTypeCodeValueList.add(new CodeLabelValue("t", "Title"));
		searchTypeCodeValueList.add(new CodeLabelValue("c", "Content"));
		searchTypeCodeValueList.add(new CodeLabelValue("w", "Writer"));
		searchTypeCodeValueList.add(new CodeLabelValue("tc", "Title OR Content"));
		searchTypeCodeValueList.add(new CodeLabelValue("cw", "Content OR Writer"));
		searchTypeCodeValueList.add(new CodeLabelValue("tcw", "Title OR Content OR Writer"));

		model.addAttribute("searchTypeCodeValueList", searchTypeCodeValueList);

	}

	// 게시글 상세 페이지
	@GetMapping("/read")
	public void read(Board board, @ModelAttribute("pgrq") PageRequest pageRequest, Model model) throws Exception {
		model.addAttribute(service.read(board));
		model.addAttribute("replyList",replyservice.list(board));
	}

	// 게시글 수정 페이지
	@GetMapping("/modify")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	public void modifyForm(Board board, @ModelAttribute("pgrq") PageRequest pageRequest, Model model) throws Exception {
		model.addAttribute(service.read(board));
	}

	// 게시글 수정 처리
	@PostMapping("/modify")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	public String modify(Board board, PageRequest pageRequest, RedirectAttributes rttr) throws Exception {
		int count = service.modify(board);
		rttr.addFlashAttribute("page", pageRequest.getPage());
		rttr.addFlashAttribute("sizePerPage", pageRequest.getSizePerPage());

		if (count != 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
		} else {
			rttr.addFlashAttribute("msg", "FAIL");
		}
		return "redirect:/board/list" + pageRequest.toUriString();

	}

	// 게시글 삭제 처리
	@GetMapping("/remove")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	public String remove(Board board, PageRequest pageRequest, RedirectAttributes rttr) throws Exception {
		int count = service.remove(board);

		rttr.addFlashAttribute("page", pageRequest.getPage());
		rttr.addFlashAttribute("sizePerPage", pageRequest.getSizePerPage());

		if (count != 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
		} else {
			rttr.addFlashAttribute("msg", "FAIL");
		}
		return "redirect:/board/list" + pageRequest.toUriString();
	}

}
