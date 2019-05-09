Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C143918EE6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 19:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfEIRYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 13:24:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46152 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfEIRYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:24:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id t187so1529247pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cPBzyUAV50pAnZfXXI85W0FJrR1AmwGO+3Mm+J5Ler8=;
        b=KZymrmgNoadDcCwAw9QgPOqaSR0OLrD5V49mAh1uQt0GgJ3kfSscqL6ofV06PDPlwW
         7JIc+kGuIJRjIpOrvb6N2dADvTRctPUm5ttHOPJ1QG1d5TZIv7631WzfeC7gBsCMTlN1
         fbPaM6gs/seQ3JgTCfuCXd2U0Uj505rmkAGeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cPBzyUAV50pAnZfXXI85W0FJrR1AmwGO+3Mm+J5Ler8=;
        b=oqIsF0Eaa8N3qpPo+yoVGWXnw/fyPoQ09qWP+hN6SBk+PdG2KuSHedoLb4+R9tz8cq
         30PdKLdvLQceYkEkZZLCgSmbPO5lCRYn+YTsUIXMY5PNulcBTG+Odp0uFDmmq0ol7N56
         2DyeRYRA2+2AplTI3uqLCVLyiQVYmo5f71EmJXG2J6U7jw9P6mCa2yNhnfUVuyvBjB2o
         GlvQCMzX5tYNwCw9hq3GUYjDD9A9yZW7jk6WYweo91IQyOWnPNW2m4DD7UQWPKBjjx8I
         9Uk2UpppKM3+2LT+xQgaayLhfL+vrMTdXjMhg8PlTaxYZ/vrm0FQSGhxAxAuXVjsba6w
         mKyw==
X-Gm-Message-State: APjAAAVHqF1ttSgmjsPBeTV2KsE7Fwv5UP1I1uvjdlmZJLyquUh+jHJW
        57iu6CFaSrFGevD8rCcBEj8m2Q==
X-Google-Smtp-Source: APXvYqwltYnMRdytoyt+Gakgvt9eaNw+HtE2WFlXBJvXLOllj4Xdxq3+5a4BOoOCJ7GUUv5cjQ6L4w==
X-Received: by 2002:a62:3892:: with SMTP id f140mr6877728pfa.128.1557422677403;
        Thu, 09 May 2019 10:24:37 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m8sm3989699pgn.59.2019.05.09.10.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:24:36 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Trac Hoang <trac.hoang@broadcom.com>,
        stable@vger.kernel.org, Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v3 1/2] mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold time problem
Date:   Thu,  9 May 2019 10:24:26 -0700
Message-Id: <20190509172427.17835-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509172427.17835-1-scott.branden@broadcom.com>
References: <20190509172427.17835-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trac Hoang <trac.hoang@broadcom.com>

The iproc host eMMC/SD controller hold time does not meet the
specification in the HS50 mode. This problem can be mitigated
by disabling the HISPD bit; thus forcing the controller output
data to be driven on the falling clock edges rather than the
rising clock edges.

This change applies only to the Cygnus platform.

Stable tag (v4.12+) chosen to assist stable kernel maintainers so that
the change does not produce merge conflicts backporting to older kernel
versions. In reality, the timing bug existed since the driver was first
introduced but there is no need for this driver to be supported in kernel
versions that old.

Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Trac Hoang <trac.hoang@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-iproc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 9d12c06c7fd6..9d4071c41c94 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -196,7 +196,8 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
 };
 
 static const struct sdhci_pltfm_data sdhci_iproc_cygnus_pltfm_data = {
-	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
+	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_NO_HISPD_BIT,
 	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN | SDHCI_QUIRK2_HOST_OFF_CARD_ON,
 	.ops = &sdhci_iproc_32only_ops,
 };
-- 
2.17.1

