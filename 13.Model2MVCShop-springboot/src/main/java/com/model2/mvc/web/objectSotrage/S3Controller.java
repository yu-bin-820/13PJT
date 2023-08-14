package com.model2.mvc.web.objectSotrage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/upload/*")
public class S3Controller {
    private S3Uploader s3Uploader;
    
    @Autowired
    public void setS3Uploader(S3Uploader s3Uploader) {
        this.s3Uploader = s3Uploader;
    }

    @PostMapping("/image")
    public String upload(@RequestParam("file") MultipartFile file, @RequestParam("dirName") String dirName) throws Exception {
        return s3Uploader.uploadFiles(file, dirName);
    }
}