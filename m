Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70E80E7EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 04:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfJ2DLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 23:11:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34574 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731303AbfJ2DLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 23:11:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7F22F60E08; Tue, 29 Oct 2019 03:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572318678;
        bh=QOMM1JLfQuLl5xgLBg3JI116eBhJGK2de0nSqrGNU6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVX3pMj15T7WqcTurLoipaP0G5+pAjClPFoe7bONEf3HjYjXauSTEJRbNjePOJgMo
         BwH6kt5+cH5H/F5ceCunjY7wuimhgXU3pKVG6DJ7CXrWWecpRdIDwD9XCR3LB8bj3V
         w7F7MjlHHrJ69beC1yF3ETRvMt7cT2UBIrZiM17E=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E73260D8F;
        Tue, 29 Oct 2019 03:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572318677;
        bh=QOMM1JLfQuLl5xgLBg3JI116eBhJGK2de0nSqrGNU6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ubq0m4LRLu+EDr4v9KDVDIEILFfcv2VsPxXA2get/pdgmaa5lqKb+IlEVrDuoJTXA
         RjTyf2DAWxXrI/CpvuoOmpzVrog3yvT6+Pk4TJnJsMUt9BfWquMgiFvNWAobjpcgCT
         VXmGJUoxOJaFTSDQCARS+B7oaOofbhH51PDj2oCM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E73260D8F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/5] scsi: ufs: Set DBD setting in mode sense for caching mode page
Date:   Mon, 28 Oct 2019 20:10:51 -0700
Message-Id: <1572318655-28772-3-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572318655-28772-1-git-send-email-cang@codeaurora.org>
References: <1572318655-28772-1-git-send-email-cang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host sends MODE_SENSE_10 with caching mode page, to check if the device
supports the cache feature.
UFS standards requires DBD field to be set to 1.

Some card vendors are more strict and check the DBD field, hence
respond with CHECK_CONDITION (Sense key set to ILLEGAL_REQUEST and
ASC set to INVALID FIELD IN CDB).
As a result of the CHECK_CONDITION response, host assumes that the
device doesn't support the cache feature and doesn't send
SYNCHORONIZE_CACHE commands to flush the device cache.
This can result in data corruption in case of sudden power down, when
there is data stored in the device cache.

This patch fixes the DBD field setting in case of caching mode page.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c28c144..101b4d0 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8329,6 +8329,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	host->max_channel = UFSHCD_MAX_CHANNEL;
 	host->unique_id = host->host_no;
 	host->max_cmd_len = UFS_CDB_SIZE;
+	host->set_dbd_for_caching = 1;
 
 	hba->max_pwr_info.is_valid = false;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

