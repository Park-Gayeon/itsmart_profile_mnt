package kr.co.itsmart.profileMnt.service;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.itsmart.profileMnt.configuration.handler.CustomException;
import kr.co.itsmart.profileMnt.dao.*;
import kr.co.itsmart.profileMnt.vo.*;
import net.sf.jxls.transformer.XLSTransformer;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class ExcelDownServiceImpl implements ExcelDownService {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private final ProjectMntService projectMntService;
    private final WorkExperienceDAO workExperienceDAO;
    private final ProjectDAO projectDAO;
    private final ProfileDAO profileDAO;
    private final QualificationDAO qualificationDAO;
    private final CommonDAO commonDAO;

    public ExcelDownServiceImpl(ProjectMntService projectMntService,
                                @Lazy WorkExperienceDAO workExperienceDAO,
                                @Lazy ProjectDAO projectDAO,
                                ProfileDAO profileDAO,
                                @Lazy QualificationDAO qualificationDAO,
                                @Lazy CommonDAO commonDAO) {
        this.projectMntService = projectMntService;
        this.projectDAO = projectDAO;
        this.workExperienceDAO = workExperienceDAO;
        this.profileDAO = profileDAO;
        this.qualificationDAO = qualificationDAO;
        this.commonDAO = commonDAO;
    }

    @Override
    public void downloadUsrProfileDetailExcel(ProfileVO profile, HttpServletResponse response) throws IOException {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        try {
            XSSFWorkbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("profile");

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

            // 엑셀[인적사항]
            Row profileInfo = sheet.createRow(rowCount++);
            applyCellStyle(profileInfo, 0, "인적사항", titleStyle);
            sheet.addMergedRegion(new CellRangeAddress(rowCount -1, rowCount -1, 0, 7)); //셀병합

            // read image file
            if(profile.getFileInfo() != null){
                FileInputStream fis = new FileInputStream(profile.getFileInfo().getFile_sver_path());
                byte[] bytes = fis.readAllBytes();
                fis.close();

                String extension = profile.getFileInfo().getFile_extension();
                int type = 0;
                if("png".equals(extension)){
                    type = Workbook.PICTURE_TYPE_PNG;
                }else if("jpg".equals(extension) || "jpeg".equals(extension)){
                    type = Workbook.PICTURE_TYPE_JPEG;
                }

                if(type == 0){
                    logger.error("[downloadUsrProfileDetailExcel] 잘못된 확장자 입니다. extension : {}", extension);
                    throw new CustomException("지원하지 않는 파일 확장자입니다.: " + extension);
                }

                int pictureIdx = workbook.addPicture(bytes, type);

                CreationHelper helper = workbook.getCreationHelper();
                Drawing drawing = sheet.createDrawingPatriarch();

                // add a picture shape
                ClientAnchor anchor = helper.createClientAnchor();
                anchor.setCol1(0);
                anchor.setCol2(1);
                anchor.setRow1(1);
                anchor.setRow2(10);
                Picture pict = drawing.createPicture(anchor, pictureIdx);

                pict.resize(1.0, 1.1);

                for(int i=0; i<anchor.getRow2(); i++){
                    sheet.createRow(rowCount++);
                }
            }

            // 엑셀[인적사항] header
            Row profileInfoHeader = sheet.createRow(rowCount++);
            applyCellStyle(profileInfoHeader, 0, "이름", headerStyle);
            applyCellStyle(profileInfoHeader, 1, "생년월일", headerStyle);
            applyCellStyle(profileInfoHeader, 2, "휴대전화", headerStyle);
            applyCellStyle(profileInfoHeader, 3, "이메일", headerStyle);
            applyCellStyle(profileInfoHeader, 4, "소속", headerStyle);
            applyCellStyle(profileInfoHeader, 5, "직위/직급", headerStyle);
            applyCellStyle(profileInfoHeader, 6, "입사일자", headerStyle);
            applyCellStyle(profileInfoHeader, 7, "주소", headerStyle);

            // 엑셀[인적사항] data
            Row profileData = sheet.createRow(rowCount++);
            applyCellStyle(profileData, 0, profile.getUser_nm(), contentStyle);
            applyCellStyle(profileData, 1, formatDate(profile.getUser_birth()), contentStyle);
            applyCellStyle(profileData, 2, formatPhone(profile.getUser_phone()), contentStyle);
            applyCellStyle(profileData, 3, profile.getUser_id() + "@itsmart.co.kr", contentStyle);
            applyCellStyle(profileData, 4, profile.getUser_department_nm(), contentStyle);
            applyCellStyle(profileData, 5, profile.getUser_position_nm(), contentStyle);
            applyCellStyle(profileData, 6, formatDate(profile.getHire_date()), contentStyle);
            applyCellStyle(profileData, 7, profile.getUser_address(), contentStyle);

            sheet.createRow(rowCount++); // 여백

            // 학력 list 가 비어있지 않다면
            if(profile.getEducationList() != null){
                // 엑셀[학력]
                Row schoolInfo = sheet.createRow(rowCount++);
                applyCellStyle(schoolInfo, 0, "학력", titleStyle);
                sheet.addMergedRegion(new CellRangeAddress(rowCount -1, rowCount -1, 0, 6));

                // 엑셀[학력] header
                Row schoolHeader = sheet.createRow(rowCount++);
                applyCellStyle(schoolHeader, 0, "학교구분", headerStyle);
                applyCellStyle(schoolHeader, 1, "학교명", headerStyle);
                applyCellStyle(schoolHeader, 2, "전공명", headerStyle);
                applyCellStyle(schoolHeader, 3, "학점", headerStyle);
                applyCellStyle(schoolHeader, 4, "입학일자", headerStyle);
                applyCellStyle(schoolHeader, 5, "졸업일자", headerStyle);
                applyCellStyle(schoolHeader, 6, "졸업상태", headerStyle);

                for(EduVO edu : profile.getEducationList()){
                    // 엑셀[학력] data
                    Row schoolData = sheet.createRow(rowCount++);
                    applyCellStyle(schoolData, 0, gubunKor(edu.getSchool_gubun()), contentStyle);
                    applyCellStyle(schoolData, 1, edu.getSchool_nm(), contentStyle);
                    applyCellStyle(schoolData, 2, edu.getMajor(), contentStyle);
                    applyCellStyle(schoolData, 3, castType(edu.getTotal_grade()), contentStyle);
                    applyCellStyle(schoolData, 4, formatDate(edu.getSchool_start_date()), contentStyle);
                    applyCellStyle(schoolData, 5, formatDate(edu.getSchool_end_date()), contentStyle);
                    applyCellStyle(schoolData, 6, statusKor(edu.getGrad_status()), contentStyle);
                }
                sheet.createRow(rowCount++); // 여백
            }

            // 자격증 list 가 비어있지 않다면
            if(profile.getQualificationList() != null){
                // 엑셀[자격증]
                Row qualificationInfo = sheet.createRow(rowCount++);
                applyCellStyle(qualificationInfo, 0, "자격증", titleStyle);
                sheet.addMergedRegion(new CellRangeAddress(rowCount -1, rowCount -1, 0, 3));

                // 엑셀[자격증] header
                Row qualificationInfoHeader = sheet.createRow(rowCount++);
                applyCellStyle(qualificationInfoHeader, 0, "자격증명", headerStyle);
                applyCellStyle(qualificationInfoHeader, 1, "발행기관", headerStyle);
                applyCellStyle(qualificationInfoHeader, 2, "취득일자", headerStyle);
                applyCellStyle(qualificationInfoHeader, 3, "만기일자", headerStyle);

                for(QualificationVO ql : profile.getQualificationList()){
                    // 엑셀[자격증] data
                    Row qualificationData = sheet.createRow(rowCount++);
                    applyCellStyle(qualificationData, 0, ql.getQualification_nm(), contentStyle);
                    applyCellStyle(qualificationData, 1, ql.getIssuer(), contentStyle);
                    applyCellStyle(qualificationData, 2, formatDate(ql.getAcquisition_date()), contentStyle);
                    applyCellStyle(qualificationData, 3, formatDate(ql.getExpiry_date()), contentStyle);
                }
                sheet.createRow(rowCount++); // 여백
            }

            // 근무경력 list 가 비어있지 않다면
            if(profile.getWorkExperienceList() != null){
                // 엑셀[근무경력]
                Row workInfo = sheet.createRow(rowCount++);
                applyCellStyle(workInfo, 0, "근무경력", titleStyle);
                sheet.addMergedRegion(new CellRangeAddress(rowCount -1, rowCount -1, 0, 4));

                // 엑셀[근무경력] header
                Row workInfoHeader = sheet.createRow(rowCount++);
                applyCellStyle(workInfoHeader, 0, "회사명", headerStyle);
                applyCellStyle(workInfoHeader, 1, "직급", headerStyle);
                applyCellStyle(workInfoHeader, 2, "담당업무", headerStyle);
                applyCellStyle(workInfoHeader, 3, "입사일자", headerStyle);
                applyCellStyle(workInfoHeader, 4, "퇴사일자", headerStyle);

                for(WorkExperienceVO work : profile.getWorkExperienceList()){
                    // 엑셀[근무경력] data
                    Row workData = sheet.createRow(rowCount++);
                    applyCellStyle(workData, 0, work.getWork_place(), contentStyle);
                    applyCellStyle(workData, 1, work.getWork_position(), contentStyle);
                    applyCellStyle(workData, 2, work.getWork_assigned_task(), contentStyle);
                    applyCellStyle(workData, 3, formatDate(work.getWork_start_date()), contentStyle);
                    applyCellStyle(workData, 4, formatDate(work.getWork_end_date()), contentStyle);
                }
                sheet.createRow(rowCount++); // 여백
            }

            // 사업수행 경력 list 가 비어있지 않다면
            if(profile.getProjectList() != null){
                ProjectVO temp = new ProjectVO();

                // 엑셀[수행경력]
                Row projectInfo = sheet.createRow(rowCount++);
                applyCellStyle(projectInfo, 0, "수행경력", titleStyle);
                sheet.addMergedRegion(new CellRangeAddress(rowCount -1, rowCount -1, 0, 7));

                // 엑셀[수행경력] header
                Row projectInfoHeader = sheet.createRow(rowCount++);
                applyCellStyle(projectInfoHeader, 0, "발주처", headerStyle);
                applyCellStyle(projectInfoHeader, 1, "사업명", headerStyle);
                applyCellStyle(projectInfoHeader, 2, "참여시작일", headerStyle);
                applyCellStyle(projectInfoHeader, 3, "참여종료일", headerStyle);
                applyCellStyle(projectInfoHeader, 4, "담당업무(대)", headerStyle);
                applyCellStyle(projectInfoHeader, 5, "담당업무(소)", headerStyle);
                applyCellStyle(projectInfoHeader, 6, "역할", headerStyle);
                applyCellStyle(projectInfoHeader, 7, "기술", headerStyle);

                for(ProjectVO pj : profile.getProjectList()){
                    int project_seq = pj.getProject_seq();
                    temp.setUser_id(profile.getUser_id());
                    temp.setProject_seq(project_seq);

                    ProjectVO rst = projectMntService.selectUsrSkillList(temp);
                    List<String> skillNames = new ArrayList<>();
                    for(UserSkillVO skill : rst.getSkillList()){
                        skillNames.add(skill.getSkill_nm());
                    }
                    String skillList = String.join(", ", skillNames);

                    // 엑셀[수행경력] data
                    Row projectData = sheet.createRow(rowCount++);
                    applyCellStyle(projectData, 0, pj.getProject_client(), contentStyle);
                    applyCellStyle(projectData, 1, pj.getProject_nm(), contentStyle);
                    applyCellStyle(projectData, 2, formatDate(pj.getProject_start_date()), contentStyle);
                    applyCellStyle(projectData, 3, formatDate(pj.getProject_end_date()), contentStyle);
                    applyCellStyle(projectData, 4, pj.getAssigned_task_lar_nm(), contentStyle);
                    applyCellStyle(projectData, 5, pj.getAssigned_task_mid_nm(), contentStyle);
                    applyCellStyle(projectData, 6, pj.getProject_role_nm(), contentStyle);
                    applyCellStyle(projectData, 7, skillList, contentStyle);
                }
            }

            sheet.setDefaultColumnWidth((short)20);

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
    public void downloadUsrProfileAllListExcel(List<ProfileVO> list, HttpServletResponse response) throws IOException {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        try {
            XSSFWorkbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("user_list");

            if(list == null){
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
            applyCellStyle(listHeader, 3, "발주처", headerStyle);
            applyCellStyle(listHeader, 4, "사업명", headerStyle);
            applyCellStyle(listHeader, 5, "사업시작일", headerStyle);
            applyCellStyle(listHeader, 6, "사업종료일", headerStyle);
            applyCellStyle(listHeader, 7, "수행경력", headerStyle);
            applyCellStyle(listHeader, 8, "자격증여부", headerStyle);

            int num = 1;
            for(ProfileVO profile : list){
                // 엑셀[자격증] data
                Row listData = sheet.createRow(rowCount++);
                Cell cell = listData.createCell(0);
                cell.setCellValue(num);
                cell.setCellStyle(contentStyle);
                applyCellStyle(listData, 1, profile.getUser_nm(), contentStyle);
                applyCellStyle(listData, 2, profile.getUser_department_nm(), contentStyle);
                applyCellStyle(listData, 3, nullChange(profile.getProject_client()), contentStyle);
                applyCellStyle(listData, 4, nullChange(profile.getProject_nm()), contentStyle);
                applyCellStyle(listData, 5, nullChange(profile.getProject_start_date()) == ""? "": formatDate(profile.getProject_start_date()), contentStyle);
                applyCellStyle(listData, 6, nullChange(profile.getProject_end_date()) == "" ? "" : formatDate(profile.getProject_end_date()), contentStyle);
                applyCellStyle(listData, 7, convertToString(profile.getProject_totalMonth()), contentStyle);
                applyCellStyle(listData, 8, "1".equals(profile.getQualification_yn()) ? "Y":"N", contentStyle);

                num++;
            }
            sheet.createRow(rowCount++); // 여백

            sheet.setDefaultColumnWidth((short)20);

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
        if(excel.isEmpty()){
            logger.error("[uploadKosaExcel] 파일이 존재하지 않습니다.");
            throw new CustomException("파일이 존재하지 않습니다.");
        }

        try (InputStream inputStream = excel.getInputStream()) {
            Workbook workbook = null;
			try {
				workbook = WorkbookFactory.create(inputStream);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            Sheet sheet = workbook.getSheetAt(0);

            int rows = sheet.getPhysicalNumberOfRows();
            logger.info("행 개수 : " + rows);
            boolean deleteYn = false; // 테이블 삭제여부
            boolean createYn = false; // 프로필 이력 생성여부
            int rangeCnt = 0; // kosa 파일의 분류별 range (근무경력, 기술경력, 학력, 기술자격, 교육, 상훈)
            int seq = 0; // 테이블별 seq
            ArrayList<Integer> idxArray = new ArrayList<>();

            WorkExperienceVO work = new WorkExperienceVO(); // 근무경력
            ProjectVO project = new ProjectVO(); // 기술경력
            ProfileVO profile = new ProfileVO(); // 프로필
            EduVO edu = new EduVO(); // 학력
            QualificationVO qualification = new QualificationVO(); // 기술자격
            UserSkillVO skill = new UserSkillVO(); // 기술

            int work_hist_seq = workExperienceDAO.selectMaxHistSeq(user_id);
            int project_hist_seq = projectDAO.selectMaxHistSeq(user_id);
            int profile_hist_seq = profileDAO.selectMaxHistSeq(user_id);
            int qualification_hist_seq = qualificationDAO.selectMaxHistSeq(user_id);

            for(int r= 0; r < rows; r++){ // 행 갯수만큼 for 문을 돌린다.
                Row row = sheet.getRow(r); // 행을 하나 가지고 와서
                int cells = row.getPhysicalNumberOfCells(); // 해당 행의 cell들을 가지고 온다
                int cnt = 0;

                logger.info("|      "+(r+1)+"     |"); // n번째 행 확인

                if(!idxArray.isEmpty()){
                    for(int c =0; c < idxArray.size(); c++){
                        Cell cell = row.getCell(idxArray.get(c)); // n번째 행의 n번째 cell을 가지고 와서
                        String value = getValue(cell); // cell 에 담긴 데이터를 가지고 옴

                        if(value.isEmpty()){ // 만약 데이터가 비어있는 항목이라면
                            cnt++; // 빈 row 를 찾기 위해서 cnt++ 해줌
                            logger.info("|      "+value+"     |");
                            if(cnt == idxArray.size()){ // 만약 한 row 가 전부 false 를 가지고 있다면
                                logger.info("지금은 empty row 입니다");
                                rangeCnt++; // 다음 form 설정
                                idxArray.clear(); // indxArray 비움
                                deleteYn = false; // 테이블 기본 설정
                                break; // for문 빠져나감
                            }
                        } else {
                            logger.info("|      "+value+"     |");
                        }
                    }

                    if(idxArray.isEmpty()){ // 한 row가 전부 false 라서 배열을 초기화 해주었으면
                        seq = 0; // 테이블에 적용할 seq는 0으로 초기화해준다
                        logger.info("직전에 idxArray 비워줬고 seq 도 0으로 초기화함. > 다음 form을 읽을 예정");
                        continue;
                    }

                    if(rangeCnt == 0){
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

                        if(!deleteYn){
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

                    } else if(rangeCnt == 1){ // 기술경력
                        boolean chk = true;
                        logger.info("rangeCnt : " + rangeCnt + " >> 기술경력에 대한 DB 처리");
                        seq++;
                        project.setProject_seq(seq); // 1 부터
                        project.setHist_seq(project_hist_seq);
                        project.setUser_id(user_id);
                        project.setProject_nm(getValue(row.getCell(idxArray.get(0)))); // 참여사업명
                        String[] dateArr = getValue(row.getCell(idxArray.get(1))).split("~");
                        String start_date = dateArr[0].trim().replace(".", "");
                        String end_date = dateArr[1].trim().replace(".", "");
                        project.setProject_start_date(start_date); // 사업시작일
                        project.setProject_end_date(end_date); // 사업종료일
                        String[] taskArr = getValue(row.getCell(idxArray.get(2))).split(">");
                        String task_lar = taskArr[0].replace(" ","");
                        String task_mid = taskArr[1].replace(" ","");
                        String task_code_lar = findTaskCode(task_lar, 1); // 업무구분코드 대분류
                        String task_code_mid = findTaskCode(task_mid, 2); // 업무구분코드 중분류

                        project.setAssigned_task_lar(task_code_lar);
                        project.setAssigned_task_mid(task_code_mid);
                        String skillStr = getValue(row.getCell(idxArray.get(3)));
                        project.setProject_client(getValue(row.getCell(idxArray.get(4)))); // 발주처

                        logger.info(String.valueOf(project.getProject_seq()));
                        logger.info("프로젝트명 : " + project.getProject_nm());
                        logger.info("시작일자 : " + project.getProject_start_date());
                        logger.info("종료일자 : " + project.getProject_end_date());
                        logger.info("직무영역, 기술 : " + getValue(row.getCell(idxArray.get(3))));
                        logger.info("발주처 : " + project.getProject_client());

                        if(!deleteYn){
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

                        if(skillStr.isEmpty()){
                            logger.info("작성된 기술이 없습니다");
                            chk = false;
                        }
                        if(chk){ // 작성된 기술이 있다면
                            // SKILL UPDATE(INSERT)
                            int skill_hist_seq = projectDAO.selectSkMaxSeq(project);
                            skill.setUser_id(user_id);
                            skill.setHist_seq(skill_hist_seq);
                            skill.setProject_seq(seq);

                            logger.info("배열에 기술을 담습니다");
                            String[] skillArr = skillStr.split(",");

                            for(int i = 0; i < skillArr.length; i++){
                                int skillId = i+1;
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
                    } else if(rangeCnt == 2){ // 학력
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
                        String startDate = getValue(row.getCell(idxArray.get(3))).replace(".","");
                        String endDate = getValue(row.getCell(idxArray.get(4))).replace(".","");
                        edu.setSchool_start_date(startDate); // 입학년월일
                        edu.setSchool_end_date(endDate); // 졸업년월일

                        logger.info(String.valueOf(edu.getSchool_seq()));
                        logger.info(String.valueOf(edu.getHist_seq()));
                        logger.info("학교구분" + edu.getSchool_gubun());
                        logger.info("학교명" + edu.getSchool_nm());
                        logger.info("입학일자" + edu.getSchool_start_date());
                        logger.info("졸업일자" + edu.getSchool_end_date());
                        logger.info("전공" + edu.getMajor());
                        logger.info("상태" + edu.getGrad_status());

                        if(!deleteYn){
                            // DELETE TB
                            logger.info("사용자 학력 정보를 삭제합니다: user_id={}", user_id);
                            profileDAO.deleteUsrEducationInfo(user_id);
                            deleteYn = true;
                        }

                        // UPDATE(=INSERT)
                        logger.info("사용자 학력 정보를 입력합니다: user_id={}, school_nm", user_id, edu.getSchool_nm());
                        profileDAO.updateUsrEducationInfo(edu);

                        // CREATE HIST
                        if(!createYn){
                            logger.info("사용자 프로필이력 정보를 입력합니다: user_id={}", user_id);
                            profileDAO.insertUsrProfileInfoHist(profile);
                            createYn = true;
                        }
                        profileDAO.insertUsrEducationInfoHist(edu);
                        logger.info("사용자 학력 정보 이력을 생성했습니다: user_id={}", user_id);
                    } else if(rangeCnt == 3){ // 기술자격
                        seq++;
                        qualification.setQualification_seq(seq);
                        qualification.setHist_seq(qualification_hist_seq);
                        qualification.setUser_id(user_id);
                        qualification.setQualification_nm(getValue(row.getCell(idxArray.get(0)))); // 자격명
                        String startDate = getValue(row.getCell(idxArray.get(1))).replace(".","");
                        qualification.setAcquisition_date(startDate);
                        qualification.setIssuer(getValue(row.getCell(idxArray.get(2)))); // 발급기관

                        logger.info(String.valueOf(qualification.getQualification_seq()));
                        logger.info(String.valueOf(qualification.getHist_seq()));
                        logger.info("자격명" + qualification.getQualification_nm());
                        logger.info("합격일자" + qualification.getAcquisition_date());
                        logger.info("발급기관" + qualification.getIssuer());

                        if(!deleteYn){
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
                } else { // idxArray가 null 이라면 == 처음에 컬럼명을 읽으면서 idxArray 배열에 추가해줄 것이기 때문에
                    for(int c =0; c < cells; c++){
                        logger.info("idxArray가 null");
                        Cell cell = row.getCell(c); // n번째 행의 n번째 cell을 가지고 와서
                        String value = getValue(cell); // cell 에 담긴 데이터를 가지고 옴

                        if(rangeCnt == 0){ // 근무 경력
                            logger.info("rangeCnt == " + rangeCnt+ " >> 근무경력에 대한 indxArray 설정 중");
                            if("회사명".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            }else if("직위".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            }else if("근무기간".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            }else if("담당업무".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            }
                        } else if(rangeCnt == 1){ // 기술 경력
                            logger.info("rangeCnt == " + rangeCnt+ " >> 기술경력에 대한 indxArray 설정 중");
                            if("참여사업명".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            } else if("수행기간".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            } else if("수행업무".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            } else if(value.startsWith("직무")){
                                idxArray.add(cell.getColumnIndex());
                            } else if("발주처".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            }
                        } else if(rangeCnt == 2) { // 학력
                            logger.info("rangeCnt == " + rangeCnt+ " >> 학력에 대한 indxArray 설정 중");
                            if("학교명".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            }else if("학과(전공)".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            }else if("학위".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            }else if("입학년월일".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            }else if("졸업년월일".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            }
                        } else if(rangeCnt == 3){ // 기술자격
                            logger.info("rangeCnt == " + rangeCnt+ " >> 기술자격에 대한 indxArray 설정 중");
                            if("자격명".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            } else if("합격일자".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            } else if("발급기관".equals(value)){
                                idxArray.add(cell.getColumnIndex());
                            }
                        }
                        logger.info("|      "+value+"     |");
                    }
                }
            }


        } catch (IOException e) {
            throw new CustomException("엑셀 업로드 중 오류 확인 : " + e.getMessage());
        } catch (EncryptedDocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

    }
    
    /* 규현 작성중 */
    /* 템플릿 파일 다운로드 */
    @Override
    public void downloadExcelTemplate(HttpServletRequest request, HttpServletResponse response) {
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
    }
    
    /* 템플릿 형식으로 다운*/
    @Override
    public void downloadUsrProfileDetailExcelTemplate(ProfileVO profile, HttpServletRequest request,
            HttpServletResponse response) throws IOException {
        String templatePath = "template/template.xlsx"; // 템플릿 경로
        String outputFileName = "test_template.xlsx"; // 출력 파일명
        
        Map<String, Object> 		personalInfo 			= new HashMap<>();		//인적사항
        List<Map<String, Object>> 	educationList 			= new ArrayList<>();	//학력
        List<Map<String, Object>> 	certificationList 		= new ArrayList<>();	//자격증
        List<Map<String, Object>> 	workExperienceList 		= new ArrayList<>();	//근무경력
        List<Map<String, Object>> 	projectExperienceList 	= new ArrayList<>();	//수행경력

        // [인적사항] (단일 데이터)
        personalInfo.put("name"			, profile.getUser_nm()						);
        personalInfo.put("birthdate"	, formatDate(profile.getUser_birth())		);
        personalInfo.put("phone"		, formatPhone(profile.getUser_phone())		);
        personalInfo.put("email"		, profile.getUser_id() + "@itsmart.co.kr"	);
        personalInfo.put("affiliation"	, profile.getUser_department_nm()			);
        personalInfo.put("position"		, profile.getUser_position_nm()				);
        personalInfo.put("hireDate"		, formatDate(profile.getHire_date())		);
        personalInfo.put("address"		, profile.getUser_address()					);

        //학력
        for (EduVO edu : profile.getEducationList()) {
            Map<String, Object> educationInfo = new HashMap<>();
            educationInfo.put("schoolType"			, gubunKor(edu.getSchool_gubun())		);	//학교구분
            educationInfo.put("schoolName"			, edu.getSchool_nm()					);	//학교명
            educationInfo.put("major"				, edu.getMajor()						);	//전공명
            educationInfo.put("gpa"					, castType(edu.getTotal_grade())		);	//학점
            educationInfo.put("entranceDate"		, formatDate(edu.getSchool_start_date()));	//입학일자
            educationInfo.put("graduationDate"		, formatDate(edu.getSchool_end_date())	);	//졸업일자
            educationInfo.put("graduationStatus"	, statusKor(edu.getGrad_status())		);	//졸업상태
            
            educationList.add(educationInfo);
        }
        
        //자격증
        for(QualificationVO ql : profile.getQualificationList()){
            Map<String, Object> certificationInfo = new HashMap<>();
            certificationInfo.put("certificateName"			, ql.getQualification_nm()				);	//자격증명
            certificationInfo.put("issuingOrganization"		, ql.getIssuer()						);	//발행기관
            certificationInfo.put("acquisitionDate"			, formatDate(ql.getAcquisition_date())	);	//취득일자
            certificationInfo.put("expirationDate"			, formatDate(ql.getExpiry_date())		);	//만기일자
            
            certificationList.add(certificationInfo);
        }
        
        // [근무경력]
        for(WorkExperienceVO work : profile.getWorkExperienceList()){
            Map<String, Object> workExperience = new HashMap<>();
            workExperience.put("companyName"			, work.getWork_place()					);	//회사명
            workExperience.put("position"				, work.getWork_position()				);	//직급
            workExperience.put("jobDescription"			, work.getWork_assigned_task()			);	//담당업무
            workExperience.put("hireDate"				, formatDate(work.getWork_start_date())	);	//입사일자
            workExperience.put("resignationDate"		, formatDate(work.getWork_end_date())	);	//퇴사일자
            
            workExperienceList.add(workExperience);
        }
        
        // [수행경력]
        for(ProjectVO pj : profile.getProjectList()){
            Map<String, Object> projectExperience = new HashMap<>();
            List<String> skillNames = new ArrayList<>();
            
            int project_seq = pj.getProject_seq();
            ProjectVO temp = new ProjectVO();
            temp.setUser_id(profile.getUser_id());
            temp.setProject_seq(project_seq);
            
            ProjectVO rst = projectMntService.selectUsrSkillList(temp);
            for(UserSkillVO skill : rst.getSkillList()){
                skillNames.add(skill.getSkill_nm());
            }
            String skillList = String.join(", ", skillNames);
            
            projectExperience.put("client"					, pj.getProject_client()				);	//발주처
            projectExperience.put("projectName"				, pj.getProject_nm()					);	//사업명
            projectExperience.put("startDate"				, formatDate(pj.getProject_start_date()));	//참여시작일
            projectExperience.put("endDate"					, formatDate(pj.getProject_end_date())	);	//참여종료일
            projectExperience.put("majorResponsibilities"	, pj.getAssigned_task_lar_nm()			);	//담당업무(대)
            projectExperience.put("minorResponsibilities"	, pj.getAssigned_task_mid_nm()			);	//담당업무(소)
            projectExperience.put("role"					, pj.getProject_role_nm()				);	//역할
            projectExperience.put("skills"					, skillList								);	//기술
            projectExperienceList.add(projectExperience);
        }
        

        Map<String, Object> data = new HashMap<>();
        data.put("personalInfo"			, personalInfo);
        data.put("educationList"		, educationList);
        data.put("certificationList"	, certificationList);
        data.put("workExperienceList"	, workExperienceList);
        data.put("projectExperienceList", projectExperienceList);
        
        if(profile.getFileInfo() != null){
        	
        	InputStream img = new FileInputStream(profile.getFileInfo().getFile_sver_path());
        	byte[] imageBytes = toByteArray(img);
            img.close();
        	
        	data.put("profileImg", imageBytes);

        }

        // XLSTransformer를 이용한 변환
        XLSTransformer transformer = new XLSTransformer();
        try (InputStream fis = getClass().getClassLoader().getResourceAsStream(templatePath)) {
            if (fis == null) {
                throw new IOException("Template file not found: " + templatePath);
            }

            // 변환된 워크북 생성
            Workbook workbook = transformer.transformXLS(fis, data);
            
            // 이미지 삽입
            Sheet sheet = workbook.getSheetAt(0); // 첫 번째 시트 가져오기
            for (Row row : sheet) {
                for (Cell cell : row) {
                	if ("#IMG#".equals(cell.toString())) {
                        // #IMG# 텍스트가 있는 셀 찾기
                        int rowIndex = cell.getRowIndex();
                        int colIndex = cell.getColumnIndex();
                        
                        // 이미지 바이트 배열 가져오기 (이미지 삽입)
                        byte[] imageBytes = (byte[]) data.get("profileImg");
                        
                        String extension = profile.getFileInfo().getFile_extension();
                        int type = 0;
                        if("png".equals(extension)){
                            type = Workbook.PICTURE_TYPE_PNG;
                        }else if("jpg".equals(extension) || "jpeg".equals(extension)){
                            type = Workbook.PICTURE_TYPE_JPEG;
                        }

                        if(type == 0){
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
                        
                        // #IMG# 텍스트를 지워줍니다
                        cell.setCellValue(""); 
                    }
                }
            }
            
            // 데이터가 들어가는 부분에서 각 열의 너비를 자동으로 조정
            for (int colIndex = 0; colIndex < sheet.getRow(0).getPhysicalNumberOfCells(); colIndex++) {
                sheet.autoSizeColumn(colIndex);  // 각 열에 대해 자동 너비 조정
            }
            
            // 텍스트가 잘리지 않게 열 너비를 더 넓게 설정 (특히 긴 텍스트가 있을 경우)
            for (int colIndex = 0; colIndex < sheet.getRow(0).getPhysicalNumberOfCells(); colIndex++) {
                sheet.setColumnWidth(colIndex, sheet.getColumnWidth(colIndex) * 2); // 열 너비를 두 배로 늘려서 긴 텍스트도 보이도록 설정
            }
            
            // HTTP 응답으로 파일 전송
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + outputFileName + "\"");
            try (ServletOutputStream os = response.getOutputStream()) {
                workbook.write(os);
                workbook.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("엑셀 생성 중 오류가 발생했습니다.");
        }
    }
    
    public static byte[] toByteArray(InputStream inputStream) throws IOException { // used by templates and SimpleExporter
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        copy(inputStream, baos);
        return baos.toByteArray();
    }
    
    public static void copy(InputStream in, OutputStream out) throws IOException {
        byte[] buffer = new byte[8 * 1024];
        for (int count; (count = in.read(buffer)) != -1;) {
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
            SimpleDateFormat dateFormat= new SimpleDateFormat("yyyyMMdd");
            SimpleDateFormat newDateFormat = new SimpleDateFormat("yyyy-MM-dd");

            if(strDate != null || !strDate.isEmpty()){
                Date formatDate = dateFormat.parse(strDate);
                rst = newDateFormat.format(formatDate);
            }

        } catch (ParseException e){
            e.printStackTrace();
        }
        return rst;
    }

    private String formatPhone(String strPhone){
        if(strPhone.length() == 8){
            return strPhone.replaceAll("^([0-9]{4})([0-9]{4})$", "$1-$2");
        } else if(strPhone.length() == 12){
            return strPhone.replaceAll("(^[0-9]{4})([0-9]{4})([0-9]{4})$", "$1-$2-$3");
        } else {
            return strPhone.replaceAll("(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})$", "$1-$2-$3");
        }
    }

    private String castType(BigDecimal data){
        String replaceData = String.valueOf(data);
        if(replaceData == "null"){
            replaceData = "";
        }
        return replaceData;
    }

    private String gubunKor(String code){
        String rtnValue = "";
        if("010".equals(code)){ rtnValue = "고등학교"; }
        else if ("011".equals(code)){ rtnValue = "대학교(2,3년)";}
        else if ("012".equals(code)){ rtnValue = "대학교(4년)";}
        else rtnValue = "대학원";
        return rtnValue;
    }

    private String statusKor(String code){
        String rtnValue = "";
        if("001".equals(code)){ rtnValue = "졸업"; }
        else if ("002".equals(code)){ rtnValue = "졸업예정";}
        else rtnValue = "재학중";
        return rtnValue;
    }

    private String nullChange(String str){
        if(str == null || str.isEmpty()){
            str = "";
        }
        return str;
    }

    private String convertToString(int months) {
        if(months == 0){
            return "";
        }
        double year = Math.floor(months / 12);
        double month = months % 12;

        int fmtYear = (int)year;
        int fmtMonth = (int)month;

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

    private String setGubunCode(String gubun){
        if("박사".equals(gubun) || "석사".equals(gubun)){ // 대학원
            return "013";
        } else if("학사".equals(gubun)){ // 대학교 4년제
            return "012";
        } else if(gubun.startsWith("전문")){ // 대학교 2-3년제[전문학사, 전문학사(3년)]
            return "011";
        } else { // [고졸, 기능대졸, 직업훈련기관이수, 기능실기시험합격, 기타]
            return "010"; // 고등학교
        }
    }

    private String findTaskCode(String str, int level){
        Map<String, Object> map = new HashMap<>();
        map.put("value", str);
        map.put("level", level);
        return commonDAO.getTaskCodeId(map);
    }
}
