package kr.co.itsmart.profileMnt.service;


import kr.co.itsmart.profileMnt.vo.FileVO;

import java.util.List;

public interface FileService {

    List<FileVO> selectFileList(FileVO file);

	FileVO selectFileInfo(FileVO file);

}
