package com.project.service;

import java.util.List;

import com.project.domain.Board;
import com.project.domain.Reply;

public interface ReplyService {
	public int register(Reply reply) throws Exception;

	public List<Board> list(Board board) throws Exception;
}
