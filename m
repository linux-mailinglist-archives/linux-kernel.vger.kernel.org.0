Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD276F2973
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 09:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbfKGImr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 03:42:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33242 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfKGImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:42:45 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 74C116092D; Thu,  7 Nov 2019 08:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573116164;
        bh=sDQBDxXRZCeKsQ9VGvBn0JftH8Dvu3dtqOVJgd7P6j0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLTce5YjG5hgR+AHuqL5QTSUmhvEjYc+X1xxm101E90uTd6g59vsq9CzuqN7r557J
         yDFLPisiX6AX9e3pSFEANRxf0Urt/YWiblCTYNW+4pd5qeryTylqHdkJFwoIsyHLzn
         opKDXamDfjucl20ER8PLTOG3lB5DYdLew4VMYD0Y=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 060036085F;
        Thu,  7 Nov 2019 08:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573116162;
        bh=sDQBDxXRZCeKsQ9VGvBn0JftH8Dvu3dtqOVJgd7P6j0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSZRC0pRiU1Eo2TCL2wjHBfr2TyNIvj4xalCc/4K9Z0YAfMCUxeFulwbEg7jsMUvT
         jLFGsIkCU6ayHe2QcGtx5OkJ0PRBVdrlbH61oBwig+jtPG3gL2LkjAw3W0rrkpAQGw
         vOITGj5dYMPEJ9IlrBUZMAy7aR601nCX3pqdvujw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 060036085F
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
        Tomas Winkler <tomas.winkler@intel.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 2/6] scsi: ufs: set load before setting voltage in regulators
Date:   Thu,  7 Nov 2019 00:42:09 -0800
Message-Id: <1573116140-22408-3-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1573116140-22408-1-git-send-email-cang@codeaurora.org>
References: <1573116140-22408-1-git-send-email-cang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Asutosh Das <asutoshd@codeaurora.org>

This sequence change is required to avoid dips in voltage
during boot-up.

Apparently, this dip is caused because in the original
sequence, the regulators are initialized in lpm mode.
And then when the load is set to high, and more current
is drawn, than is allowed in lpm, the dip is seen.

Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c2de29f..c386c2d 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7225,6 +7225,11 @@ static int ufshcd_config_vreg(struct device *dev,
 	name = vreg->name;
 
 	if (regulator_count_voltages(reg) > 0) {
+		uA_load = on ? vreg->max_uA : 0;
+		ret = ufshcd_config_vreg_load(dev, vreg, uA_load);
+		if (ret)
+			goto out;
+
 		if (vreg->min_uV && vreg->max_uV) {
 			min_uV = on ? vreg->min_uV : 0;
 			ret = regulator_set_voltage(reg, min_uV, vreg->max_uV);
@@ -7235,11 +7240,6 @@ static int ufshcd_config_vreg(struct device *dev,
 				goto out;
 			}
 		}
-
-		uA_load = on ? vreg->max_uA : 0;
-		ret = ufshcd_config_vreg_load(dev, vreg, uA_load);
-		if (ret)
-			goto out;
 	}
 out:
 	return ret;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

