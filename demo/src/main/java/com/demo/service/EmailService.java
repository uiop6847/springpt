package com.demo.service;

import com.demo.dto.EmailDTO;

public interface EmailService {

	public void sendMail(EmailDTO dto, String authcode);
}
