Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D251039CA7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 12:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfFHK5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 06:57:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39947 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfFHK5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:57:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so2492347pgm.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPQkdox7T3QaNw+s/5ZqCu7JaG/o8yombi+YevOGoko=;
        b=e4GeUSNXiCgKonKBLKEfxp6Ce+fSGCc9Q/e2+szGTT20U4929yFPipr/a0uwpfU0JF
         PxxewLQlkHuE4vpS5eWQo7Yx1c2MPHg99PSTCxyDJKWbQl4GHfNf7qM0RlVDJARiLnsU
         EWI6dqNIy83XJZ763UuEgCP+7SjORJrlNl1DiU/xwhfSG8KNjJcTe9wbf6EG1CoDMgfu
         MjuZFZ86PgVm3cZTWweDacK1SCbn9Xdvig7UPPM4rGN2aFOWJrB+jx1zmtQDLta/9YxJ
         P910BrVYzCCw8Llw9QkLkhjgpEx8K3T9GxlX4l1tI2CSMavbA52Ke/kj7J2QeutgbASE
         63xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPQkdox7T3QaNw+s/5ZqCu7JaG/o8yombi+YevOGoko=;
        b=miBo7rwF3NX0vP1wvgkZnONuOktP84iCXEYZQwah+zkSIBFFaxD5wllnrGUDptbdr9
         AeMwSbk+6WmfWRxq5dku5h1zlmNvTV2imRayrsFfIG2QKBKBg87dVY/nRvpgeQsv4Gd0
         urbCcetn//n9AM/ChH8lPvyYjsY3LkCEk8ypcQSSLr680jTxNTRKdipco2qySAfWo/QS
         0xI+5tvG/YEQ1jvTNAlhHGiW82hBYALX3DunNEQW5FUiJuXtbH7jKHt8uyfU03gIDMwc
         Wdic3bPn9LLK5bC3gfJxiNXYGKiLPZUogEP18aC6F4PQ3HsAxvXW0dg8FiOhHZYZOQAL
         DEJw==
X-Gm-Message-State: APjAAAWFpx0eChHwDo4FNYjWaZRr93+Plq5j6u+RZ6LX4yGGoNSjrd6W
        +23xpC0ihvmSsLh6qNEXH/PZkOyc
X-Google-Smtp-Source: APXvYqzUipoVMsmP0MbDynlDSXOw7QK6a+JOZWNt76+G9j0FENirJNXsLVpwUVhzMr57eOB3mfdcEA==
X-Received: by 2002:a63:81c6:: with SMTP id t189mr6903782pgd.293.1559991461199;
        Sat, 08 Jun 2019 03:57:41 -0700 (PDT)
Received: from localhost.localdomain ([117.192.25.72])
        by smtp.googlemail.com with ESMTPSA id s24sm5021384pfh.133.2019.06.08.03.57.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 03:57:40 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH v4 4/6] staging: rtl8712: removed unused variables from struct _adapter
Date:   Sat,  8 Jun 2019 16:26:59 +0530
Message-Id: <118b2ec274c14521dffac3771cf26e1cc8af789b.1559990697.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559990697.git.linux.dkm@gmail.com>
References: <cover.1559990697.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removed following unused member variables from struct _adapter

IsrContent, xmitThread, evtThread, recvThread

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 0c722e9c2410..c36a5ef3ee5d 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -148,13 +148,9 @@ struct _adapter {
 	bool	driver_stopped;
 	bool	surprise_removed;
 	bool	suspended;
-	u32	IsrContent;
 	u8	eeprom_address_size;
 	u8	hw_init_completed;
 	struct task_struct *cmd_thread;
-	pid_t evtThread;
-	struct task_struct *xmitThread;
-	pid_t recvThread;
 	uint (*dvobj_init)(struct _adapter *adapter);
 	void (*dvobj_deinit)(struct _adapter *adapter);
 	struct net_device *pnetdev;
-- 
2.19.1

