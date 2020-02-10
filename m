Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21DDC15730B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 11:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgBJKvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 05:51:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36371 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJKvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:51:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id 185so3540934pfv.3;
        Mon, 10 Feb 2020 02:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QBNYByC51okZLquqQezYQbeXlL8xTAzZxOhffPmc4pU=;
        b=AmPIPB4vqGUWQHShGxgXUnHutULTZOq82V7KIScQTXR7eIg7LOK7zL5FfO/1gxyd3t
         nZaZ9zpKUHUQh7P3bAE/tHPJYrpzWKg1uRdhh9URybxuq2/d+71r7WTpmFGsZTHhux26
         Cv1WbiIukFUAIPttpyQPOBbgSFecThkKsGN9G2oomkpdns88YR3RIkU8K5C0Nn/8TdOC
         jAuO+2g6O9kinaF12dMwrtyGSckbwAd32hC/b/xP12Qw+OUtmRthixvt/IPr0Najt9lA
         7Y5ivFBdlMQmYMAUk1WPhRGUF3vA6aqfoUB+nSlrw+19jF73jed0QI7QVorldTUkczYk
         S17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QBNYByC51okZLquqQezYQbeXlL8xTAzZxOhffPmc4pU=;
        b=UKJCg0c/Z3uuu2GRON10r/7YhHtuv2gIn75pEROsSHOOwePPTTmDT7PGzP01Lso28A
         zdYIL6ulSLjIvfZCLe1VsA+I/L5zyLbhETCmAWhhjLsWdcY2m728JeK9iRha//zyP/KQ
         rO0EZmfeWkoKZ/23J6JHO6JRRGWB8KyADShS2rRz1KRQ2Z41YxJ4+qKYhwLErwQM0zkl
         rr6DhSOfDGt3Om/Pi59x9KjdBUmfWXZBwNYM8eNpshI89nww/hEfeUEsXW37bZrvmYID
         GgGe3DXuQUwSglQOpGbXRyHf09/mrKHYVnitwwsAnR5E2iVkxMq+MtoydxEsihq4D3p8
         1A/A==
X-Gm-Message-State: APjAAAVcEJE5rKo4i9Evx5v+zq4fYQLp8UXXzFM4UvU8PHe3Yg1pH7jE
        z4/keRTFaRPsoCja+0j3kbuyACY2
X-Google-Smtp-Source: APXvYqyoeGjEc2VAonS90ocBj+wUmSedrbUGJzgkXzQU68mZPb95iMTmMSkGzC2ygPB65E9GeFIn8g==
X-Received: by 2002:a63:2701:: with SMTP id n1mr1042924pgn.332.1581331882159;
        Mon, 10 Feb 2020 02:51:22 -0800 (PST)
Received: from localhost.localdomain ([45.114.62.33])
        by smtp.gmail.com with ESMTPSA id g18sm12104833pfi.80.2020.02.10.02.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 02:51:21 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3 1/3] devicetree: bindings: exynos: Add new compatible for Exynos5420 dwc3 clocks support
Date:   Mon, 10 Feb 2020 10:51:06 +0000
Message-Id: <20200210105108.1128-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210105108.1128-1-linux.amoon@gmail.com>
References: <20200210105108.1128-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the new compatible string for Exynos5422 DWC3
to support enable/disable of core and suspend clk by DWC3 driver.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 Documentation/devicetree/bindings/usb/exynos-usb.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
index 66c394f9e11f..6d27f4c0e5a2 100644
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
-- 
2.25.0

