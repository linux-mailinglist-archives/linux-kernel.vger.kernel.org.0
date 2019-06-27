Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44803588EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 19:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfF0Rm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 13:42:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46716 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfF0Rmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:42:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so1657694pls.13;
        Thu, 27 Jun 2019 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=czn3EWz06kwMCEMtsQe0/flLmYYN2GTMsUHF6cAN/yM=;
        b=hKQTwtwX7167NpH+v1Asuggh/g7b2T9ttFn/pEdyb/QY5b0CVyWCaGAkvF5pN4s/g3
         /nIu5Dv628pzTE96YEsfu/QT/xe5/+sXNePvQAtJ/E9h59Vp+Z+nFyTafCFy561pnyUD
         vcgHOdyecU3wdePTXqdZBecqfe0OPWsZqc/P0uonQY9Iv79lOZxUP7C0ir9EDd9UKS3i
         /Cz2UEwwvpNTnivGdiB5A9JVAWYFwSyiJhdR59sLtVc0q2vlXHSeFeQSy1juuC68IPc8
         lMyxUt787XM3PS7QXl+bUth+7brG0ccknxXkZ75WRURtwnF/XjgwXzjQyFKCAlgB9cSu
         vzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=czn3EWz06kwMCEMtsQe0/flLmYYN2GTMsUHF6cAN/yM=;
        b=tqWDeJfL9nS9vTfSL4Kp1VbrDjvn/bMa9PEk15EHQb/IM1UuSs9w9V7hZ3t82sEwpd
         YBBR2kqJ2Ea8X/JRcRo5Wc63vtln95WOnJdb8HT78czcSvNF5rDwSAwtenyNxloam83x
         mopGiBudVKvGeDfel2dbtT5OpCpo1PqsHgbcRPsbo4mXBulN9qji22tcbiso+Szx5PtN
         lVed7zNVcP3nZEJ7W6DyRJzRLPoYsTelbhhP9P3cgPdQOcciNw/ATiXilIvWZbjCr1Tf
         NvD/4CcugWmU/m179dQJTAEJCMml01rabZZiEP4EpAf+MWJSK4S/vkFfQTLePUAr6NQ/
         21lA==
X-Gm-Message-State: APjAAAUv7BFGXzpaDi6gVJTI/WvLVk4hUJLqHCa0vnYmPgyqP0nCxW6m
        AG2cK2G4N3ZAILbO8wuaBZQ=
X-Google-Smtp-Source: APXvYqzOJM+wi7hC4AdeABa1mwhVC+Rgm36FaAEoqyjwEVgn83VRXKJ39qmMhXRB1+SrxAtm1Kep8w==
X-Received: by 2002:a17:902:9b81:: with SMTP id y1mr6298339plp.194.1561657374827;
        Thu, 27 Jun 2019 10:42:54 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id i123sm4791784pfe.147.2019.06.27.10.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:42:54 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 53/87] scsi: qla4xxx: remove memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:42:47 +0800
Message-Id: <20190627174248.4830-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/scsi/qla4xxx/ql4_mbx.c | 1 -
 drivers/scsi/qla4xxx/ql4_os.c  | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_mbx.c
index dac9a7013208..eb3167186586 100644
--- a/drivers/scsi/qla4xxx/ql4_mbx.c
+++ b/drivers/scsi/qla4xxx/ql4_mbx.c
@@ -2354,7 +2354,6 @@ int qla4_84xx_config_acb(struct scsi_qla_host *ha, int acb_config)
 		rval = QLA_ERROR;
 		goto exit_config_acb;
 	}
-	memset(acb, 0, acb_len);
 
 	switch (acb_config) {
 	case ACB_CONFIG_DISABLE:
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 8c674eca09f1..8666d4fc93da 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -9478,8 +9478,6 @@ static int qla4xxx_context_reset(struct scsi_qla_host *ha)
 		goto exit_port_reset;
 	}
 
-	memset(acb, 0, acb_len);
-
 	rval = qla4xxx_get_acb(ha, acb_dma, PRIMARI_ACB, acb_len);
 	if (rval != QLA_SUCCESS) {
 		rval = -EIO;
-- 
2.11.0

