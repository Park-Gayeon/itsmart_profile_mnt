package kr.co.itsmart.profileMnt.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.itsmart.profileMnt.vo.FileVO;

@Mapper
public interface FileDAO {
	
	public List<FileVO> selectFileList(FileVO vo);
	
	public FileVO selectFileInfo(FileVO vo);
}
