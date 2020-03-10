Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A775218086D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 20:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgCJTta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 15:49:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43033 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCJTt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:49:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id c144so6973584pfb.10;
        Tue, 10 Mar 2020 12:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7SlQ0bsHgZszwUhHBadIYsQ2+v9rQS255Bp3qcZsTY=;
        b=TMgpPbxw0ko1PC3JxLulVtx+EOtLWWSi8eXOYfPX2GTCpCdg/2lBdl98IKRRz0wAl9
         IoedTvSKkzCXBvqx5h1q3KndXz802MaIrSE9GolGUs+oSaC9vCe1dRkMUzq2axRyiJnX
         j+oXEAIEvIAKugR+isAITSQIptoiGEUUg3W7bjQJrqoHScpWtGRl/f2HSEN3u3/eWRDx
         ZkbrwCYemc7nuKSphAFtpDszAPf9sjlfhfRnnS1VNTNb/B4WuuxClKLMVnf96/w2CBFU
         Y2XKEeI/nwSLzWsq0Otj1JC28ETShWQNQuHb/V6u9uAmFkZASm/IaXpqIKYzDrPqqAY5
         SzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7SlQ0bsHgZszwUhHBadIYsQ2+v9rQS255Bp3qcZsTY=;
        b=symvPdsC2NFHNooUAwKkVT1Lzlj9kIXuCatfudc3eymBQJtfz7MAQlkDfZh4CaS2B+
         co5FThAzOfWBElZQOd4ZKpMeYMjLqsfpK0csCmoHzhxxSXO3sCJUkgKyyI5gkURIcGZn
         XrxGMSmRV3XGxo/oUDsXNTU1GftUw4/2pd52HE+TQJtV1ImDUOvlRsqMmJP/whue+CFW
         MXqdTV88Qh7RvdTnoO2bT09fYiGSUeX79zZ5MUY6WMqIgZ5L0NsFT795/IkQNQKFTf8j
         2E9A2EKB2w8DSxgPCyhaECeqriliQVppucmx11ZN8JrMBrNrL/2SlPn0c2RmyNyY42yp
         d8YA==
X-Gm-Message-State: ANhLgQ2VJ1t6GUtMUXJIxaDzYWrS7cy3JEExgXVVuxBJ3IkbbHSgEgqU
        oao9HAZf0rgDRggPddzAvlMNrnjE
X-Google-Smtp-Source: ADFU+vsX0s58xHBrZiNWhQNZ4+BYI9nXUKflY0WKkor13fnLHK+tPp5d03Uw5SXrCIjLbznhdB/0EA==
X-Received: by 2002:a62:880f:: with SMTP id l15mr3796070pfd.218.1583869768082;
        Tue, 10 Mar 2020 12:49:28 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.228])
        by smtp.gmail.com with ESMTPSA id d19sm3784490pfd.82.2020.03.10.12.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:49:27 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCHv3 1/5] devicetree: bindings: exynos: Add new compatible for Exynos5420 dwc3 clocks support
Date:   Tue, 10 Mar 2020 19:48:50 +0000
Message-Id: <20200310194854.831-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310194854.831-1-linux.amoon@gmail.com>
References: <20200310194854.831-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new compatible string for Exynos5422 DWC3 to support
enable/disable of core and suspend clk by DWC3 driver.
Also updated the clock names for compatible samsung,exynos5420-dwusb3.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 Documentation/devicetree/bindings/usb/exynos-usb.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
index 6aae1544f240..220f729ac8eb 100644
--- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
+++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
@@ -69,7 +69,9 @@ DWC3
 Required properties:
  - compatible: should be one of the following -
 	       "samsung,exynos5250-dwusb3": for USB 3.0 DWC3 controller on
-					    Exynos5250/5420.
+					    Exynos5250.
+	       "samsung,exynos5420-dwusb3": for USB 3.0 DWC3 controller on
+					    Exynos5420.
 	       "samsung,exynos5433-dwusb3": for USB 3.0 DWC3 controller on
 					    Exynos5433.
 	       "samsung,exynos7-dwusb3": for USB 3.0 DWC3 controller on Exynos7.
@@ -82,6 +84,7 @@ Required properties:
                 Following clock names shall be provided for different
                 compatibles:
                  - samsung,exynos5250-dwusb3: "usbdrd30",
+                 - samsung,exynos5420-dwusb3: "usbdrd30", "usbdrd30_susp_clk",
                  - samsung,exynos5433-dwusb3: "aclk", "susp_clk", "pipe_pclk",
                                               "phyclk",
                  - samsung,exynos7-dwusb3: "usbdrd30", "usbdrd30_susp_clk",
-- 
2.25.1

