package kr.co.itsmart.profileMnt.service;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.itsmart.profileMnt.vo.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class ExcelDownServiceImpl implements ExcelDownService {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private final ProjectMntService projectMntService;

    public ExcelDownServiceImpl(ProjectMntService projectMntService) {
        this.projectMntService = projectMntService;
    }

    @Override
    public void downloadUsrProfileDetailExcel(ProfileVO profile, HttpServletResponse response) throws IOException {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        try {
            XSSFWorkbook workbook = new XSSFWorkbook();

            // read image file
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
                logger.error("잘못된 확장자 입니다. extension : {}", extension);
                throw new IllegalArgumentException("지원하지 않는 파일 확장자입니다.: " + extension);
            }

            int pictureIdx = workbook.addPicture(bytes, type);
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

            // 학력사항이 비어있지 않다면
            if(!profile.getEdu1_school_name().isEmpty()){
                // 엑셀[학력]
                Row schoolInfo = sheet.createRow(rowCount++);
                applyCellStyle(schoolInfo, 0, "학력", titleStyle);
                sheet.addMergedRegion(new CellRangeAddress(rowCount -1, rowCount -1, 0, 8));

                // 엑셀[학력] header
                Row schoolHeader = sheet.createRow(rowCount++);
                applyCellStyle(schoolHeader, 0, "학교구분", headerStyle);
                applyCellStyle(schoolHeader, 1, "학교명", headerStyle);
                applyCellStyle(schoolHeader, 2, "입학년월", headerStyle);
                applyCellStyle(schoolHeader, 3, "졸업년월", headerStyle);
                applyCellStyle(schoolHeader, 4, "졸업상태", headerStyle);
                applyCellStyle(schoolHeader, 5, "전공명", headerStyle);
                applyCellStyle(schoolHeader, 6, "복수전공명", headerStyle);
                applyCellStyle(schoolHeader, 7, "학점", headerStyle);
                applyCellStyle(schoolHeader, 8, "총점", headerStyle);

                // 엑셀[학력] data
                Row schoolData = sheet.createRow(rowCount++);
                applyCellStyle(schoolData, 0, gubunKor(profile.getEdu1_gubun()), contentStyle);
                applyCellStyle(schoolData, 1, profile.getEdu1_school_name(), contentStyle);
                applyCellStyle(schoolData, 2, formatDate(profile.getEdu1_start_date()), contentStyle);
                applyCellStyle(schoolData, 3, formatDate(profile.getEdu1_end_date()), contentStyle);
                applyCellStyle(schoolData, 4, statusKor(profile.getEdu1_grad_status()), contentStyle);

                if(!profile.getEdu2_school_name().isEmpty()){
                    // 엑셀[학력] data
                    Row schoolData2 = sheet.createRow(rowCount++);
                    applyCellStyle(schoolData2, 0, gubunKor(profile.getEdu2_gubun()), contentStyle);
                    applyCellStyle(schoolData2, 1, profile.getEdu2_school_name(), contentStyle);
                    applyCellStyle(schoolData2, 2, formatDate(profile.getEdu2_start_date()), contentStyle);
                    applyCellStyle(schoolData2, 3, formatDate(profile.getEdu2_end_date()), contentStyle);
                    applyCellStyle(schoolData2, 4, statusKor(profile.getEdu2_grad_status()), contentStyle);
                }

                if(!profile.getEdu3_school_name().isEmpty()){
                    // 엑셀[학력] data
                    Row schoolData3 = sheet.createRow(rowCount++);
                    applyCellStyle(schoolData3, 0, gubunKor(profile.getEdu3_gubun()), contentStyle);
                    applyCellStyle(schoolData3, 1, profile.getEdu3_school_name(), contentStyle);
                    applyCellStyle(schoolData3, 2, formatDate(profile.getEdu3_start_date()), contentStyle);
                    applyCellStyle(schoolData3, 3, formatDate(profile.getEdu3_end_date()), contentStyle);
                    applyCellStyle(schoolData3, 4, statusKor(profile.getEdu3_grad_status()), contentStyle);
                }
                int lastRowIndex = rowCount -1; // 마지막 학력 데이터 행
                Row lastSchoolData = sheet.getRow(lastRowIndex);
                applyCellStyle(lastSchoolData, 5, profile.getMajor(), contentStyle);
                applyCellStyle(lastSchoolData, 6, profile.getDouble_major(), contentStyle);
                applyCellStyle(lastSchoolData, 7, castType(profile.getStandard_grade()), contentStyle);
                applyCellStyle(lastSchoolData, 8, castType(profile.getTotal_grade()), contentStyle);

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
                sheet.addMergedRegion(new CellRangeAddress(rowCount -1, rowCount -1, 0, 2));

                // 엑셀[근무경력] header
                Row workInfoHeader = sheet.createRow(rowCount++);
                applyCellStyle(workInfoHeader, 0, "회사명", headerStyle);
                applyCellStyle(workInfoHeader, 1, "입사일자", headerStyle);
                applyCellStyle(workInfoHeader, 2, "퇴사일자", headerStyle);

                for(WorkExperienceVO work : profile.getWorkExperienceList()){
                    // 엑셀[근무경력] data
                    Row workData = sheet.createRow(rowCount++);
                    applyCellStyle(workData, 0, work.getWork_place(), contentStyle);
                    applyCellStyle(workData, 1, formatDate(work.getWork_start_date()), contentStyle);
                    applyCellStyle(workData, 2, formatDate(work.getWork_end_date()), contentStyle);
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
        }

        byte[] outArray = outputStream.toByteArray();
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment");

        ServletOutputStream out = response.getOutputStream();
        out.write(outArray);
        out.flush();
        out.close();
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
}
