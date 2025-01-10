package kr.co.itsmart.profileMnt.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.itsmart.profileMnt.dao.FileDAO;
import kr.co.itsmart.profileMnt.vo.FileVO;

@Service
public class FileServiceImpl implements FileService {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
    
	@Autowired
    private FileDAO FileDAO;

	@Override
	public List<FileVO> getFileList(FileVO vo) {
		return FileDAO.getFileList(vo);
	}

	@Override
	public FileVO getFileInfo(FileVO vo) {
		return FileDAO.getFileInfo(vo);
	}

}
