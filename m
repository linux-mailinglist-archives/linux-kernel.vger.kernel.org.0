Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 701DBED6FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 02:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfKDBg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 20:36:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfKDBg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:36:28 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BFF7360F62; Mon,  4 Nov 2019 01:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572831387;
        bh=YGs0HFAfG990zlYDTL4p8WA1cAzECcjOWDR3bJ3XKZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jhDKIXFq7FFLhT2bFAkJP4V5OuSa1moMRAY5PYD7CFzUAtE91fU8dvDSwrAgtZkaL
         2ioo9dIBHjhaQOhMMusHBNxHz4bxRO5Gkd7nfEszxOcCqn2WMMEdtgnlfWFBnsQjbP
         mzJ9PVU+pzo3NjWGhtY4wDkMY3aJdNilQJEWODew=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0DA5560F62;
        Mon,  4 Nov 2019 01:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572831386;
        bh=YGs0HFAfG990zlYDTL4p8WA1cAzECcjOWDR3bJ3XKZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YcQBFh+vhJLFoHS2BIrmR1+6M2XqBk/nDlK+WKlpH3aEAXiJkA5txG6EF4J9wIJBL
         03pEp+4NLDR5EHIz6jHnt4aBvfrdGys8qrQa3YAUgVIkeQJSx1HQWFKRYJpQx3c+n6
         ka4V3vNH+lu1iYqDB8dFHQ6/jBC1Fu/JKDxMX6Pg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DA5560F62
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
Subject: [PATCH v2 4/7] scsi: ufs: Fix register dump caused sleep in atomic context
Date:   Sun,  3 Nov 2019 17:35:59 -0800
Message-Id: <1572831362-22779-5-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572831362-22779-1-git-send-email-cang@codeaurora.org>
References: <1572831362-22779-1-git-send-email-cang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ufshcd_print_host_regs() can be called by interrupt handler, but it may
sleep due to ufshcd_dump_regs() allocates the dump buffer memory with flag
GFP_KERNEL. Fix it by changing GFP_KERNEL to GFP_ATMOIC.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index f12f5a7..671ea2a 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -117,7 +117,7 @@ int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
 	if (offset % 4 != 0 || len % 4 != 0) /* keep readl happy */
 		return -EINVAL;
 
-	regs = kzalloc(len, GFP_KERNEL);
+	regs = kzalloc(len, GFP_ATOMIC);
 	if (!regs)
 		return -ENOMEM;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

