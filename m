Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22B158920
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 19:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfF0Rpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 13:45:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45975 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfF0Rpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:45:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so1575050pfq.12;
        Thu, 27 Jun 2019 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YPi4AE8LxuYHFBBgFOmJZOFeT/d8VNiM/d5F7Gh71kU=;
        b=qc257Vlq5v3rz8tkmg54SqUeROUxhOFmh2IPr9SxiwUKQHob3vswRZggYISuxnQkUE
         xPypkdOYiyDI4FWKxNqg22SUW7z9e+xA5b8GxpnKTmEQzvaCLUqVJb0wDaTo5o551TDj
         /z99YLG+gpEM/N14Tumu+/j/UpAlWLyO19PmDoku8BnXwmGoeSUr42Xh4+blMAHOqKqI
         lF+Z6F12SD2xOYA+RFNh6jQyOBhodeDwcbrlCzNMzlZ1JxS3Frnp2kOdLwYxc9NkOZIK
         tiNWx4gqsR7hzXw04EYraUWRlQ9XE3GI8mKpW0SY1cJm9dmupubQFL7A3Cm83grnfyBD
         M9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YPi4AE8LxuYHFBBgFOmJZOFeT/d8VNiM/d5F7Gh71kU=;
        b=Iwtdq1zzjp42oDfc1BitdVG2u9IStBiwP8Q9Imcuffoe/A3mV66u9KojXwX9ZST1W4
         S1/acBx5So5L+wEpfYdbvIhuq3TD9jzvKl88wbon/RdlB2wjH5+hx8FS6sOFj7eAFd0P
         l9oy8C5/y4imFcQqm07+zpZawXrrqWCE8K8yGs8gmSP4OZuzEELP49/3jV3xDnLxEo8A
         CHgnJIlrM6/mW1j1FzAul8lt3kFZv0FW8S2Urc/cP7WioyhRuXeLnoUEyNKA3lctWKBU
         Ez330f81DsGfy490ZE03IpFMilK1FouAt2oAXlr8hNaBvOulmr4RoJ5ALH9yVAHKAWlQ
         yaBA==
X-Gm-Message-State: APjAAAVNoh6UM9NtO6ZhjztzhIahH9n7QdCDNjLYM+KCLCZjdDLTBniB
        MYpQq54Ve1ysoectsZhNxdM=
X-Google-Smtp-Source: APXvYqzvyYWWf3xC0vIBqtCIreSYFokq6bqpYgaYx6wEZKhRVl/Gzon5TUvkit6x5VXJcWrBkvrQ4Q==
X-Received: by 2002:a17:90a:2343:: with SMTP id f61mr7535840pje.130.1561657551910;
        Thu, 27 Jun 2019 10:45:51 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id s17sm2378226pgi.9.2019.06.27.10.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:45:51 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 68/87] scsi: be2iscsi: remove memset after dma_alloc_coherent in be_iscsi.c
Date:   Fri, 28 Jun 2019 01:45:44 +0800
Message-Id: <20190627174545.6098-1-huangfq.daxian@gmail.com>
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
 drivers/scsi/be2iscsi/be_iscsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/be2iscsi/be_iscsi.c b/drivers/scsi/be2iscsi/be_iscsi.c
index 2058d50d62e1..09d63bac6d80 100644
--- a/drivers/scsi/be2iscsi/be_iscsi.c
+++ b/drivers/scsi/be2iscsi/be_iscsi.c
@@ -1081,7 +1081,6 @@ static int beiscsi_open_conn(struct iscsi_endpoint *ep,
 		return -ENOMEM;
 	}
 	nonemb_cmd.size = req_memsize;
-	memset(nonemb_cmd.va, 0, nonemb_cmd.size);
 	tag = mgmt_open_connection(phba, dst_addr, beiscsi_ep, &nonemb_cmd);
 	if (!tag) {
 		beiscsi_log(phba, KERN_ERR, BEISCSI_LOG_CONFIG,
-- 
2.11.0

