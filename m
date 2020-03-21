Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9998C18E52E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 23:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgCUW0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 18:26:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38239 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgCUW0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 18:26:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id z25so1037345pfa.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ywrv/YxqmMIS6BbmjMP+A5ZaWbyGuTGBex2n9c9Zhpo=;
        b=Q/gqYFf3q1Q4c4SAAakxM39b/dJ1ZQeT2PdRHX61uOkvXmYEfy0V0XbtJ5enT/mVUr
         mJLA/cAp2VR6cyo0jHgzv4iMGgjMHB2EI78f94C2tYMB54Y96bu1OM/ROxcy0NtcNVJy
         +pwTWt7MKFbQAOBegPYhA9pbvRPZb9ERn10EyJBksXlBEzLWclme4MnWYCN6Q4qDo9Y0
         4izSpJnihHZeqbCDwBFjpCzYqjEx1CduMELQ05cvwQvCGtfR7VkWdfBCEgHFO1dmTZJk
         N1ow+1fQgOLv9b2gPzAtEh2sAWgHfr130YbZcMmFAnClc4yNxo1ItgoVyQzR2RNbzmEg
         CPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ywrv/YxqmMIS6BbmjMP+A5ZaWbyGuTGBex2n9c9Zhpo=;
        b=p2lZPXN/Ntzv1Sa8sHhoDAqU20KerWuTO3/Ay6/ZHK6KQgM5/v+Z6NKHjofipEmO5L
         6cgHh2ksSEgo7kG0hh7MTcg3g5YEPsCxVKkXrTBmUO3UPDCWobM43xgDnw7VspFS42CB
         8kgou0zKglo/+uRWE6a44wG/8ABlMsSCJm2xpHxGxaZXR2C6rIPzsJenxnLcw5A2tC1e
         5KPiStfIAKCdL+wtJGAkhsSrMkFA/huioC77WL8vwSIEl5iY9zsdBIB7J6J2hL2UzFvS
         m1M990N9HndjvIAPoyiBfsAtxrDiXTqZknfd23uRfxIV/d3/t2rQPzJd9YvVuoqXgY3a
         M6uA==
X-Gm-Message-State: ANhLgQ1YRa/S08ZXN16M8g1VMQhyWok6z+EAqCPapssSPTMr5SdOLbN3
        9CNHEUJX2TrN4fpwPFy1rrg=
X-Google-Smtp-Source: ADFU+vswz5jM9difNOg3zGZEZG+CtRvkVy8VYS5qTy5LUdIcRFvGI3GzpOW8UHe4Z581aFOjr4aXnQ==
X-Received: by 2002:a63:ec4d:: with SMTP id r13mr15436063pgj.232.1584829608726;
        Sat, 21 Mar 2020 15:26:48 -0700 (PDT)
Received: from localhost.localdomain ([113.193.33.115])
        by smtp.gmail.com with ESMTPSA id 184sm8312634pgb.52.2020.03.21.15.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 15:26:48 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [Outreachy kernel] [PATCH 07/11] Staging: rtl8188eu: rf_cfg: Add space around operators
Date:   Sun, 22 Mar 2020 03:56:42 +0530
Message-Id: <c1a6f5a1c5fb3a176ee77cc01446976b180bd999.1584826154.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1584826154.git.shreeya.patel23498@gmail.com>
References: <cover.1584826154.git.shreeya.patel23498@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add space around operators for improving the code
readability.
Reported by checkpatch.pl

git diff -w shows no difference.
diff of the .o files before and after the changes shows no difference.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

shreeya@Shreeya-Patel:~git/kernels/staging$ git diff -w drivers/staging/rtl8188eu/hal/rf_cfg.c
shreeya@Shreeya-Patel:~git/kernels/staging$

shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$ diff rf_cfg_old.o rf_cfg.o
shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$

 drivers/staging/rtl8188eu/hal/rf_cfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rf_cfg.c b/drivers/staging/rtl8188eu/hal/rf_cfg.c
index 004e19301eae..0b20e62f9a68 100644
--- a/drivers/staging/rtl8188eu/hal/rf_cfg.c
+++ b/drivers/staging/rtl8188eu/hal/rf_cfg.c
@@ -143,7 +143,7 @@ static u32 Array_RadioA_1T_8188E[] = {
 #define READ_NEXT_PAIR(v1, v2, i)	\
 do {								\
 	i += 2; v1 = array[i];			\
-	v2 = array[i+1];				\
+	v2 = array[i + 1];				\
 } while (0)
 
 #define RFREG_OFFSET_MASK 0xfffff
@@ -190,7 +190,7 @@ static bool rtl88e_phy_config_rf_with_headerfile(struct adapter *adapt)
 
 	for (i = 0; i < array_len; i += 2) {
 		u32 v1 = array[i];
-		u32 v2 = array[i+1];
+		u32 v2 = array[i + 1];
 
 		if (v1 < 0xCDCDCDCD) {
 			rtl8188e_config_rf_reg(adapt, v1, v2);
-- 
2.17.1

