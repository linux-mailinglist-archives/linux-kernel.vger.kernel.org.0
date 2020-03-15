Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB35E185D5D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 15:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgCOOGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 10:06:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36486 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbgCOOGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 10:06:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id z4so2260391pgu.3;
        Sun, 15 Mar 2020 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KoDzKzTJ/RhQEVM8AR3TnFL37SwdP66Jc4nSkLB9Rg=;
        b=QtK/IMCoFPirrqAqgZIQFECGWUXVcv49njtBVLg/kFW1DDcaGTXWc6YyYtmX8lNZ2f
         lfKLyRQqDOvn3u1lpOFUbf1XjyTmAilemOxXD8pm8VSlE6vymiMYeHKGexXBrvn/mazM
         ve/SoNGZVHsoHVjTq1RSXtyEbF40FGYILg7eYrmQX1QZlAIREZK53KToPgCAjk1OSctF
         iot4UrfBBXAmeuz6gcQNiCWSnoaoQ4n154WAXKYX2Qmrn50IAj6/LWIffMFK4b/6vDj1
         KClu04U4jqWVXKq1Q7kz/GUXU9XeY/1BN7f+qzqPf0zid7kVzy7quZcPzx3i+d3oH+c4
         2qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KoDzKzTJ/RhQEVM8AR3TnFL37SwdP66Jc4nSkLB9Rg=;
        b=UY7keN9rtYZRSZ3y0jc/W2yvVn6kOViNQDNLMrdnWCx4Mm1WhXseMDMjMlIivBxovJ
         36Ecrd8+VwMqGtH/NaSxov6Bc++Ub8atL2ICwWgEk3A3Ymev5EoGFCtxvjYUNBML27vI
         EBBwjizR7xQiSkBlcUb2PP0HTkc5pifEcIphtcioa0MC385zeDcWN3CBwmVsq3f1rBeJ
         NF6iE0gz1y7zVlN9Hv+Xlc8kPYz4btgCyhxWBeFPMV30HRutYxZAZN0I8ATO0+z1J4b5
         MGbZODTCo2w7Owru8H1OfwbyGtWGgFsH3h+Vg3oe7UTjOhCvPSapqEPbPDm62MnPaHyT
         NpSw==
X-Gm-Message-State: ANhLgQ0RCqnMWAirB8T/zCRK/eLjEq9+wp7lfSzXuwI0q2erXIXSUE0d
        JMK2o8O3GqQRcrk2emBfClw=
X-Google-Smtp-Source: ADFU+vv7HnMCncwCL++7z3PEppaS2b5DxX8EG+D4N1W0mQt2ckBTiFQ0mGwM2uHV7m1WNxEha2AlFg==
X-Received: by 2002:a63:1b22:: with SMTP id b34mr21857698pgb.415.1584281158350;
        Sun, 15 Mar 2020 07:05:58 -0700 (PDT)
Received: from localhost (216.24.188.11.16clouds.com. [216.24.188.11])
        by smtp.gmail.com with ESMTPSA id c190sm24066567pfa.66.2020.03.15.07.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 07:05:58 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        jeffrey.t.kirsher@intel.com, hdegoede@redhat.com,
        treding@nvidia.com, tglx@linutronix.de, tomas.winkler@intel.com,
        suzuki.poulose@arm.com, sergei.shtylyov@cogentembedded.com,
        geert@linux-m68k.org, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v3 5/5] driver core: platform: Reimplement devm_platform_ioremap_resource
Date:   Sun, 15 Mar 2020 22:05:25 +0800
Message-Id: <20200315140525.21780-6-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200315140525.21780-1-zhengdejin5@gmail.com>
References: <20200315140525.21780-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reimplement devm_platform_ioremap_resource() by calling
devm_platform_ioremap_and_get_resource() with res = NULL for
simplify the code.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v2 -> v3:
	- add this patch to simplify the code by Geert's suggestion.

 drivers/base/platform.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 9f6a78f79235..b83b789c8e34 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -95,10 +95,7 @@ EXPORT_SYMBOL_GPL(devm_platform_get_and_ioremap_resource);
 void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 					     unsigned int index)
 {
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
-	return devm_ioremap_resource(&pdev->dev, res);
+	return devm_platform_get_and_ioremap_resource(pdev, index, NULL);
 }
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
 
-- 
2.25.0

