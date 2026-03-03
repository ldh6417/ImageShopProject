package com.project.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.domain.Item;
import com.project.service.ItemService;

@Controller
@RequestMapping("/item")
public class ItemController {
	@Autowired
	private ItemService itemService;

	@Value("${upload.path}")
	private String uploadPath;

	// 상품 등록 페이지
	@GetMapping("/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void registerForm(Model model) {
		model.addAttribute(new Item());
	}

	// 상품 등록 처리
	@PostMapping("/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String register(Item item, RedirectAttributes rttr) throws Exception {
		// 클라이언트가 보낸 이미지 파일의 정보 모두 로드가 되었음
		MultipartFile pictureFile = item.getPicture();
		MultipartFile previewFile = item.getPreview();

		String createdPictureFilename = uploadFile(pictureFile.getOriginalFilename(), pictureFile.getBytes());
		String createdPreviewFilename = uploadFile(previewFile.getOriginalFilename(), previewFile.getBytes());

		item.setPictureUrl(createdPictureFilename);
		item.setPreviewUrl(createdPreviewFilename);

		int count = itemService.register(item);

		if (count != 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");

		} else {
			rttr.addFlashAttribute("msg", "FAIL");
		}
		return "redirect:/item/list";
	}

	// 상품 목록 페이지
	@GetMapping("/list")
	public void list(Model model) throws Exception {
		List<Item> itemList = itemService.list();
		model.addAttribute("itemList", itemList);
	}

	// 상품 수정 페이지
	@GetMapping("/modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String modifyForm(Item item, Model model) throws Exception {

		model.addAttribute(itemService.read(item));

		return "item/modify";
	}

	// 썸네일 미리보기 이미지 표시
	@ResponseBody
	@RequestMapping("/display")
	public ResponseEntity<byte[]> displayFile(Item item) throws Exception {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		// 썸네일 이미지 파일명을 DB로 부터 가져온다.
		String fileName = itemService.getPreview(item);
		try {
			// jpg 확장자명을 가져온다.
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			// jpg 미디어타입을 리턴받는다.MediaType.IMAGE_JPEG
			MediaType mType = getMediaType(formatName);

			// httpHeader는 서버가 브라우저에게 정보를 담아서 보내주는 객체
			HttpHeaders headers = new HttpHeaders();

			// 파일명을 읽는다 InputStream(바이트 단위로 읽는다.)
			// D:/upload/파일명.jpg 위치를 찾아서 파일을 InputStream 으로 읽는다.
			in = new FileInputStream(uploadPath + File.separator + fileName);

			if (mType != null) {
				// httpHeader는 서버가 브라우저에게 정보를 담아서 보내주는 객체에 미디어타입을 셋팅
				headers.setContentType(mType);
			}
			// 전송 json방식
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		// 웹브라우저에게 바이트 단위로 이미지를 전송한다.
		return entity;
	}

	// 원본 이미지 표시
	@ResponseBody
	@RequestMapping("/picture")
	public ResponseEntity<byte[]> pictureFile(Item item) throws Exception {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		String fileName = itemService.getPicture(item);
		try {
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			MediaType mType = getMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			in = new FileInputStream(uploadPath + File.separator + fileName);

			if (mType != null) {
				headers.setContentType(mType);
			}

			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		return entity;
	}

	// 상품 수정 처리
	@PostMapping("/modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String modify(Item item, RedirectAttributes rttr) throws Exception {
		MultipartFile pictureFile = item.getPicture();
		if (pictureFile != null && pictureFile.getSize() > 0) {
			String createdFilename = uploadFile(pictureFile.getOriginalFilename(), pictureFile.getBytes());
			// 기존의 이지지파일 삭제
			Item item2 = itemService.read(item);
			String pictureUrl = item2.getPictureUrl();
			File _pictureFile = new File(uploadPath, pictureUrl);
			_pictureFile.delete();

			item.setPictureUrl(createdFilename);
		}

		MultipartFile previewFile = item.getPreview();

		if (previewFile != null && previewFile.getSize() > 0) {
			String createdFilename = uploadFile(previewFile.getOriginalFilename(), previewFile.getBytes());
			// 기존의 프리뷰 파일 삭제
			Item item2 = itemService.read(item);
			String previewUrl = item2.getPreviewUrl();
			File _previewFile = new File(uploadPath, previewUrl);
			_previewFile.delete();

			item.setPreviewUrl(createdFilename);
		}
		int count = itemService.modify(item);
		if (count != 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
		} else {
			rttr.addFlashAttribute("msg", "FAIL");
		}
		return "redirect:/item/list";
	}

	// 상품 삭제화면 페이지요청
	@GetMapping("/remove")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String removeForm(Item item, Model model) throws Exception {
		Item _item = itemService.read(item);
		model.addAttribute(_item);
		return "item/remove";
	}

	// 상품 삭제 처리
	@PostMapping("/remove")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String remove(Item item, RedirectAttributes rttr) throws Exception {
		// 외장 하드에 있는 상품이미지를 먼저 제거
		Item _item = itemService.read(item);
		String pictureUrl = _item.getPictureUrl();
		String previewUrl = _item.getPreviewUrl();

		if (pictureUrl != null && pictureUrl.length() > 0) {
			File _pictureFile = new File(uploadPath, pictureUrl);
			_pictureFile.delete();
		}

		if (previewUrl != null && previewUrl.length() > 0) {
			File _previewFile = new File(uploadPath, previewUrl);
			_previewFile.delete();

		}

		// item 상품테이블에서 삭제 처리
		int count = itemService.remove(item);
		if (count != 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
		} else {
			rttr.addFlashAttribute("msg", "FAIL");
		}
		return "redirect:/item/list";
	}

	// 상품 상세 페이지
	@GetMapping("/read")
	public String read(Item item, Model model) throws Exception {
		Item _item = itemService.read(item);
		model.addAttribute("item",_item);
		return "item/read";
	}

	// 썸네일 이미지 표시
	private MediaType getMediaType(String formatName) {
		if (formatName != null) {
			if (formatName.equals("JPG")) {
				return MediaType.IMAGE_JPEG;
			}
			if (formatName.equals("GIF")) {
				return MediaType.IMAGE_GIF;
			}

			if (formatName.equals("PNG")) {
				return MediaType.IMAGE_PNG;
			}
		}
		return null;
	}

	// 상품 이미지파일명 상품 이미지 데이터 Byte[] 업로드
	private String uploadFile(String originalName, byte[] fileData) throws Exception {
		// 절대로 중복되지않는 아이디를 랜덤으로 생성
		UUID uid = UUID.randomUUID();
		String createdFileName = uid.toString() + "_" + originalName;
		// D 드라이브에 파일명.jpg 파일생성
		File target = new File(uploadPath, createdFileName);
		FileCopyUtils.copy(fileData, target);
		return createdFileName;
	}

}
