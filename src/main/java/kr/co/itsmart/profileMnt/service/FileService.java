package kr.co.itsmart.profileMnt.service;


import kr.co.itsmart.profileMnt.vo.FileVO;

import java.util.List;

public interface FileService {

    List<FileVO> getFileList(FileVO file);

	FileVO getFileInfo(FileVO file);

}
