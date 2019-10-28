Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F44E6B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 04:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbfJ1Dul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 23:50:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44934 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbfJ1Duj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 23:50:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4920660B6E; Mon, 28 Oct 2019 03:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572234639;
        bh=RJ5p8lSM8JQFxANAulacrnApspWJ3qXOe0QjHj7b2DA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ky5pIumVxXOkyNCgoqhY2mvkXmkC8SPawKc8E4M2bG8ooVBlFIkMqN8j5SiI2WMTR
         D2NC4El1Dl+VdReqrCUak7EkoFmbdwYeimPJZ06yE6p2UtCYP1RLI7QX/RgBgTIl75
         TPFoZoQ3868v7iLa5+fu4YhzizIEAyepaj+B5rLc=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73B3660A34;
        Mon, 28 Oct 2019 03:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572234638;
        bh=RJ5p8lSM8JQFxANAulacrnApspWJ3qXOe0QjHj7b2DA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cA8REEa9z7q9Zr3rffjSbzulfZwcqlpk0OOKCWGmklooeo7eFhCp4Eoz9op1ns4QE
         thcGRdaXM24xSovDayg2HH2nh5Y8IBX05d/Rw4NLozJdAkHUCbfS4c6xcl1RpILf1Y
         QJefrDuF49vfubM9zMqEeSIEUAcX+GffwhTCZ6RU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73B3660A34
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
Subject: [PATCH v1 3/5] scsi: ufs: Release clock if DMA map fails
Date:   Sun, 27 Oct 2019 20:50:05 -0700
Message-Id: <1572234608-32654-4-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572234608-32654-1-git-send-email-cang@codeaurora.org>
References: <1572234608-32654-1-git-send-email-cang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In queuecommand path, if DMA map fails, it bails out with clock held.
In this case, release the clock to keep its usage paired.

Change-Id: Ia3e3e19086c58a27ed2a794fcbbac341e584a474
Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 101b4d0..6e9236a 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2480,6 +2480,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	if (err) {
 		lrbp->cmd = NULL;
 		clear_bit_unlock(tag, &hba->lrb_in_use);
+		ufshcd_release(hba);
 		goto out;
 	}
 	/* Make sure descriptors are ready before ringing the doorbell */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

