package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.CommonVO;
import kr.co.itsmart.profileMnt.vo.FileVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface CommonService {

    List<CommonVO> selectCodeList(Map<String, String> params);

    List<CommonVO> getTaskMidCodeList(String code_id);

    FileVO saveImageFile(MultipartFile file);

    int selectMaxHistSeq(String user_id);

    void insertUsrFileInfo(FileVO file);

}
