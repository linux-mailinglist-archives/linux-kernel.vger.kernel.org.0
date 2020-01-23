Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165541473D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 23:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgAWWcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 17:32:17 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:40734 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgAWWcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:32:17 -0500
Received: by mail-il1-f195.google.com with SMTP id c4so161163ilo.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 14:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L7Z0MQLgFpVUqRMkpIW9BsJ/F7zZnMMX5vKIMOIOUGo=;
        b=JPtl/BXYDpF1WbyX3AFyai/TuIIICFzkw2YEVeL9iEiDTCopZDplYRtiYVhVJRlCXP
         sIv/mBcCxDR4iebP3GSRqf8FL/+ZJlFKIgafnRYwSDJdKS+J+xBxa1m9h/GdtOkYAidM
         2FelKQjhC9UjUH7sPHn2sd2t3b8ghc75wJivU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L7Z0MQLgFpVUqRMkpIW9BsJ/F7zZnMMX5vKIMOIOUGo=;
        b=Xh84wLnkNRg9+8FpLok0FoIr6nBbHPEN2NeE4yCIsVuR+0Xgg6uUF8XEvRVBfxe4Oj
         7vT1V5ou98Q+wh7Q4eUwPcdqTqobXkEO1lNuo5GZjSVoyGgnC7Qz5jLC3c0Z3DAq5JE3
         luFTRdpYdvZyFoz+ulWx2bKGUVb1WuL3RG3PkOOlTrjW5uGI0YpJSkjnMc/fr9oSLPsu
         yqWMFZl7HFJ16rnAVBs6FTN9odR+DWMbRMCPNuOYyGs4y/JgUoKeHYqSOWHNz4WB0dYm
         r4EGWgMPmbNOuR0LR3lUbBFkhrlpAC0cwtF5oh1s8hcpSic2RdGMmKIAUDVRUb5q/mXp
         qPAQ==
X-Gm-Message-State: APjAAAV16AX/9Klxb6nes887DS/ArCKaggJv7Oz70PKxnAfwcR3tm3nL
        X03+CSG3ghGBbrlAJQJkfMLtwcMd414=
X-Google-Smtp-Source: APXvYqxIuGjlwsK0WON45gzxdSefs72kcw1Dv0XZbxXn2BlLfgH1D4+eYrs9Jh4lr0Mn1phz0S3vlg==
X-Received: by 2002:a92:85c1:: with SMTP id f184mr434426ilh.221.1579818736563;
        Thu, 23 Jan 2020 14:32:16 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f4sm716943ioh.45.2020.01.23.14.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 14:32:16 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     joro@8bytes.org, suravee.suthikulpanit@amd.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu: amd: Fix IOMMU perf counter clobbering during init
Date:   Thu, 23 Jan 2020 15:32:14 -0700
Message-Id: <20200123223214.2566-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_iommu_perf_ctr() clobbers the register when it checks write access
to IOMMU perf counters and fails to restore when they are writable.

Add save and restore to fix it.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes since v1:
-- Fix bug in sucessful return path. Add a return instead of
   fall through to pc_false error case

 drivers/iommu/amd_iommu_init.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 568c52317757..483f7bc379fa 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1655,27 +1655,39 @@ static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
 	struct pci_dev *pdev = iommu->dev;
-	u64 val = 0xabcd, val2 = 0;
+	u64 val = 0xabcd, val2 = 0, save_reg = 0;
 
 	if (!iommu_feature(iommu, FEATURE_PC))
 		return;
 
 	amd_iommu_pc_present = true;
 
+	/* save the value to restore, if writable */
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
+		goto pc_false;
+
 	/* Check if the performance counters can be written to */
 	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
 	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
-	    (val != val2)) {
-		pci_err(pdev, "Unable to write to IOMMU perf counter.\n");
-		amd_iommu_pc_present = false;
-		return;
-	}
+	    (val != val2))
+		goto pc_false;
+
+	/* restore */
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
+		goto pc_false;
 
 	pci_info(pdev, "IOMMU performance counters supported\n");
 
 	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
 	iommu->max_banks = (u8) ((val >> 12) & 0x3f);
 	iommu->max_counters = (u8) ((val >> 7) & 0xf);
+
+	return;
+
+pc_false:
+	pci_err(pdev, "Unable to read/write to IOMMU perf counter.\n");
+	amd_iommu_pc_present = false;
+	return;
 }
 
 static ssize_t amd_iommu_show_cap(struct device *dev,
-- 
2.20.1

