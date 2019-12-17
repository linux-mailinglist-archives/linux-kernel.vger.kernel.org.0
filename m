Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E308122241
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 03:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfLQCxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 21:53:05 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:61772 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727114AbfLQCwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 21:52:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576551166; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=cKIflnlC63Jh0qRMRCvYsjPtIktdfv+PbLtl17Zq0R8=; b=TbKiND+E2FD0Nn5ZJ71ecg+V4FLDp/yViYn2k7bMQGXP3FAinsRTp5zK6Knf6Ku+VDKthbOm
 8eBH/7vnys6W1qHrb7GpmOd5RAbt16eFXsLqEjG5PADJUZAgTfsPC9tTBduaTy/4dGbcHXpg
 fEyjko5Dr083BmHlvDUhuJB5kqI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df842fd.7f15fe07c458-smtp-out-n03;
 Tue, 17 Dec 2019 02:52:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1B233C4479C; Tue, 17 Dec 2019 02:52:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nguyenb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25A96C43383;
        Tue, 17 Dec 2019 02:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25A96C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=nguyenb@codeaurora.org
From:   "Bao D. Nguyen" <nguyenb@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        Sujith Reddy Thumma <sthumma@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Xiaonian Wang <xiaonian@codeaurora.org>,
        "Bao D. Nguyen" <nguyenb@codeaurora.org>
Subject: [<PATCH v1> 7/9] mmc: core: Skip frequency retries for SDCC slots
Date:   Mon, 16 Dec 2019 18:50:40 -0800
Message-Id: <68b936a67e67cd25597915cbd76b73ed046d1ce4.1576540908.git.nguyenb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sujith Reddy Thumma <sthumma@codeaurora.org>

Qualcomm SDCC controller supports minimum SD clock frequency
which is required for card initialization. This information is
exported through platform data for each SDCC controller. There is
no need of retrying higher frequencies than the minimum supported
by controller for Qualcomm chipsets which inturn add delay in
detection process if there is no card during suspend/resume cycles.
Hence, skip multiple frequency retries.

Signed-off-by: Sujith Reddy Thumma <sthumma@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Xiaonian Wang <xiaonian@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
---
 drivers/mmc/core/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1e37f78..38b0cec 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2281,7 +2281,6 @@ void mmc_rescan(struct work_struct *work)
 {
 	struct mmc_host *host =
 		container_of(work, struct mmc_host, detect.work);
-	int i;
 
 	if (host->rescan_disable)
 		return;
@@ -2332,13 +2331,7 @@ void mmc_rescan(struct work_struct *work)
 		mmc_release_host(host);
 		goto out;
 	}
-
-	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
-		if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
-			break;
-		if (freqs[i] <= host->f_min)
-			break;
-	}
+	mmc_rescan_try_freq(host, host->f_min);
 	mmc_release_host(host);
 
  out:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
