package kr.co.itsmart.profileMnt.service;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.itsmart.profileMnt.configuration.handler.CustomException;
import kr.co.itsmart.profileMnt.dao.*;
import kr.co.itsmart.profileMnt.vo.*;
import net.sf.jxls.transformer.XLSTransformer;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.POIXMLProperties;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.net.URLEncoder;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class ExcelDownServiceImpl implements ExcelDownService {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private final ProjectMntService projectMntService;
    private final FileService fileService;
    private final CommonService commonService;

    private final WorkExperienceDAO workExperienceDAO;
    private final ProjectDAO projectDAO;
    private final ProfileDAO profileDAO;
    private final FileDAO fileDAO;


    private final QualificationDAO qualificationDAO;
    private final CommonDAO commonDAO;

    private static final String UPLOAD_DIR = "template"; // 리소스 디렉토리 내 template 폴더

    public ExcelDownServiceImpl(ProjectMntService projectMntService,
                                FileService fileService,
                                CommonService commonService,
                                @Lazy WorkExperienceDAO workExperienceDAO,
                                @Lazy ProjectDAO projectDAO,
                                ProfileDAO profileDAO,
                                @Lazy QualificationDAO qualificationDAO,
                                @Lazy CommonDAO commonDAO,
                                @Lazy FileDAO fileDAO) {
        this.projectMntService = projectMntService;
        this.commonService = commonService;
        this.fileService = fileService;
        this.projectDAO = projectDAO;
        this.workExperienceDAO = workExperienceDAO;
        this.profileDAO = profileDAO;
        this.qualificationDAO = qualificationDAO;
        this.commonDAO = commonDAO;
        this.fileDAO = fileDAO;
    }

    @Override
    public void downloadUsrProfileAllListExcel(List<ProfileVO> list, HttpServletResponse response) throws IOException {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        try {
            XSSFWorkbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("user_list");

            if (list == null) {
                logger.error("[downloadUsrProfileAllListExcel] 직원 목록이 존재하지 않습니다.");
                throw new CustomException("직원 목록이 존재하지 않습니다.");
            }

            /* TITLE */
            CellStyle titleStyle = workbook.createCellStyle();
            Font titleFont = workbook.createFont();
            titleFont.setBold(true);
            titleFont.setFontName("맑은 고딕");
            titleFont.setFontHeightInPoints((short) 12);
            titleStyle.setFont(titleFont);
            /* TITLE */

            /* HEADER */
            CellStyle headerStyle = workbook.createCellStyle();
            Font headerFont = workbook.createFont();
            headerFont.setFontName("맑은 고딕");
            headerFont.setFontHeightInPoints((short) 11);
            headerStyle.setFont(headerFont);
            headerStyle.setFillForegroundColor(IndexedColors.PALE_BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);
            headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            headerStyle.setBorderLeft(BorderStyle.THIN);
            headerStyle.setBorderTop(BorderStyle.THIN);
            headerStyle.setBorderRight(BorderStyle.THIN);
            headerStyle.setBorderBottom(BorderStyle.THIN);
            /* HEADER */

            /* CONTENT */
            CellStyle contentStyle = workbook.createCellStyle();
            Font contentFont = workbook.createFont();
            contentFont.setFontName("맑은 고딕");
            contentFont.setFontHeightInPoints((short) 11);
            contentStyle.setFont(contentFont);
            contentStyle.setBorderLeft(BorderStyle.THIN);
            contentStyle.setBorderTop(BorderStyle.THIN);
            contentStyle.setBorderRight(BorderStyle.THIN);
            contentStyle.setBorderBottom(BorderStyle.THIN);
            /* CONTENT */

            int rowCount = 0;

            // 엑셀[직원목록] header
            Row listHeader = sheet.createRow(rowCount++);
            applyCellStyle(listHeader, 0, "순번", headerStyle);
            applyCellStyle(listHeader, 1, "이름", headerStyle);
            applyCellStyle(listHeader, 2, "소속", headerStyle);
            applyCellStyle(listHeader, 3, "직급", headerStyle);
            applyCellStyle(listHeader, 4, "발주처", headerStyle);
            applyCellStyle(listHeader, 5, "사업명", headerStyle);
            applyCellStyle(listHeader, 6, "사업시작일", headerStyle);
            applyCellStyle(listHeader, 7, "사업종료일", headerStyle);
            applyCellStyle(listHeader, 8, "수행경력", headerStyle);
            applyCellStyle(listHeader, 9, "자격증여부", headerStyle);

            int num = 1;
            for (ProfileVO profile : list) {
                // 엑셀[자격증] data
                Row listData = sheet.createRow(rowCount++);
                Cell cell = listData.createCell(0);
                cell.setCellValue(num);
                cell.setCellStyle(contentStyle);
                applyCellStyle(listData, 1, profile.getUser_nm(), contentStyle);
                applyCellStyle(listData, 2, profile.getUser_department_nm(), contentStyle);
                applyCellStyle(listData, 3, profile.getUser_position_nm(), contentStyle);
                applyCellStyle(listData, 4, nullChange(profile.getProject_client()), contentStyle);
                applyCellStyle(listData, 5, nullChange(profile.getProject_nm()), contentStyle);
                applyCellStyle(listData, 6, nullChange(profile.getProject_start_date()) == "" ? "" : formatDate(profile.getProject_start_date()), contentStyle);
                applyCellStyle(listData, 7, nullChange(profile.getProject_end_date()) == "" ? "" : formatDate(profile.getProject_end_date()), contentStyle);
                applyCellStyle(listData, 8, convertToString(profile.getProject_totalMonth()), contentStyle);
                applyCellStyle(listData, 9, "1".equals(profile.getQualification_yn()) ? "Y" : "N", contentStyle);

                num++;
            }
            sheet.createRow(rowCount++); // 여백

            sheet.setDefaultColumnWidth((short) 20);

            workbook.write(outputStream);
            workbook.close();

        } catch (IOException e) {
            logger.error("IOException :", e.getMessage());
            e.printStackTrace();
            throw new CustomException("엑셀파일 생성 중 오류가 발생했습니다");
        }

        byte[] outArray = outputStream.toByteArray();
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment");

        ServletOutputStream out = response.getOutputStream();
        out.write(outArray);
        out.flush();
        out.close();
    }

    @Override
    @Transactional
    public void uploadKosaExcel(MultipartFile excel, String user_id) {
        if (excel.isEmpty()) {
            logger.error("[uploadKosaExcel] 파일이 존재하지 않습니다.");
            throw new CustomException("파일이 존재하지 않습니다.");
        }

        try (InputStream inputStream = excel.getInputStream()) {
            Workbook workbook = null;
            try {
                workbook = WorkbookFactory.create(inputStream);
            } catch (Exception e) {
                e.printStackTrace();
            }
            Sheet sheet = workbook.getSheetAt(0);

            int rows = sheet.getPhysicalNumberOfRows();
            logger.info("rowCnt : " + rows);
            boolean deleteYn = false; // 테이블 삭제여부
            boolean createYn = false; // 프로필 이력 생성여부
            int rangeCnt = 0; // kosa 파일의 분류별 range (근무경력, 기술경력, 학력, 기술자격, 교육, 상훈)
            int seq = 0;
            ArrayList<Integer> idxArray = new ArrayList<>();

            // 범주별 키워드를 미리 정의
            Map<Integer, Set<String>> categoryKeywords = new HashMap<>();
            categoryKeywords.put(0, Set.of("회사명", "직위", "근무기간", "담당업무")); // 근무경력
            categoryKeywords.put(1, Set.of("참여사업명", "수행기간", "수행업무", "직무영역 및 기술", "발주처")); // 기술경력
            categoryKeywords.put(2, Set.of("학교명", "학과(전공)", "학위", "입학년월일", "졸업년월일")); // 학력
            categoryKeywords.put(3, Set.of("자격명", "합격일자", "발급기관")); // 기술자격

            WorkExperienceVO work = new WorkExperienceVO();
            ProjectVO project = new ProjectVO();
            ProfileVO profile = new ProfileVO();
            EduVO edu = new EduVO();
            QualificationVO qualification = new QualificationVO();
            UserSkillVO skill = new UserSkillVO();

            int work_hist_seq = workExperienceDAO.selectMaxHistSeq(user_id);
            int project_hist_seq = projectDAO.selectMaxHistSeq(user_id);
            int profile_hist_seq = profileDAO.selectMaxHistSeq(user_id);
            int qualification_hist_seq = qualificationDAO.selectMaxHistSeq(user_id);

            for (int r = 0; r < rows; r++) {
                Row row = sheet.getRow(r);
                int cells = row.getPhysicalNumberOfCells();
                int cnt = 0;

                logger.info("|      " + (r + 1) + "     |");

                if (rangeCnt > 3) {
                    logger.info("교육, 상훈 데이터는 가져오지 않습니다");
                    break;
                }

                if (!idxArray.isEmpty()) {
                    for (int c = 0; c < idxArray.size(); c++) {
                        Cell cell = row.getCell(idxArray.get(c));
                        String value = getValue(cell);

                        if (value.isEmpty()) {
                            cnt++;
                            logger.info("|      " + value + "     |");
                            if (cnt == idxArray.size()) {
                                rangeCnt++;
                                idxArray.clear();
                                deleteYn = false;
                                break;
                            }
                        } else {
                            logger.info("|      " + value + "     |");
                        }
                    }

                    if (idxArray.isEmpty()) {
                        seq = 0;
                        continue;
                    }

                    if (rangeCnt == 0) {
                        logger.info("rangeCnt : " + rangeCnt + " >> 근무경력에 대한 DB 처리");
                        seq++;
                        work.setWork_seq(seq); // 1 부터
                        work.setHist_seq(work_hist_seq);
                        work.setUser_id(user_id); // user_id
                        work.setWork_place(getValue(row.getCell(idxArray.get(0)))); // 근무지
                        work.setWork_position(getValue(row.getCell(idxArray.get(1))));// 직위
                        String[] dateArr = getValue(row.getCell(idxArray.get(2))).split("~");
                        String start_date = dateArr[0].trim().replace(".", "");
                        String end_date = dateArr[1].trim().replace(".", "");
                        work.setWork_start_date(start_date);// 근무기간(시작일)
                        work.setWork_end_date(end_date);// 근무기간(종료일)
                        work.setWork_assigned_task(getValue(row.getCell(idxArray.get(3))));// 직무


                        logger.info(String.valueOf(work.getWork_seq()));
                        logger.info("user_id : " + work.getUser_id());
                        logger.info("place : " + work.getWork_place());
                        logger.info("position : " + work.getWork_position());
                        logger.info("start_date : " + work.getWork_start_date());
                        logger.info("end_date : " + work.getWork_end_date());
                        logger.info("task : " + work.getWork_assigned_task());

                        if (!deleteYn) {
                            // DELETE TB
                            logger.info("사용자 근무경력 정보를 삭제합니다: user_id={}", user_id);
                            workExperienceDAO.deleteUsrWorkInfo(user_id);
                            deleteYn = true;
                        }

                        // UPDATE(=INSERT)
                        logger.info("사용자 근무경력 정보를 입력합니다: user_id={}, work_place", user_id, work.getWork_place());
                        workExperienceDAO.updateUsrWorkInfo(work);

                        // CREATE HIST
                        workExperienceDAO.insertUsrWorkInfoHist(work);
                        logger.info("사용자 근무경력 정보 이력을 생성했습니다: user_id={}", user_id);

                    } else if (rangeCnt == 1) {
                        boolean chk = true;
                        logger.info("rangeCnt : " + rangeCnt + " >> 기술경력에 대한 DB 처리");
                        seq++;
                        project.setProject_seq(seq);
                        project.setHist_seq(project_hist_seq);
                        project.setUser_id(user_id);
                        project.setProject_nm(getValue(row.getCell(idxArray.get(0)))); // 참여사업명
                        String[] dateArr = getValue(row.getCell(idxArray.get(1))).split("~");
                        String start_date = dateArr[0].trim().replace(".", "");
                        String end_date = dateArr[1].trim().replace(".", "");
                        project.setProject_start_date(start_date); // 사업시작일
                        project.setProject_end_date(end_date); // 사업종료일
                        String[] taskArr = getValue(row.getCell(idxArray.get(2))).split(">");
                        String task_lar = taskArr[0].replace(" ", "");
                        String task_mid = taskArr[1].replace(" ", "");
                        String task_code_lar = findTaskCode(task_lar, 1); // 업무구분코드 대분류
                        String task_code_mid = findTaskCode(task_mid, 2); // 업무구분코드 중분류

                        project.setAssigned_task_lar(task_code_lar);
                        project.setAssigned_task_mid(task_code_mid);
                        String skillStr = getValue(row.getCell(idxArray.get(3)));
                        project.setProject_client(getValue(row.getCell(idxArray.get(4)))); // 발주처

                        if (!deleteYn) {
                            // DELETE TB
                            logger.info("사용자 기술정보를 삭제합니다: user_id={}", user_id);
                            projectDAO.deleteUsrAllSkillInfo(user_id);
                            logger.info("사용자 기술경력을 삭제합니다: user_id={}", user_id);
                            projectDAO.deleteUsrAllProjectInfo(user_id);
                            deleteYn = true;
                        }

                        // UPDATE(=INSERT)
                        logger.info("사용자 기술경력 정보를 입력합니다: user_id={}, project_nm", user_id, project.getProject_seq());
                        projectDAO.updateUsrProjectInfo(project);

                        // CREATE HIST
                        projectDAO.insertUsrProjectInfoHist(project);
                        logger.info("사용자 기술경력 정보 이력을 생성했습니다: user_id={}", user_id);

                        if (skillStr.isEmpty()) {
                            logger.info("작성된 기술이 없습니다");
                            chk = false;
                        }
                        if (chk) { // 작성된 기술이 있다면
                            // SKILL UPDATE(INSERT)
                            int skill_hist_seq = projectDAO.selectSkMaxSeq(project);
                            skill.setUser_id(user_id);
                            skill.setHist_seq(skill_hist_seq);
                            skill.setProject_seq(seq);

                            String[] skillArr = skillStr.split(",");

                            for (int i = 0; i < skillArr.length; i++) {
                                int skillId = i + 1;
                                String skillNm = skillArr[i].trim();
                                logger.info("skillNm : " + skillNm);
                                skill.setSkill_id(skillId);
                                skill.setSkill_nm(skillNm);

                                logger.info("사용자 기술정보를 입력합니다: project_nm={}, skill_nm={}", project.getProject_nm(), skill.getSkill_nm());
                                projectDAO.updateUsrSkillInfo(skill);
                                projectDAO.insertUsrSkillInfoHist(skill);
                                logger.info("사용자 기술정보 이력을 생성했습니다");
                            }
                        }
                    } else if (rangeCnt == 2) {
                        seq++;
                        profile.setHist_seq(profile_hist_seq);
                        profile.setUser_id(user_id);
                        edu.setSchool_seq(seq);
                        edu.setHist_seq(profile_hist_seq);
                        edu.setUser_id(user_id);
                        edu.setSchool_nm(getValue(row.getCell(idxArray.get(0))));// 학교명
                        edu.setMajor(getValue(row.getCell(idxArray.get(1))));
                        String gubun = getValue(row.getCell(idxArray.get(2))); // 학위
                        String code = setGubunCode(gubun);
                        edu.setSchool_gubun(code);
                        edu.setGrad_status("001"); // 졸업
                        String startDate = getValue(row.getCell(idxArray.get(3))).replace(".", "");
                        String endDate = getValue(row.getCell(idxArray.get(4))).replace(".", "");
                        edu.setSchool_start_date(startDate); // 입학년월일
                        edu.setSchool_end_date(endDate); // 졸업년월일

                        if (!deleteYn) {
                            // DELETE TB
                            logger.info("사용자 학력 정보를 삭제합니다: user_id={}", user_id);
                            profileDAO.deleteUsrEducationInfo(user_id);
                            deleteYn = true;
                        }

                        // UPDATE(=INSERT)
                        logger.info("사용자 학력 정보를 입력합니다: user_id={}, school_nm", user_id, edu.getSchool_nm());
                        profileDAO.updateUsrEducationInfo(edu);

                        // CREATE HIST
                        if (!createYn) {
                            logger.info("사용자 프로필이력 정보를 입력합니다: user_id={}", user_id);
                            profile.setCreator(user_id);
                            profileDAO.insertUsrProfileInfoHist(profile);
                            createYn = true;
                        }
                        profileDAO.insertUsrEducationInfoHist(edu);
                        logger.info("사용자 학력 정보 이력을 생성했습니다: user_id={}", user_id);
                    } else if (rangeCnt == 3) {
                        seq++;
                        qualification.setQualification_seq(seq);
                        qualification.setHist_seq(qualification_hist_seq);
                        qualification.setUser_id(user_id);
                        qualification.setQualification_nm(getValue(row.getCell(idxArray.get(0)))); // 자격명
                        String startDate = getValue(row.getCell(idxArray.get(1))).replace(".", "");
                        qualification.setAcquisition_date(startDate);
                        qualification.setIssuer(getValue(row.getCell(idxArray.get(2)))); // 발급기관

                        if (!deleteYn) {
                            // DELETE TB
                            logger.info("사용자 기술자격 정보를 삭제합니다: user_id={}", user_id);
                            qualificationDAO.deleteUsrQualificationInfo(user_id);
                            deleteYn = true;
                        }

                        // UPDATE(=INSERT)
                        logger.info("사용자 기술자격 정보를 입력합니다: user_id={}, Qualification_nm={}", user_id, qualification.getQualification_nm());
                        qualificationDAO.updateUsrQualificationInfo(qualification);

                        // CREATE HIST
                        qualificationDAO.insertUsrQualificationInfoHist(qualification);
                        logger.info("사용자 기술자격 정보 이력을 생성했습니다: user_id={}", user_id);
                    }
                } else {
                    for (int c = 0; c < cells; c++) {
                        logger.info("idxArray가 null");
                        Cell cell = row.getCell(c);
                        String value = getValue(cell);

                        Set<String> keywords = categoryKeywords.get(rangeCnt);
                        if (keywords != null && keywords.contains(value)) {
                            idxArray.add(cell.getColumnIndex());
                        }
                        logger.info("|      " + value + "     |");
                    }
                }
            }


        } catch (IOException e) {
            throw new CustomException("엑셀 업로드 중 오류 확인 : " + e.getMessage());
        } catch (EncryptedDocumentException e) {
            e.printStackTrace();
        }

    }

    /**
     * 템플릿 파일(자체) 다운로드
     *
     * @param file_seq, request, response
     * @return 엑셀파일
     */
    @Override
    public void downloadExcelTemplate(String user_id, Integer file_seq, HttpServletRequest request, HttpServletResponse response) {

        if (file_seq == 0) {
            String filePath = "template/template.xlsx"; // 템플릿 파일 경로
            try (InputStream fis = getClass().getClassLoader().getResourceAsStream(filePath)) {
                if (fis == null) {
                    throw new FileNotFoundException("Template file not found: " + filePath);
                }

                // 파일 다운로드를 위한 HTTP 응답 설정
                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                response.setHeader("Content-Disposition", "attachment; filename=\"template.xlsx\"");

                // 파일 데이터를 HTTP 응답 출력 스트림으로 복사
                try (OutputStream os = response.getOutputStream()) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = fis.read(buffer)) != -1) {
                        os.write(buffer, 0, bytesRead);
                    }
                    os.flush();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            File file = null;
            // 파일 정보 조회 (예: file_seq를 사용하여 DB에서 파일 경로 또는 파일명을 가져옵니다.)
            try {
                FileVO fileInfo = new FileVO();

                fileInfo.setUser_id(user_id);
                fileInfo.setFile_seq(file_seq);
                fileInfo.setFile_se("EXCEL_TEMP");

                logger.info("user_id : {}",user_id);
                logger.info("file_seq : {}",file_seq);
                logger.info("file_se : {}",fileInfo.getFile_se());

                FileVO fileVO = fileDAO.selectFileInfo(fileInfo);


                if (fileVO == null) {
                    // 파일을 찾을 수 없는 경우 예외 처리
                    logger.error("File not found with file_seq: " + file_seq);
                }

                // 파일 경로 가져오기 (FileVO에 저장된 파일 경로를 사용)
                String filePath = fileVO.getFile_sver_path();  // 예시: DB에서 저장된 파일 경로

                file = new File(filePath);
                if (!file.exists()) {
                    logger.error("File not found with file_seq: " + file_seq);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            // 파일을 다운로드하기 위한 설정
            try (InputStream in = new FileInputStream(file);
                 OutputStream out = response.getOutputStream()) {

                // 파일 이름 설정
                String fileName = URLEncoder.encode(file.getName(), "UTF-8");

                // 파일 다운로드 헤더 설정
                response.setContentType("application/vnd.ms-excel");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

                // 파일 데이터 스트림 전송
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
                out.flush();  // 데이터 전송 후 flush
            } catch (IOException e) {
                logger.error("Error while downloading file with file_seq: " + file_seq, e);
                throw new RuntimeException("Error while downloading file", e);
            }
        }
    }

    /**
     * 엑셀 템플릿 다운로드
     *
     * @param profile, templateFile, request, response
     * @return 엑셀파일
     */
    @Override
    public void downloadUsrProfileDetailExcelTemplate(ProfileVO profile, FileVO templateFile, HttpServletRequest request,
                                                      HttpServletResponse response) throws IOException {
        InputStream fis = null;

        if (templateFile != null) {
            File file = new File(templateFile.getFile_sver_path());
            logger.info("TEMPLATE_NM : {}, SERVER_PATH : {}", templateFile.getFile_ori_nm(), templateFile.getFile_sver_path());

            if (!file.exists()) {
                logger.error("File not found at: {}", file.getAbsolutePath());
                throw new IOException("Template file not found at: " + file.getAbsolutePath());
            }
            fis = new FileInputStream(file);
            // 메타데이터 확인 로직 추가
            chkMeta(fis, file.getName());

            // FileInputStream을 새로 생성 (이전 스트림은 이미 닫힘)
            fis = new FileInputStream(file);  // 다시 열기

        } else {
            String templatePath = UPLOAD_DIR + "/template.xlsx";
            fis = getClass().getClassLoader().getResourceAsStream(templatePath);

            // 메타데이터 확인 로직 추가
            chkMeta(fis, templatePath);

            // InputStream을 새로 생성
            fis = getClass().getClassLoader().getResourceAsStream(templatePath);  // 다시 열기
        }

        Map<String, Object> personalInfo = new HashMap<>(); //인적사항
        List<Map<String, Object>> educationList = new ArrayList<>(); //학력
        List<Map<String, Object>> certificationList = new ArrayList<>(); //자격증
        List<Map<String, Object>> workExperienceList = new ArrayList<>(); //근무경력
        List<Map<String, Object>> projectExperienceList = new ArrayList<>(); //수행경력

        // [인적사항]
        personalInfo.put("name", profile.getUser_nm());
        personalInfo.put("birthdate", formatDate(profile.getUser_birth()));
        personalInfo.put("phone", formatPhone(profile.getUser_phone()));
        personalInfo.put("email", profile.getUser_id() + "@itsmart.co.kr");
        personalInfo.put("affiliation", profile.getUser_department_nm());
        personalInfo.put("position", profile.getUser_position_nm());
        personalInfo.put("hireDate", formatDate(profile.getHire_date()));
        personalInfo.put("address", profile.getUser_address());

        //학력
        for (EduVO edu : profile.getEducationList()) {
            Map<String, Object> educationInfo = new HashMap<>();
            educationInfo.put("schoolType", gubunKor(edu.getSchool_gubun())); //학교구분
            educationInfo.put("schoolName", edu.getSchool_nm()); //학교명
            educationInfo.put("major", nullChange(edu.getMajor())); //전공명
            educationInfo.put("gpa", castType(edu.getTotal_grade())); //학점
            educationInfo.put("entranceDate", formatDate(edu.getSchool_start_date())); //입학일자
            educationInfo.put("graduationDate", formatDate(edu.getSchool_end_date())); //졸업일자
            educationInfo.put("graduationStatus", statusKor(edu.getGrad_status())); //졸업상태

            educationList.add(educationInfo);
        }

        //자격증
        for (QualificationVO ql : profile.getQualificationList()) {

            Map<String, Object> certificationInfo = new HashMap<>();
            certificationInfo.put("certificateName", ql.getQualification_nm()); //자격증명
            certificationInfo.put("issuingOrganization", ql.getIssuer()); //발행기관
            certificationInfo.put("acquisitionDate", formatDate(ql.getAcquisition_date())); //취득일자
            certificationInfo.put("expirationDate", nullChange(ql.getExpiry_date()).isEmpty() ? "" : formatDate(ql.getExpiry_date())); //만기일자

            certificationList.add(certificationInfo);
        }

        // [근무경력]
        for (WorkExperienceVO work : profile.getWorkExperienceList()) {

            Map<String, Object> workExperience = new HashMap<>();
            workExperience.put("companyName", work.getWork_place()); //회사명
            workExperience.put("position", work.getWork_position()); //직급
            workExperience.put("jobDescription", work.getWork_assigned_task()); //담당업무
            workExperience.put("hireDate", formatDate(work.getWork_start_date())); //입사일자
            workExperience.put("resignationDate", formatDate(work.getWork_end_date())); //퇴사일자

            workExperienceList.add(workExperience);
        }

        // [수행경력]
        for (ProjectVO pj : profile.getProjectList()) {

            Map<String, Object> projectExperience = new HashMap<>();
            List<String> skillNames = new ArrayList<>();

            int project_seq = pj.getProject_seq();
            ProjectVO temp = new ProjectVO();
            temp.setUser_id(profile.getUser_id());
            temp.setProject_seq(project_seq);

            ProjectVO rst = projectMntService.selectUsrSkillList(temp);
            for (UserSkillVO skill : rst.getSkillList()) {
                skillNames.add(skill.getSkill_nm());
            }
            String skillList = String.join(", ", skillNames);

            projectExperience.put("client", pj.getProject_client()); //발주처
            projectExperience.put("projectName", pj.getProject_nm()); //사업명
            projectExperience.put("startDate", formatDate(pj.getProject_start_date())); //참여시작일
            projectExperience.put("endDate", formatDate(pj.getProject_end_date())); //참여종료일
            projectExperience.put("majorResponsibilities", pj.getAssigned_task_lar_nm()); //담당업무(대)
            projectExperience.put("minorResponsibilities", pj.getAssigned_task_mid_nm()); //담당업무(소)
            projectExperience.put("role", nullChange(pj.getProject_role_nm())); //역할
            projectExperience.put("skills", skillList); //기술

            projectExperienceList.add(projectExperience);
        }

        Map<String, Object> data = new HashMap<>();
        data.put("personalInfo", personalInfo);
        data.put("educationList", educationList);
        data.put("certificationList", certificationList);
        data.put("workExperienceList", workExperienceList);
        data.put("projectExperienceList", projectExperienceList);

        if (profile.getFileInfo() != null) {
            InputStream img = new FileInputStream(profile.getFileInfo().getFile_sver_path());
            byte[] imageBytes = toByteArray(img);
            img.close();
            data.put("profileImg", imageBytes);
        }

        // XLSTransformer를 이용한 변환
        XLSTransformer transformer = new XLSTransformer();
        try {
            if (fis == null) {
                throw new IOException("Template file not found: ");
            }

            // 변환된 워크북 생성
            Workbook workbook = transformer.transformXLS(fis, data);

            // 이미지 삽입
            Sheet sheet = workbook.getSheetAt(0);
            for (Row row : sheet) {
                for (Cell cell : row) {
                    if ("#IMG#".equals(cell.toString())) {
                        // #IMG# 텍스트가 있는 셀 찾기
                        int rowIndex = cell.getRowIndex();
                        int colIndex = cell.getColumnIndex();

                        // 이미지 바이트 배열 가져오기 (이미지 삽입)
                        byte[] imageBytes = (byte[]) data.get("profileImg");

                        if (profile.getFileInfo() != null) {
                            String extension = profile.getFileInfo().getFile_extension();
                            int type = 0;
                            if ("png".equals(extension)) {
                                type = Workbook.PICTURE_TYPE_PNG;
                            } else if ("jpg".equals(extension) || "jpeg".equals(extension)) {
                                type = Workbook.PICTURE_TYPE_JPEG;
                            }

                            if (type == 0) {
                                logger.error("[downloadUsrProfileDetailExcel] 잘못된 확장자 입니다. extension : {}", extension);
                                throw new CustomException("지원하지 않는 파일 확장자입니다.: " + extension);
                            }
                            // 이미지 삽입
                            int pictureIndex = workbook.addPicture(imageBytes, type);
                            CreationHelper helper = workbook.getCreationHelper();
                            Drawing drawing = sheet.createDrawingPatriarch();
                            ClientAnchor anchor = helper.createClientAnchor();

                            // 이미지 시작 위치 (a2 위치)
                            anchor.setCol1(colIndex); // 열 위치 (a열)
                            anchor.setRow1(rowIndex); // 행 위치 (2행)

                            // 이미지 끝 위치 (b8 위치)
                            anchor.setCol2(colIndex + 1); // 열 위치 (b열)
                            anchor.setRow2(rowIndex + 7); // 행 위치 (8행)

                            // 이미지 삽입
                            Picture picture = drawing.createPicture(anchor, pictureIndex);
                            picture.resize(1.0); // 이미지 크기 조정 (필요시)

                        }
                        // #IMG# 텍스트를 지워줍니다
                        cell.setCellValue("");
                    }
                }
            }

            int columnCount = sheet.getRow(0).getPhysicalNumberOfCells();
            logger.info("columnCount : {}", columnCount);
            for (int colIndex = 0; colIndex < columnCount; colIndex++) {
                try {
                    sheet.autoSizeColumn(colIndex);  // 각 열에 대해 자동 너비 조정
                } catch (Exception e) {
                    System.out.println("열 인덱스 " + colIndex + " 자동 크기 조정 실패: " + e.getMessage());
                }
            }


            // 텍스트가 잘리지 않게 열 너비를 더 넓게 설정 (특히 긴 텍스트가 있을 경우)
            for (int colIndex = 0; colIndex < sheet.getRow(0).getPhysicalNumberOfCells(); colIndex++) {
                sheet.setColumnWidth(colIndex, sheet.getColumnWidth(colIndex) * 2); // 열 너비를 두 배로 늘려서 긴 텍스트도 보이도록 설정
            }

            // HTTP 응답으로 파일 전송
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment");
            try (ServletOutputStream os = response.getOutputStream()) {
                workbook.write(os);
                workbook.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("엑셀 생성 중 오류가 발생했습니다.");
        } finally {
            if (fis != null){
                fis.close(); // InputStream 자원 해제
            }
        }
    }

    /**
     * 엑셀 템플릿 업로드
     *
     * @param excel
     * @return 엑셀파일
     * @throws IOException
     */
    @Override
    public void excelTemplateUpload(MultipartFile excel, String user_id) throws IOException {
        // 파일 유효성 검사
        if (excel.isEmpty()) {
            throw new IllegalArgumentException("Excel file is empty.");
        }

        // 파일 서버 저장
        FileVO fileVO = commonService.saveImageFile(excel);

        int file_seq = commonService.selectMaxHistSeq(user_id);

        // 파일 정보 DB 저장
        fileVO.setUser_id(user_id);
        fileVO.setFile_seq(file_seq);
        fileVO.setFile_se("EXCEL_TEMP");
        commonService.insertUsrFileInfo(fileVO);
    }

    public static byte[] toByteArray(InputStream inputStream) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        copy(inputStream, baos);
        return baos.toByteArray();
    }

    public static void copy(InputStream in, OutputStream out) throws IOException {
        byte[] buffer = new byte[8 * 1024];
        for (int count; (count = in.read(buffer)) != -1; ) {
            out.write(buffer, 0, count);
        }
    }

    private void applyCellStyle(Row rowName, int i, String data, CellStyle cellStyle) {
        Cell cell = rowName.createCell(i);
        cell.setCellValue(data);
        cell.setCellStyle(cellStyle);
    }

    private String formatDate(String strDate) {
        String rst = "";
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
            SimpleDateFormat newDateFormat = new SimpleDateFormat("yyyy-MM-dd");

            if (strDate != null || !strDate.isEmpty()) {
                Date formatDate = dateFormat.parse(strDate);
                rst = newDateFormat.format(formatDate);
            }

        } catch (ParseException e) {
            e.printStackTrace();
        }
        return rst;
    }

    private String formatPhone(String strPhone) {
        if (strPhone.length() == 8) {
            return strPhone.replaceAll("^([0-9]{4})([0-9]{4})$", "$1-$2");
        } else if (strPhone.length() == 12) {
            return strPhone.replaceAll("(^[0-9]{4})([0-9]{4})([0-9]{4})$", "$1-$2-$3");
        } else {
            return strPhone.replaceAll("(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})$", "$1-$2-$3");
        }
    }

    private String castType(Object data) {
        String replaceData = String.valueOf(data);
        if (replaceData == "null") {
            replaceData = "";
        }
        return replaceData;
    }

    private String gubunKor(String code) {
        String rtnValue = "";
        if ("010".equals(code)) {
            rtnValue = "고등학교";
        } else if ("011".equals(code)) {
            rtnValue = "대학교(2,3년)";
        } else if ("012".equals(code)) {
            rtnValue = "대학교(4년)";
        } else rtnValue = "대학원";
        return rtnValue;
    }

    private String statusKor(String code) {
        String rtnValue = "";
        if ("001".equals(code)) {
            rtnValue = "졸업";
        } else if ("002".equals(code)) {
            rtnValue = "졸업예정";
        } else rtnValue = "재학중";
        return rtnValue;
    }

    private String nullChange(String str) {
        if (str == null || str.isEmpty()) {
            str = "";
        }
        return str;
    }

    private String convertToString(int months) {
        if (months == 0) {
            return "";
        }
        double year = Math.floor(months / 12);
        double month = months % 12;

        int fmtYear = (int) year;
        int fmtMonth = (int) month;

        String result = "";
        if (year > 0) {
            result += fmtYear + "년 ";
        }
        if (months > 0) {
            result += fmtMonth + "개월";
        }
        return result;
    }

    private String getValue(Cell cell) {
        NumberFormat f = NumberFormat.getInstance();
        f.setGroupingUsed(false);
        String value = "";

        if (cell != null) {
            switch (cell.getCellTypeEnum()) { // 권장 메서드 사용
                case STRING:
                    value = cell.getStringCellValue();
                    break;
                case NUMERIC:
                    value = f.format(cell.getNumericCellValue());
                    break;
                case BLANK:
                    value = "";
                    break;
                case BOOLEAN:
                    value = String.valueOf(cell.getBooleanCellValue());
                    break;
                case ERROR:
                    value = String.valueOf(cell.getErrorCellValue());
                    break;
                default:
                    value = "";
            }
        }
        return value;
    }

    private String setGubunCode(String gubun) {
        if ("박사".equals(gubun) || "석사".equals(gubun)) { // 대학원
            return "013";
        } else if ("학사".equals(gubun)) { // 대학교 4년제
            return "012";
        } else if (gubun.startsWith("전문")) { // 대학교 2-3년제[전문학사, 전문학사(3년)]
            return "011";
        } else { // [고졸, 기능대졸, 직업훈련기관이수, 기능실기시험합격, 기타]
            return "010"; // 고등학교
        }
    }

    private String findTaskCode(String str, int level) {
        Map<String, Object> map = new HashMap<>();
        map.put("value", str);
        map.put("level", level);
        return commonDAO.getTaskCodeId(map);
    }

    private void chkMeta(InputStream fis, String fileNm) throws CustomException {
        try {
            // Apache POI 로 메타데이터 확인
            OPCPackage pkg = OPCPackage.open(fis);
            XSSFWorkbook workbook = new XSSFWorkbook(pkg);
            POIXMLProperties props = workbook.getProperties();

            String application = props.getExtendedProperties().getApplication();
            logger.info("File: {}", fileNm);
            logger.info("application: {}", application);

            if("Cell".equals(application)){ // 한셀파일
                throw new CustomException("Hansel 로 작성된 파일은 호환되지 않습니다.\nMS의 Excel, 혹은 구글 스프레드시트를 사용해주세요.");
            }
            workbook.close();
            pkg.close();

        } catch (CustomException e){
            logger.info("Hansel 프로그램");
            throw e;
        } catch (Exception e) {
            logger.error("General Error reading metadata for file: {}", fileNm, e);
            throw new CustomException("메타데이터를 읽는동안 문제가 발생했습니다.");
        }
    }
}
