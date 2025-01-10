package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.FileVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FileDAO {
	
	public List<FileVO> getFileList(FileVO vo);
	
	public FileVO getFileInfo(FileVO vo);
}
