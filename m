Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8453FFD5D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 07:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKOGJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 01:09:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37684 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfKOGJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:09:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 26DCA61179; Fri, 15 Nov 2019 06:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573798190;
        bh=jx/SmZAawFg/FnEm6roPssceTWagqsaNGcQB2jC2CHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8Dqu7ii+dTC5IZdswtH1GUeG9DeSULAQ+pLAnJgYZH9WX3PIr9bW0QTH9ojscgvh
         MC68gwKs6fNpKs6810qbZHz6yGly8p75uk3WnPg9MM6VGGRzlW14czG5eRJ5PRIdG5
         zqatqEGUD6gzNydB6frb7n1kPMdUChws8ZIKwfh0=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CA9961014;
        Fri, 15 Nov 2019 06:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573798185;
        bh=jx/SmZAawFg/FnEm6roPssceTWagqsaNGcQB2jC2CHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOSxaOBzAvfHOZo/PekVaVsfs+ydqtlRTQory/EANWTkPoSKOAo22rjZZto2ryVpK
         0OddkveI7Hnd6yFvN4Zc1q9pwzQyIdK0UikEyJZmkERudW49cCux6qijgtNr2s5YOd
         E16CVrpYvf+ptXgpTx4oL4qFYiX/pdi/5RRwdyFE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CA9961014
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
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 1/7] scsi: ufs: Add device reset in link recovery path
Date:   Thu, 14 Nov 2019 22:09:24 -0800
Message-Id: <1573798172-20534-2-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1573798172-20534-1-git-send-email-cang@codeaurora.org>
References: <1573798172-20534-1-git-send-email-cang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to recover from hibern8 exit failure, perform a reset in
link recovery path before issuing link start-up.

Signed-off-by: Can Guo <cang@codeaurora.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c28c144..525f8e6 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3859,6 +3859,9 @@ static int ufshcd_link_recovery(struct ufs_hba *hba)
 	ufshcd_set_eh_in_progress(hba);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
+	/* Reset the attached device */
+	ufshcd_vops_device_reset(hba);
+
 	ret = ufshcd_host_reset_and_restore(hba);
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

