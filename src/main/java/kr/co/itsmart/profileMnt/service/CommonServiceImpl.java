package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.dao.CommonDAO;
import kr.co.itsmart.profileMnt.vo.CommonVO;
import kr.co.itsmart.profileMnt.vo.FileVO;
import kr.co.itsmart.profileMnt.vo.LoginVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Service
public class CommonServiceImpl implements CommonService {
    private static final Logger LOGGER = LoggerFactory.getLogger(CommonServiceImpl.class);
    private final CommonDAO commonDAO;
    @Value("${file.upload-dir}")
    private String uploadDir;

    public CommonServiceImpl(CommonDAO commonDAO) {
        this.commonDAO = commonDAO;
    }

    @Override
    public List<CommonVO> selectCodeList(Map<String, String> params) {
        return commonDAO.selectCodeList(params);
    }

    ;
    @Override
    public List<CommonVO> getTaskMidCodeList(String code_id) {
        return commonDAO.getTaskMidCodeList(code_id);
    }

    @Override
    public FileVO saveImageFile(MultipartFile file) {
        LOGGER.info("파일 저장을 시작합니다");
        FileVO tempFile = null;
        try {
            tempFile = new FileVO();
            // 파일 확인
            if (!file.isEmpty()) {
                String oriFileNm = file.getOriginalFilename();
                String extension = oriFileNm.substring(oriFileNm.lastIndexOf(".") + 1);
                LOGGER.info("oriFileNm={}, extension={}", oriFileNm, extension);

                // 파일 저장 경로 생성
                String sverFileNm = UUID.randomUUID().toString().replaceAll("-", "") + "." + extension;
                File uploadPath = new File(uploadDir, sverFileNm);
                LOGGER.info("uploadPath={}", uploadPath);

                // 서버에 파일 저장
                file.transferTo(uploadPath);
                LOGGER.info("파일을 저장했습니다.");

                // fileVO 객체에 데이터 setting
                tempFile.setFile_ori_nm(oriFileNm);
                tempFile.setFile_sver_nm(sverFileNm);
                tempFile.setFile_sver_path(uploadDir + "/" + sverFileNm);
                tempFile.setFile_extension(extension);
            }
        } catch (Exception e) {
            LOGGER.debug("파일 저장 실패: ", e.getMessage());
        }
        return tempFile;
    }

    @Override
    public int selectMaxHistSeq(String user_id) {
        return commonDAO.selectMaxHistSeq(user_id);
    }
    @Override
    public void insertUsrFileInfo(FileVO file) {
        try {
            commonDAO.insertUsrFileInfo(file);
            LOGGER.info("파일 정보를 저장했습니다.");

        } catch (Exception e){
            LOGGER.debug("파일 정보 저장 실패: user_id={}, file_seq={}", file.getUser_id(), file.getFile_seq(), e.getMessage());
        }
    }

    @Override
    public Optional<LoginVO> getUsrInfo(String user_id) {
        return commonDAO.getUsrInfo(user_id);
    }

}
