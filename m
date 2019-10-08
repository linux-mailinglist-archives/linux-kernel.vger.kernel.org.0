Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F0AD0453
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 01:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfJHXpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 19:45:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43829 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfJHXpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:45:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so348578pfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 16:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hFAVYC3XM0iiwUmU9uc9RvZO3TOksuf/Klbv6GZY3e8=;
        b=TCcdP4NbmK6Zd+nsndsXfWNT7g9i4ibsEB7+fNkqpXk7gUh5AYroitEfrHKYA/Hf1S
         YM/7jXfa0Hkno3hSUrsbodKo8cY5Z1Ieqo8Fokem2qAdb5gpt6ZO97ZwtgJBbYm8tHpB
         jP44MEzKc0rA36mIWZTVpBbjXrdEXP5iO/hro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFAVYC3XM0iiwUmU9uc9RvZO3TOksuf/Klbv6GZY3e8=;
        b=RZz/LtDcSiIvkQQraP+B5K18vH4N/qYKHZZmBR81vW7LWQUbqPUQ3r8JWvLnCxANwj
         IKc/NplK5zix00gRWKrbY/gSS9QOPGpl8V620lPsOD0rnNfXVShJTP98v6g/OD8EFcQT
         gUEvtHgDZLAWyaaKlMwCmif4fF6PYI7URFNEYEDboWMWRsm2jIZrE6LjkUhTvObvd8xI
         OCnbXuBlZt2HMjA205NekXKBeSdDII7USOSFcHPdZypGTl2OEJcUfDhOCkB9flifHJQB
         M+hWX112K8Cp1xhD7o6uiHRF21p8bKpAnOxwGG/RwruU/7bKOZ5RIv+Eb597CGPMeDFf
         OTsw==
X-Gm-Message-State: APjAAAUrUI7vQ326/SbuIY6m4kmJNPu2O51lQXnNLL0/OhNvwE4dF7in
        QNMbex40PP6IXVpYSeokL+nkCw==
X-Google-Smtp-Source: APXvYqyFFkKcFGWjRDwVFDODJz9fk+odgUjS03Z5Bp8Lldzec7aMPglCruu+rdoEmgfH13/vgMG6Aw==
X-Received: by 2002:aa7:95a2:: with SMTP id a2mr572338pfk.252.1570578308881;
        Tue, 08 Oct 2019 16:45:08 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s202sm210671pfs.24.2019.10.08.16.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 16:45:08 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 2/2] soc: qcom: llcc: Move regmap config to local variable
Date:   Tue,  8 Oct 2019 16:45:05 -0700
Message-Id: <20191008234505.222991-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191008234505.222991-1-swboyd@chromium.org>
References: <20191008234505.222991-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now a global variable that we're modifying to fix the name.
That isn't terribly thread safe and it's not necessary to be a global so
let's just move this to a local variable instead. This saves space in
the symtab and actually reduces kernel image size because the regmap
config is large and we can replace the initialization of that structure
with a memset and a few member assignments.

Cc: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/llcc-slice.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
index 4a6111635f82..50aea3f0be41 100644
--- a/drivers/soc/qcom/llcc-slice.c
+++ b/drivers/soc/qcom/llcc-slice.c
@@ -48,13 +48,6 @@
 
 static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
 
-static struct regmap_config llcc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.fast_io = true,
-};
-
 /**
  * llcc_slice_getd - get llcc slice descriptor
  * @uid: usecase_id for the client
@@ -314,6 +307,12 @@ static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
 {
 	struct resource *res;
 	void __iomem *base;
+	struct regmap_config llcc_regmap_config = {
+		.reg_bits = 32,
+		.reg_stride = 4,
+		.val_bits = 32,
+		.fast_io = true,
+	};
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
 	if (!res)
-- 
Sent by a computer through tubes

