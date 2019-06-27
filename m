Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAA1588E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 19:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfF0Rm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 13:42:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38541 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfF0Rm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:42:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id 9so902875ple.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Kp4iDZgoItQSuXm+UYx3os3MRNcj7Hprz4VyxWNkTks=;
        b=dZsxusE9+/V+r1ZJwK0LgfWe5snVirwKO7sLCaI+btbDC58sFqi2fJzLJunylRln1V
         FTQwSyX7xFWpOdCy6BykN8AzNiGcjJJXvit1vNJaV4ozeX+VxP2Dr5vN0/DxdpfFPNXg
         7RmpXLWHzS5esi2a1xCHDIFe05LZ/rX+VksFM7JvkQwOqbwwN4QVU+oi8WuDMTZBVRbx
         z+Ok1HpJyOegsf/l+/AQZ2RFBKxLMzJOQO1Hg7m2yypfxYKlKCuTU9iMTdfL2K+/2yeK
         hY4nGvOoG5uHZwgb+IYwWRDVb7V1yjHIvVppPf+tYUNbYp29Y+y0I6WHnhthUCQOYvLq
         KQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kp4iDZgoItQSuXm+UYx3os3MRNcj7Hprz4VyxWNkTks=;
        b=X6RRWS9EjiEO3Rlph8T8+XsL2tbj4XnNzW2oQrwIxYyVogwkSwjW3ub9LfQeUrdmxn
         mmExHOCiUP4GJVygiyx+eDq1Z6SYth8g1WNJahdZPnPEG0a9Uq/RY5YpdlGcG+xL1ZdA
         aYD7GNS7BVKsSJRXZb2AbqlGOBwH/w2SZ8YYHKZ4xyaQ2OdZfhpjX+q89e+ORQoFLqDz
         2J5L6avzLWaFcS6We6PqjE3OWHjfIpPNsk78ZqYgSdHI4O9jkRL4t//MKQsx2zYJrh0k
         HmrBf5S0+5zX+E5gKgpMup2oyZoWu51uiDDE06jnLcekMO8aMdGckgwPXU7t669jUtp/
         WTGg==
X-Gm-Message-State: APjAAAWW9nq/6AGTwyKquC71uNhz3RV0JqqqSxZ48hTG8muj/W3z04vz
        lr0gjAVersB4x+dQEmAPlV0=
X-Google-Smtp-Source: APXvYqwTsq0jFBSQJqHgX90OSkCYA2IUp8QIZmtStEdGpluVmULNUikp8RDrNT98JfPvW5rznbZPWg==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr5931859plz.191.1561657348772;
        Thu, 27 Jun 2019 10:42:28 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id f64sm3557445pfa.115.2019.06.27.10.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:42:28 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 51/87] rtl8188eu: os_dep: replace rtw_malloc and memset with rtw_zmalloc
Date:   Fri, 28 Jun 2019 01:42:21 +0800
Message-Id: <20190627174223.4670-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_malloc + memset(0) -> rtw_zmalloc

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
index 9db11b16cb93..250acb01d1a9 100644
--- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
@@ -98,10 +98,9 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 	if (authmode == _WPA_IE_ID_) {
 		RT_TRACE(_module_mlme_osdep_c_, _drv_info_,
 			 ("rtw_report_sec_ie, authmode=%d\n", authmode));
-		buff = rtw_malloc(IW_CUSTOM_MAX);
+		buff = rtw_zmalloc(IW_CUSTOM_MAX);
 		if (!buff)
 			return;
-		memset(buff, 0, IW_CUSTOM_MAX);
 		p = buff;
 		p += sprintf(p, "ASSOCINFO(ReqIEs =");
 		len = sec_ie[1] + 2;
-- 
2.11.0

