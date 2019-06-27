Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6888C588E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfF0Rml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 13:42:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44570 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfF0Rmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:42:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id t7so1669302plr.11;
        Thu, 27 Jun 2019 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5Ezs9yR+V5CEPE+IWEBe9x8qjfB3g7Yh4jRZ8SzibyA=;
        b=E3IFscwpCQB8sJI70WBjsKLJ7UQpmaanZzv4uGMJpfxLGX+3dAH9RGaZc34Dizh0Hh
         3YbX3B6pZZUvDG145ojbz9jRwkkDlxRkMsGEjEWXIr6w4/MsKLsOTZ9XWQzjvxknkM3U
         b3d1WeAyLhU7SDosgxozzecg4oIZYZFk1SS1bNwuyR+DPuWjPJDrCnpWHEAVyVzbyAiJ
         nS2EJWBTO3nqzYLAz8T1QD4lG3EzkApff+oItLdTmIlSSO8OUkAGsW9Sf11WB1JCyhg9
         OX/vcyD8CggmPrUpICqxfYbc8bf7SKwP3ST33GaRl7+B/QYyvsc8V+1cKhK3Od4LIdYC
         M05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Ezs9yR+V5CEPE+IWEBe9x8qjfB3g7Yh4jRZ8SzibyA=;
        b=Q5hnpYLg8OlF/uT4JTr67eoYLFb7v0VzIfvKOf+/ki10vwhkHFrpZOI2fwlco/Q55s
         mGkOQe9II5F3Xe+HuRpqf2cj59WCai2tSYe2rdE3slHyyFSFH3ODKxiHGWPLJp9hbL4/
         D/kgjpEocCebUdpNnBsRxxkVJnNIUX1QJsPqs0NE8kyHyOx9x4rVuKaRPPofDGZVDzVB
         GRph3OzeKJ3S5qt4nPQEgedbmDN5HDu/KQcAYbnWP59dzRxmADDx1Qr/ivcXj7NU+QU2
         rFtsEMhYLSwlLsBH3NDbH/JEEXXsvPH/PD47iu24NI0siO3D8m2Fvp4aJpa9xXE962aX
         isWg==
X-Gm-Message-State: APjAAAWcT31bETuk/lCccvrY2HGdHOVSbRhj5FCWwEPQQnxWb4Pmntta
        QoZVfT3tc6FQZtg1onRf3Lo=
X-Google-Smtp-Source: APXvYqzDscwAugDNoZLFZc6wRWIqEpE67Vy1X5tO9PF2LiSKJal69Ppl31lKuwNBFw4yvRaV7TkG0g==
X-Received: by 2002:a17:902:7b84:: with SMTP id w4mr5910694pll.22.1561657360043;
        Thu, 27 Jun 2019 10:42:40 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id y22sm3963842pfo.39.2019.06.27.10.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:42:39 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 52/87] scsi: qlogicpti: remove memset after dma_alloc_coherent in qlogicpti.c
Date:   Fri, 28 Jun 2019 01:42:33 +0800
Message-Id: <20190627174233.4776-1-huangfq.daxian@gmail.com>
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
 drivers/scsi/qlogicpti.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 9335849f6bea..7868db052042 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -828,8 +828,6 @@ static int qpti_map_queues(struct qlogicpti *qpti)
 		printk("QPTI: Cannot map request queue.\n");
 		return -1;
 	}
-	memset(qpti->res_cpu, 0, QSIZE(RES_QUEUE_LEN));
-	memset(qpti->req_cpu, 0, QSIZE(QLOGICPTI_REQ_QUEUE_LEN));
 	return 0;
 }
 
-- 
2.11.0

