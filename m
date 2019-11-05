Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D55EF450
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 05:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfKEEAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 23:00:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34814 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbfKEEAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 23:00:34 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EAE7F60D5C; Tue,  5 Nov 2019 04:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572926433;
        bh=A09Hg8Gubfo22q2oteGE+XWVmGvlbeGYL8Kj6AbIyz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6QSdTl3teYRhZJCTEQCmpfSVYiAku4tQDJkzQ6FPW7InNeaCTN03OCVm/L399z6S
         3DiB6WCDXP0M0mLwMWZTaCb5lhRbMQ08sKzA9GZ4L6SyM9mLHtYomhdFAQN3ZNtNKS
         qfRPd2BUXKdTGjc+mRSpLgQtrlda+Q1Y7tMv3ofA=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35AC060F6F;
        Tue,  5 Nov 2019 04:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572926432;
        bh=A09Hg8Gubfo22q2oteGE+XWVmGvlbeGYL8Kj6AbIyz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SaIuIh20eitXsdg6OHgSyNkmNdtqVIH2JqziAxmEWCqMX+rgZu1gsKlSw8wvppKHS
         U8IzYVE+T6afRWrljtUEQIWFPtl/1obcazsfiy03x+dTlELL79Uu82gKr+qiRDBVLq
         +QQx611YN0DIQy+UYi7z9eMRMtwUFo1Hk7RzhWcM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35AC060F6F
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
        Subhash Jadavani <subhashj@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 6/7] scsi: ufs: Abort gating if clock on request is pending
Date:   Mon,  4 Nov 2019 19:57:14 -0800
Message-Id: <1572926236-720-7-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572926236-720-1-git-send-email-cang@codeaurora.org>
References: <1572926236-720-1-git-send-email-cang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Asutosh Das <asutoshd@codeaurora.org>

This change attempts to abort gating of clocks if a
request to turn-on clocks is pending.
This would in turn avoid turning OFF and back ON the
clocks.

Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 8d1b04f..7a5a904 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1610,7 +1610,7 @@ static void ufshcd_gate_work(struct work_struct *work)
 	 * state to CLKS_ON.
 	 */
 	if (hba->clk_gating.is_suspended ||
-		(hba->clk_gating.state == REQ_CLKS_ON)) {
+		(hba->clk_gating.state != REQ_CLKS_OFF)) {
 		hba->clk_gating.state = CLKS_ON;
 		trace_ufshcd_clk_gating(dev_name(hba->dev),
 					hba->clk_gating.state);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

