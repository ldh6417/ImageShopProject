package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.domain.CodeGroup;
import com.project.service.CodeGroupService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/codegroup")
public class CodeGroupController {
	@Autowired
	private CodeGroupService service;

	// 코드그룹입력 페이지요청
	@GetMapping("/register")
	public void registerForm(Model model) throws Exception {
		CodeGroup codeGroup = new CodeGroup();
		model.addAttribute(codeGroup);
		// return "/codegroup/regiseter";
	}

	// 코드그룹등록 처리요청
	@PostMapping("/register")
	public String register(CodeGroup codeGroup, RedirectAttributes rttr) throws Exception {
		int count = service.register(codeGroup);
		log.info("codeGroup/regiset =" + count);
		// rttr.addFlashAttribute("msg", "SUCCESS") 세션에 정보를 임시저장한다.
		if (count != 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
			return "redirect:/codegroup/list";
		}
		return "redirect:/codegroup/register";
	}

	// 코드그룹 목록페이지요청
	@GetMapping("/list")
	public void list(Model model) throws Exception {
		log.info("model.getAttribute(msg) = " + model.getAttribute("msg"));
		model.addAttribute("list", service.list());
	}
	
	// 코드 그룹 상세 페이지
	@GetMapping("/read")
	public void read(CodeGroup groupCode, Model model) throws Exception { 
	model.addAttribute(service.read(groupCode));
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
