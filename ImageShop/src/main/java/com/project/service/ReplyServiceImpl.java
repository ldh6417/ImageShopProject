package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.domain.Board;
import com.project.domain.Reply;
import com.project.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService {
	@Autowired
	private ReplyMapper mapper;

	@Override
	@Transactional
	public int register(Reply reply) throws Exception {
		return mapper.register(reply);
	}

	@Override
	public List<Board> list(Board board) throws Exception {
		return mapper.list(board);
	}

	@Override
	@Transactional
	public int replyRemove(Reply reply) throws Exception {
		return mapper.replyRemove(reply);
	}

	@Override
	public void modify(Reply reply) throws Exception {
		 mapper.update(reply);
		
	}



}
