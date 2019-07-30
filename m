Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E887B176
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbfG3SQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:16:48 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:43291 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388082AbfG3SQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:36 -0400
Received: by mail-pg1-f180.google.com with SMTP id r22so2876814pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5gRGcWyOXjbGvRD/Ia/ZjoEGmB7+jcrN43v6hTE2Yg=;
        b=BmGCMhMr3htSVdCqe4DcrO/jLeaUhev2FI768Zzu7ocmA58O6mCm8OuKSHpoERKYFH
         zh+o3Ch8+lbpGv1psYEFLvsHKkh5VrDsPtruV7orMHSXrF4CiPGyVaf8E5N/vmAKvMA0
         Q0oW7U4es72VRlSz3SEvU3+zRkCF3/fI8WFg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5gRGcWyOXjbGvRD/Ia/ZjoEGmB7+jcrN43v6hTE2Yg=;
        b=M/G60QD094QKnA0BCoLqnrUA+cjtNzKeXP8NiUwUbKQfncQBnyPPZm662fKPdhFns0
         WFUOTVzcD3mAl8JrZLV0NOvVEfUtj2vV3xpA3i9IDKJtfw7SbclHvruH/X3b7YYMO8ro
         1hWsgkAv18MWBPwto/kjUcEVuDgaOpyQ/44yleZ0GbFWotgTigmJwSNteecEX1t2i2f8
         MyCi6e5LSDviAiVByJ0i4C6IF8n2DAPpdTbvPZ7Pd+O7fk3WOHZW4BE0zJwqodaLQiTY
         dyPloCFPsKcBO6JwDq9LZUkxIt7Yf22o1hIWJzQ7XmRdxqFK9WdXEP2lXvd/0vS8lx7m
         QvNw==
X-Gm-Message-State: APjAAAWQXKtD90kaPMoQ3kdSdR4fGo4lVmVvnmgm3fgPBFR3oQYgWzW8
        jVH7P+EtOnSzdxP7OhZPQSuc/ugEo2ByWA==
X-Google-Smtp-Source: APXvYqzebXxvxd/GTr2c5CRuMcT9T2IW7k8OMb0r9zVlbWH0p/V4EwDcjQ1YOYAU0IBs47wx/VIpvA==
X-Received: by 2002:a17:90b:f12:: with SMTP id br18mr113290820pjb.127.1564510595565;
        Tue, 30 Jul 2019 11:16:35 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:35 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 45/57] uio: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:45 -0700
Message-Id: <20190730181557.90391-46-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/uio/uio_dmem_genirq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index f32cef94aa82..ebcf1434e296 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -200,10 +200,8 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 
 	if (!uioinfo->irq) {
 		ret = platform_get_irq(pdev, 0);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to get IRQ\n");
+		if (ret < 0)
 			goto bad1;
-		}
 		uioinfo->irq = ret;
 	}
 	uiomem = &uioinfo->mem[0];
-- 
Sent by a computer through tubes

