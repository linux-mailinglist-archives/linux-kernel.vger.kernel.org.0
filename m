Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09708FFD77
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 04:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKRDyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 22:54:51 -0500
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:35346
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbfKRDyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 22:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574049289;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=LZu8RInnO3guFGROW0ewhSbCJOgJfmUIOWNgeOU48Mk=;
        b=E46OXh4FEwfhj5xRDN7dkjVZmNKL54s+t6Z3aLd9mijX2Xl1CbzPYzXjWzBdtX+R
        yJ0HSHlIy7P/v3PVELCrYamhorZtZC5PnvPbFQc/b0IQnPAGwX+vVQQC6EJ2ivvt71Q
        hVQK5ZpO1+4On/j0xfd/c5qUSGQIgfARU4szzqqQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574049289;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=LZu8RInnO3guFGROW0ewhSbCJOgJfmUIOWNgeOU48Mk=;
        b=XjT7KIE4rS3N8tBg+ZAps4kicTgMtEyGQ1V34wxN2ikWlD507PIP+XnDIz/ph53w
        ks8xUxfINGJsvuHzMFhTRSbz/GZ7GzohEGwocdUk0Q3X5UL2jyS05HGmrSEZdo3XsZc
        hrdRpwJd1NVe+0NwwCshzYS8ylxADfZL7tmYvCME=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06F5DC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
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
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/4] scsi: ufs: Recheck bkops level if bkops is disabled
Date:   Mon, 18 Nov 2019 03:54:49 +0000
Message-ID: <0101016e7ca61572-bf100c84-1209-46ae-a209-e30e68109a95-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1574049277-13477-1-git-send-email-cang@codeaurora.org>
References: <1574049277-13477-1-git-send-email-cang@codeaurora.org>
X-SES-Outgoing: 2019.11.18-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Asutosh Das <asutoshd@codeaurora.org>

Bkops level should be rechecked upon receiving an exception.
Currently the bkops level is being cached and never updated.

Update the same each time the level is checked.
Also do not use the cached bkops level value if it is disabled
and then enabled.

Fixes: afdfff59a0e0 (scsi: ufs: handle non spec compliant bkops behaviour by device)
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3910c58..8e7c362 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5099,6 +5099,7 @@ static int ufshcd_disable_auto_bkops(struct ufs_hba *hba)
 
 	hba->auto_bkops_enabled = false;
 	trace_ufshcd_auto_bkops_state(dev_name(hba->dev), "Disabled");
+	hba->is_urgent_bkops_lvl_checked = false;
 out:
 	return err;
 }
@@ -5123,6 +5124,7 @@ static void ufshcd_force_reset_auto_bkops(struct ufs_hba *hba)
 		hba->ee_ctrl_mask &= ~MASK_EE_URGENT_BKOPS;
 		ufshcd_disable_auto_bkops(hba);
 	}
+	hba->is_urgent_bkops_lvl_checked = false;
 }
 
 static inline int ufshcd_get_bkops_status(struct ufs_hba *hba, u32 *status)
@@ -5169,6 +5171,7 @@ static int ufshcd_bkops_ctrl(struct ufs_hba *hba,
 		err = ufshcd_enable_auto_bkops(hba);
 	else
 		err = ufshcd_disable_auto_bkops(hba);
+	hba->urgent_bkops_lvl = curr_status;
 out:
 	return err;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

