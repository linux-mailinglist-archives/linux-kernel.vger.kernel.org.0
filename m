Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB4D17B112
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 23:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCEWAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 17:00:41 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40091 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgCEWAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:00:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so3211891plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWqPL9ibbKXWR51v31XcIk5pftgYa/pcecnYKmVCJAo=;
        b=vgs6VA4Ql2ehQpGwP8xBKZROXMa5jcdTZK1TIb0ab24I+jDsExL8ZmDvNIuybugniE
         DZcAJu/WO4PgnreJF8GnmOkpBHHf/2MgEqTfLExY/ma4eeX5bMGhbZGvsSTAqQ41fT6J
         jXAuss2M3riFwEDM2rF3CmGX6LgsuqZh5SgJ1xG/Pmgz/ZZ6HaQ4eFy05e2vkCkjv4Yq
         dTXBQaMix+Bp8sO8jX9pQjP8FbCbvP51flZytpVczO3yy/3YfKogoFSdWQH5VxcRsrHH
         55Y/gtMYmsHXp69C6xUFVRulATIXdQQpWz5dU2DSUtvaOV5EjN2qb1u9JyioW5B0VQ5n
         vmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWqPL9ibbKXWR51v31XcIk5pftgYa/pcecnYKmVCJAo=;
        b=gOLZM0C7LsVtWlcg9YrzFru5dCj58sxw5WAfuGHDus7gzMo2ZCV5hY2rOmlAhwIKYF
         xYc1mcIjUi3K+SOaaj7HZP7hrHcdZ2/0AMiXM9PvCtR2iTUb9Kyy2Z0xklP1qFWhY+Q+
         GS+qTI7Kzw0/qOXtKtWXaFk6JbR0n/h9dkk2/gU1Ze2HTW/y6ys4O5Q+j6bd+Tx6zDA4
         x0jXPr/13LR5U1h67gjPmX8g1UQ857FSUdVHFiaTcm9rtIG6NHcKi7EBpvXhuGLmYH8L
         ngzF13EH3XwzIo0U3gxxG/+nsxLEXR5Tm4rLjcSif68Bu0RFG9R7wq42THhAWvPslpIe
         I+iw==
X-Gm-Message-State: ANhLgQ3AhmmeeEquI39+Khjm+bX8jwb3dv8MWdG7cr4lbE2B1LM766rA
        dCkaQAx7+h/q1k4tpP73FcYkgSHPUUQ=
X-Google-Smtp-Source: ADFU+vvVpe3cKKDK1pzFwqfUyVxO1sV0ARtSLXgu+fL4G8UfhprencLvX4yTQkw0MS1d4TaZgJF8HA==
X-Received: by 2002:a17:902:868d:: with SMTP id g13mr192450plo.36.1583445637762;
        Thu, 05 Mar 2020 14:00:37 -0800 (PST)
Received: from localhost ([103.195.202.232])
        by smtp.gmail.com with ESMTPSA id g11sm4755331pfo.184.2020.03.05.14.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 14:00:36 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v1 4/4] arm64: dts: marvell: Fix cpu compatible for AP807-quad
Date:   Fri,  6 Mar 2020 03:30:15 +0530
Message-Id: <2f56a89b8f88583b60446050efc523a781556e3a.1583445235.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583445235.git.amit.kucheria@linaro.org>
References: <cover.1583445235.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make -k ARCH=arm64 dtbs_check shows the following errors. Fix them by
removing the "arm,armv8" compatible.

/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
cpu@0: compatible: Additional items are not allowed ('arm,armv8' was
unexpected)
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
cpu@0: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long CHECK
arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dt.yaml
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
cpu@1: compatible: Additional items are not allowed ('arm,armv8' was
unexpected)
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
cpu@1: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
cpu@100: compatible: Additional items are not allowed ('arm,armv8' was
unexpected)
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
cpu@100: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
cpu@101: compatible: Additional items are not allowed ('arm,armv8' was
unexpected)
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
cpu@101: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long

/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
cpu@0: compatible: Additional items are not allowed ('arm,armv8' was
unexpected)
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
cpu@0: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
cpu@1: compatible: Additional items are not allowed ('arm,armv8' was
unexpected)
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
cpu@1: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
cpu@100: compatible: Additional items are not allowed ('arm,armv8' was
unexpected)
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
cpu@100: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
cpu@101: compatible: Additional items are not allowed ('arm,armv8' was
unexpected)
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
cpu@101: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long

/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
cpu@0: compatible: Additional items are not allowed ('arm,armv8' was
unexpected)
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
cpu@0: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
cpu@1: compatible: Additional items are not allowed ('arm,armv8' was
unexpected)
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
cpu@1: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
cpu@100: compatible: Additional items are not allowed ('arm,armv8' was
unexpected)
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
cpu@100: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
cpu@101: compatible: Additional items are not allowed ('arm,armv8' was
unexpected)
/home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
cpu@101: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi
index 840466e143b47..68782f161f122 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi
@@ -17,7 +17,7 @@
 
 		cpu0: cpu@0 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a72", "arm,armv8";
+			compatible = "arm,cortex-a72";
 			reg = <0x000>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
@@ -32,7 +32,7 @@
 		};
 		cpu1: cpu@1 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a72", "arm,armv8";
+			compatible = "arm,cortex-a72";
 			reg = <0x001>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
@@ -47,7 +47,7 @@
 		};
 		cpu2: cpu@100 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a72", "arm,armv8";
+			compatible = "arm,cortex-a72";
 			reg = <0x100>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
@@ -62,7 +62,7 @@
 		};
 		cpu3: cpu@101 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a72", "arm,armv8";
+			compatible = "arm,cortex-a72";
 			reg = <0x101>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
-- 
2.20.1

