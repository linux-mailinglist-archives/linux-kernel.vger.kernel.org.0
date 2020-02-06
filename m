Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 363F91548FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 17:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgBFQV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 11:21:27 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54947 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgBFQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:21:26 -0500
Received: by mail-pj1-f67.google.com with SMTP id dw13so175146pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 08:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlJKHAGPQncF0D0oCcwGP81Vimrl3GRnoMKNObOvMNY=;
        b=eH2NDF96uK/D4Lwh2yni2ATG9os2I6zbN0CeYC5MvFVjpyJ72kGNZJ59YvNPLLW/r3
         Xb/jJsZAD9/Gg6iAxWj7se8HvI36n9xOJbhjDoxash7uzRh/Q4unGYsFHNBKeInVGv3e
         NhLc7BSta+YYrLo+LLAnNkFDWr8aDzuUnuxsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlJKHAGPQncF0D0oCcwGP81Vimrl3GRnoMKNObOvMNY=;
        b=CNbXvyumK+zGNxbFoaZ/koqefLK6Hn7SVD2h6qSPU6XdmqEs8qWIZLArFVCalkFgcw
         /97SNeAkq+CJQ6FaFmXoKTVxFbE/vVU3iy5ULWHAhWZs0N4DL0OXSXqYB/4ctFVVGIsp
         /hbEcOMBYPdMQVdYvNvQ9mbwGAuTFavh/253eQ5hlHezg/uhvVFyQfokXyoLsXofV3SJ
         d+Z68hqiTE6cfx+B8MfeOYdI1/iugBY8u4pn9He31WO0LI8LRbHhm+4B7rKUJ3vA9uth
         WIFwtnher3p8Vz1MBK26TD8Fpfe6RTA8qbL51LRMDTmjEjG3fEnwFnZpxIZDCM+zNPK8
         L7sw==
X-Gm-Message-State: APjAAAVBIqQa+KVq9Z2w1ek5DdVc8v9X33Mk9ZDxUsLexrvhPBf5fs2p
        5HsXf+S7/G7wU1aH85XT8417ig==
X-Google-Smtp-Source: APXvYqzdXdztcbyt8vZ93QCo79sb52l3J1PF4VvWaL/OhPnYudGqSKOKkxdxzAyzoIMPAxeoiIorNA==
X-Received: by 2002:a17:902:6809:: with SMTP id h9mr4635684plk.32.1581006085723;
        Thu, 06 Feb 2020 08:21:25 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 13sm3930697pfj.68.2020.02.06.08.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 08:21:25 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] mmc: sdhci-msm: Mark sdhci_msm_cqe_disable static
Date:   Thu,  6 Feb 2020 08:21:24 -0800
Message-Id: <20200206162124.201195-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is not exported and only used in this file. Mark it
static.

Cc: Ritesh Harjani <riteshh@codeaurora.org>
Cc: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/mmc/host/sdhci-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index c3a160c18047..3955fa5db43c 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1590,7 +1590,7 @@ static u32 sdhci_msm_cqe_irq(struct sdhci_host *host, u32 intmask)
 	return 0;
 }
 
-void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)
+static void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
-- 
Sent by a computer, using git, on the internet

