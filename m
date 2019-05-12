Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D225A1ADF1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 21:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfELTjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 15:39:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40163 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfELTjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 15:39:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id h11so11620148wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1xqj/Zo3AUFkVy0zRgFkVBz4uDdS8LIxp09mdTlXIys=;
        b=P1GAUOYh6F5NDr6P/o2VZYBMKNU69JrmKXjrv0mJrQkAzO5Gr2ZqK2J5fTuim4vqug
         4fAfYWtolMpC1tPgmmCeJglHw1ly3XD42CqglWnjR0o6WnnBX7XK/OJ2Rog1OXts6Djj
         MNiT9SsNubOhKeCkH0Y354TJDzax+BPcAScpczaUsvHB2Fj04fBNbHVB2IRxuctX1jYv
         7R6bKG3KsE9L5q5frbaVkYqo01SIA+WhGqv/dFkPRShaJvcjBQfrF+9iHUbERptfJUgv
         p7sGaWqgfX9vK+od4cEAWG+x2fOZZnFDs2SkKhn7wxelYRAIoQnuXOIO9/k+ab5SZ3Tg
         X6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1xqj/Zo3AUFkVy0zRgFkVBz4uDdS8LIxp09mdTlXIys=;
        b=b1XT1KFbWOQpL++P8p/N8gu8ksWyP84WxLA+UAqp7882o3kujlkkWuziYcJ4GjfVr/
         TUMRMWppxPYokwH/Fd59RXnb30gOFHmSBPa2wCSbi5YHRO2AlvUmTY42aO69ibThzurS
         cP2dgkTaxsNIJnA9d66artJKe+spgncDpx/IT/+7u+m+tvh/clSqlOZb/9zGkbU0LR2k
         dw+fcLaKPhUJlv5jThL7xeFNSsM9Fk2/NJBw3qg0+Ev6rFUWfG/1ZUAnzeeZ82eCvuP7
         61yKEnwondpygMvLGNfmgC031qF7jDyNn4QsD1llEBucEEk4TNHIEXO0PnkjyOCb/Vxv
         vtKA==
X-Gm-Message-State: APjAAAWvmzlhjVNXo8Iqv/hO7teXVGqhZES+VbGemjmVunaCVCt9rUfC
        RbK8eHIFMY3zbMefWA8auMo=
X-Google-Smtp-Source: APXvYqyKsuCV1ihDzofQdBkbz/XAwhXROCx9jK/t1SKZit6sN6YlPxvB7us/FY/5Si4I7kbAyR9Omg==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr13877489wmc.36.1557689983139;
        Sun, 12 May 2019 12:39:43 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD00ECBE9107EA8EB108.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:ecbe:9107:ea8e:b108])
        by smtp.googlemail.com with ESMTPSA id c9sm8127719wrv.62.2019.05.12.12.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 12:39:42 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     khilman@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] ARM: dts: meson8b: fix the operating voltage of the Mali GPU
Date:   Sun, 12 May 2019 21:39:36 +0200
Message-Id: <20190512193936.26557-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190512193936.26557-1-martin.blumenstingl@googlemail.com>
References: <20190512193936.26557-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic's vendor kernel defines an OPP for the GPU on Meson8b boards
with a voltage of 1.15V. It turns out that the vendor kernel relies on
the bootloader to set up the voltage. The bootloader however sets a
fixed voltage of 1.10V.

Amlogic's patched u-boot sources (uboot-2015-01-15-23a3562521) confirm
this:
$ grep -oiE "VDD(EE|AO)_VOLTAGE[ ]+[0-9]+" board/amlogic/configs/m8b_*
  board/amlogic/configs/m8b_m100_v1.h:VDDAO_VOLTAGE            1100
  board/amlogic/configs/m8b_m101_v1.h:VDDAO_VOLTAGE            1100
  board/amlogic/configs/m8b_m102_v1.h:VDDAO_VOLTAGE            1100
  board/amlogic/configs/m8b_m200_v1.h:VDDAO_VOLTAGE            1100
  board/amlogic/configs/m8b_m201_v1.h:VDDEE_VOLTAGE            1100
  board/amlogic/configs/m8b_m201_v1.h:VDDEE_VOLTAGE            1100
  board/amlogic/configs/m8b_m202_v1.h:VDDEE_VOLTAGE            1100

Another hint at this is the VDDEE voltage on the EC-100 and Odroid-C1
boards. The VDDEE regulator supplies the Mali GPU. It's basically a copy
of the VCCK (CPU supply) which means it's limited to 0.86V to 1.14V.

Update the operating voltage of the Mali GPU on Meson8b to 1.10V so it
matches with what the vendor u-boot sets.

Fixes: c3ea80b6138cae ("ARM: dts: meson8b: add the Mali-450 MP2 GPU")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 4b919590dae5..ec67f49116d9 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -163,23 +163,23 @@
 
 		opp-255000000 {
 			opp-hz = /bits/ 64 <255000000>;
-			opp-microvolt = <1150000>;
+			opp-microvolt = <1100000>;
 		};
 		opp-364300000 {
 			opp-hz = /bits/ 64 <364300000>;
-			opp-microvolt = <1150000>;
+			opp-microvolt = <1100000>;
 		};
 		opp-425000000 {
 			opp-hz = /bits/ 64 <425000000>;
-			opp-microvolt = <1150000>;
+			opp-microvolt = <1100000>;
 		};
 		opp-510000000 {
 			opp-hz = /bits/ 64 <510000000>;
-			opp-microvolt = <1150000>;
+			opp-microvolt = <1100000>;
 		};
 		opp-637500000 {
 			opp-hz = /bits/ 64 <637500000>;
-			opp-microvolt = <1150000>;
+			opp-microvolt = <1100000>;
 			turbo-mode;
 		};
 	};
-- 
2.21.0

