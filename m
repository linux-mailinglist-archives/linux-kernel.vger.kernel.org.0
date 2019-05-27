Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E5C2B30A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 13:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfE0LQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 07:16:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38470 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfE0LQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:16:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id t5so15458112wmh.3;
        Mon, 27 May 2019 04:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IE0QaynMlWug2qNR46NtnCWHIB0RzkNO84JDp+YXRlk=;
        b=WWCRBfLXHGOwfH9Bz0XMS3YsDxSjIeSRx8cKi5IRGytXczDcD6hu7oSG1k7q/gaaQ8
         c65fxwdjDOgK4LGctIEtQYUo30bZ98akHa2NBiF5wdW/bIY7/yLl05YD6CNrmB0hIJ9l
         8seRZoEkcNICPC0HF0d2WajB8LL/EncHNXbmwarakyJyxlZX1CP5AksSw8eO6mqFVpd6
         /74D4rntZNZxWh7kUML8nTVtvKPT1G/xsCUPcmNguVGNsXt3uHXOtpOjbad09ZC2ztsq
         8jsF/5hM85lY21s2hrbTgvCdlLJDcLxKXHNGvR7rZIHamlv4zDwXc3xNsCTnLxWp5XzE
         hfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IE0QaynMlWug2qNR46NtnCWHIB0RzkNO84JDp+YXRlk=;
        b=q1V7f+f9QMWpAtDMkWEkjGbo7Di/h6wXdL4b2yasGWLlFX7DXaoy8hd5ftbh/L+ikA
         k/tpCVC6G8qBBntT5NT+05CbWTLehC+GUoHKWyj/snlnLfBTR0DMkCHqZQYtfYBrcsr1
         6yQvooeBOEf0h4v3YC+JqUmzO33EzL2osoU4DK67CRilFfLjqy13YoJaCa2lleTviqEL
         bN/A7FsilwYSJnmu136DUR2dVdSDmQKF/9oMRmUnPU9VfoBNEEM61LMcP2VLQwK+4Q8O
         SkwrS2m+oag70PnDcK6ivBWXaksdks1qVK3Qjc4OsizbeQjlozvlfwHuZIoSderEDviI
         0u3A==
X-Gm-Message-State: APjAAAV/AIO1JsG8g63FT6iaez9+1fBMsj57M+1APdrmdjNgtEOc5FVk
        G0tWWsYlTpUdp9gdmkj0ML0=
X-Google-Smtp-Source: APXvYqxWKajkKGi9hI6uCHALtxhUkAygj/1iJ3HJHI0+7l2OGrYh96kHaJME/r120zdqbRJxGHl71w==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr9361238wmg.159.1558955785132;
        Mon, 27 May 2019 04:16:25 -0700 (PDT)
Received: from localhost.localdomain (131.ip-164-132-48.eu. [164.132.48.131])
        by smtp.googlemail.com with ESMTPSA id b8sm3781578wrr.88.2019.05.27.04.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 04:16:24 -0700 (PDT)
From:   Tomasz Maciej Nowak <tmn505@gmail.com>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ellie Reeves <ellierevves@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: armada-3720-espressobin: correct spi node
Date:   Mon, 27 May 2019 13:16:14 +0200
Message-Id: <20190527111614.3694-1-tmn505@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The manufacturer of this board, ships it with various SPI NOR chips and
increments U-Boot bootloader version along the time. There is no way to
tell which is placed on the board since no revision bump takes place.
This creates two issues.

The first, cosmetic. Since the NOR chip may differ, there's message on
boot stating that kernel expected w25q32dw and found different one. To
correct this, remove optional device-specific compatible string. Being
here lets replace bogus "spi-flash" compatible string with proper one.

The second is linked to partitions layout, it changed after commit:
81e7251252 ("arm64: mvebu: config: move env to the end of the 4MB boot
device") in Marvells downstream U-Boot fork [1], shifting environment
location to the end of boot device. Since the new boards will have U-Boot
with this change, it'll lead to improper results writing or reading from
these partitions. We can't tell if users will update bootloader to recent
version provided on manufacturer website, so lets drop partitons layout.

1. https://github.com/MarvellEmbeddedProcessors/u-boot-marvell.git

Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>
---
 .../dts/marvell/armada-3720-espressobin.dts    | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 6be019e1888e..fbcf03f86c96 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -95,25 +95,9 @@
 
 	flash@0 {
 		reg = <0>;
-		compatible = "winbond,w25q32dw", "jedec,spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <104000000>;
 		m25p,fast-read;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition@0 {
-				label = "uboot";
-				reg = <0 0x180000>;
-			};
-
-			partition@180000 {
-				label = "ubootenv";
-				reg = <0x180000 0x10000>;
-			};
-		};
 	};
 };
 
-- 
2.21.0

