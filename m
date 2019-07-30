Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4EE7B1BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbfG3STx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:19:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33870 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387897AbfG3SQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so30263553pfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kDBEcnQJfsnw+mnIW0/b6FtORHu9LZqCk2VAafP4T0g=;
        b=EUVUdN1/7hvdK11XyCYMXsZEejo/CxmxXn4Y/wTf8+Uo7K6CAROlOtgLd26sAATKoV
         e1DcUT64uWeNCTsKxI1u9N29+I/X3eZBnaEEAVaDt0qCDVj7HgGZDC0k3TqWVlyMgQ+5
         yzTpfG4SOA1+CX3MBN4/B1TJpa8VV1k5EozbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kDBEcnQJfsnw+mnIW0/b6FtORHu9LZqCk2VAafP4T0g=;
        b=JcFNXnW14Fns6z3v0wPqqTe8a+Qinvvypthe3nU3vZFiNg2l5sbp1OVKGcefPbOdfO
         66CNU96xPyjuiteDEBbpS1Hp4nqDQTkq6m3IFFezwD0Ccdu5cxMIWQ3FSY1i4BkpQ/6S
         tQ4FXNjB9cIXm5bIsd+LJ6RLILNdAc9e8HpYOmQhrSJ9HTrz31Hu1RriIbrjJJWHH5qU
         dMC9cepRvRhlvzWkFTybCBLNr3427ytF9YjrYTBq+TwKQ7dKfqjLsH4c3E85TrTcSsDe
         EM3es3YLb6WWRn2fF1Xb+AS3EnSFA6rkHvXiCL9t4UdHB4ppwu16WS8EvPi5KUkTHc9f
         Rn2Q==
X-Gm-Message-State: APjAAAVL8rkqZWZCbPJ8I/oriO4bnCkV75p+KxQjHKSrSLkFIhjW9TuR
        TaR0WoenpdNQFfXQLg8DYXJm5isAtAo=
X-Google-Smtp-Source: APXvYqzu0Xs5GSslsQNll4ElHggYuH6Nv74MqChqVeexVNeRIb/yb4UL4y72L4llU+NELMP+k/XYFw==
X-Received: by 2002:a17:90a:9903:: with SMTP id b3mr117381729pjp.80.1564510577354;
        Tue, 30 Jul 2019 11:16:17 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:17 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 22/57] iommu: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:22 -0700
Message-Id: <20190730181557.90391-23-swboyd@chromium.org>
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

Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/iommu/exynos-iommu.c | 4 +---
 drivers/iommu/msm_iommu.c    | 1 -
 drivers/iommu/qcom_iommu.c   | 4 +---
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index b0c1e5f9daae..1934c16a5abc 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -583,10 +583,8 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 		return PTR_ERR(data->sfrbase);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "Unable to find IRQ resource\n");
+	if (irq <= 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,
 				dev_name(dev), data);
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index b25e2eb9e038..3df9266abe65 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -750,7 +750,6 @@ static int msm_iommu_probe(struct platform_device *pdev)
 
 	iommu->irq = platform_get_irq(pdev, 0);
 	if (iommu->irq < 0) {
-		dev_err(iommu->dev, "could not get iommu irq\n");
 		ret = -ENODEV;
 		goto fail;
 	}
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 34d0b9783b3e..fb45486c6d14 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -696,10 +696,8 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 		return PTR_ERR(ctx->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (irq < 0)
 		return -ENODEV;
-	}
 
 	/* clear IRQs before registering fault handler, just in case the
 	 * boot-loader left us a surprise:
-- 
Sent by a computer through tubes

