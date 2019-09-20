Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71072B9958
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 23:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbfITVxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 17:53:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43732 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfITVxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:53:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so3789262pld.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 14:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=VrMMAxmAWCoF+Z0mK+KREcF/roJedPfia4jPAm5aT6w=;
        b=hdTk7WbnOHXiUYbTZwim1OGeWK5A2LQE3v5T+TYfGXALHEHxrDwjzCh1hqE/ERTYgR
         FdTBcF6j5GvfHYhtuzgU4xG6Sdi0Sy9bTUp4XIvgqNqDSofcArTPULOTd4YlATbCQ2dy
         glTCi0fnP9Ou0ClR+6FkWVe76hx1AN/MdCwVLDtnfVN7qr1ag7U+i0PyqK9sIh/n/lIU
         KLYoRRjem3y9H0naE59MoURT6YLYgPoceEOSLTOCKfgWci2CSLlP0r1E5up2nMV9orSw
         QXuZsnzyROWpe/r8KrrBKnCTPZ1RjJJVWcbm1hV7Dg2es97kjX9AzZjxSm/XZi1kPnFX
         3Luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=VrMMAxmAWCoF+Z0mK+KREcF/roJedPfia4jPAm5aT6w=;
        b=jTLq6ks4KOyw8h0i+j6o5iBHi2MmOFoWLOCkCaSBa7YCnMurtUOpavwvnnxPvYfrYZ
         SxPpocllVCUQCRN+6eOgRW61maXV2SIWeIcEtQ7b8EMucE5VLzLU3jn4Zx7sO89ttZed
         pvI310In9emIjpAYI9ztRbEnTGoO1HDugXsieYDhQTXnnsjFW3xT1AWECTMmS9PNkiyG
         c+uXlnqyJN8Ce+iPWb+k54XSDqeP6DqRj0vPo0c+9GarVuGalQFAeKP47eFbPytlLheV
         3DlVIUvDmz3ewdt6YOC6U2WqdpTDg7I9FfxZ0W7yvpGImuBppVHt2FeYl47aGzw/kSj8
         6O3Q==
X-Gm-Message-State: APjAAAXPGm7y0eJ4au3c8UihU4qhrcTNHJtj7vK312rr1mmX/MTqCYXm
        EgQ5gFjq7b9KwJGW5WuBeDx/Dd1QTRfQnA==
X-Google-Smtp-Source: APXvYqxxt3Vokdo3rTZjJNHgc7wDhDM2N4L65qSbpGr0UPuV1inanDjg6Nu3bSQHqgtQHpxsxvDRsQ==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr18922218plb.286.1569016386832;
        Fri, 20 Sep 2019 14:53:06 -0700 (PDT)
Received: from localhost (wsip-98-175-107-49.sd.sd.cox.net. [98.175.107.49])
        by smtp.gmail.com with ESMTPSA id f6sm2910513pga.50.2019.09.20.14.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 14:53:06 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v4 12/15] arm: dts: msm8974: thermal: Add interrupt support
Date:   Fri, 20 Sep 2019 14:52:27 -0700
Message-Id: <12ce7db8f17cdaf8fef89ed7f1fce10f08acab57.1569015835.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register upper-lower interrupt for the tsens controller.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 36 +++++++++++++++--------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index d32f639505f1..290f7c3827d4 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -139,8 +139,8 @@
 
 	thermal-zones {
 		cpu-thermal0 {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 5>;
 
@@ -159,8 +159,8 @@
 		};
 
 		cpu-thermal1 {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 6>;
 
@@ -179,8 +179,8 @@
 		};
 
 		cpu-thermal2 {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 7>;
 
@@ -199,8 +199,8 @@
 		};
 
 		cpu-thermal3 {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 8>;
 
@@ -219,8 +219,8 @@
 		};
 
 		q6-dsp-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 1>;
 
@@ -234,8 +234,8 @@
 		};
 
 		modemtx-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 2>;
 
@@ -250,7 +250,7 @@
 
 		video-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <1000>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 3>;
 
@@ -279,8 +279,8 @@
 		};
 
 		gpu-thermal-top {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 9>;
 
@@ -294,8 +294,8 @@
 		};
 
 		gpu-thermal-bottom {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 10>;
 
@@ -531,6 +531,8 @@
 			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
 			nvmem-cell-names = "calib", "calib_backup";
 			#qcom,sensors = <11>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

