Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72922135AD7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 15:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbgAIOCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 09:02:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35187 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731416AbgAIOCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:02:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so7529021wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ez/V5Sramq36JD+7yzUO8B3/5yvtgJXa0dIlo6f2ItU=;
        b=EFYCDlevIXgpVzJz4R0vNmH7DhbH9kIJsZrFuM8/EGloTmw4G51U6vBlFjizcMqdp5
         eXE/k2nuFbYPkhfkZAmVNOas6cvS+d3xn046VK8Zm0Hr5D9o5tw9YiparHlfmSSMX3Ru
         MbLFw/VWQXeBCrqF7dhfYutS1TeqQvuT5d8+T6dRoSzSqgc3/A3Pm9Tb/udfvvLQx9cd
         wWE7azOdAtASGZ5U+TcGAjDTiZ46kDmV5y3P2Q5YOmkUKJFzdEab38TPDtuBnonlGBiF
         vV8fxRZXy1xOwpi0WsOMWTchey6/mLVCqslaXN1z2QuvYxSS0K5hJ0vk6aA/Bj9RY8TL
         E+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ez/V5Sramq36JD+7yzUO8B3/5yvtgJXa0dIlo6f2ItU=;
        b=CjZLOzZAQLpOfo5f9Yct728hM5A/urAaVSQtZLlT2mBcG8OvlWUuprnF0L6f6EHbQT
         gdNqp1/WxMcncivyCyN1mYJvLNYIU3v76zeX/Ypoe4QZHHRnYSzHuxOLF73U9UHUlbei
         watX70X4QtIiFMSfxwCWs6iYPGjBKFLo++RKlIUKQN/XyVSOIBN2TYd96aLsJB3GerSa
         NUv4GIic9pygZouwmoA8xhnTvkPSziuMJP5a3Vn+jjrddBx7bGlu54xJory1kXcn03Pj
         BZ4md7D30RSAF8GIz7IVgut3uj9WAjRSP2ZARv0JZYOL4CpkbYX7rDMBWtbOD9+G8Xns
         RDaA==
X-Gm-Message-State: APjAAAXj6HJWv5qfDdKGXmrmsWTQn6FtyVi77H3FxKiGudefP1gjsXNV
        B+MlumqPkhz1lm7eX1Wa6R05oQ==
X-Google-Smtp-Source: APXvYqw6HVDuyWkxIk5uXvziv2DcUCruYqlTANAD6f65eSIQoA3TjF3BpeT5qPb5pvn++Fps3wMNKw==
X-Received: by 2002:adf:e58d:: with SMTP id l13mr10729797wrm.135.1578578551968;
        Thu, 09 Jan 2020 06:02:31 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a1sm2898183wmj.40.2020.01.09.06.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 06:02:31 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] arm64: zynqmp: Add label property to all ina226 on zcu111
Date:   Thu,  9 Jan 2020 15:02:17 +0100
Message-Id: <cea6018dfc41c5704c24c14abcc383eee7d3b5aa.1578578535.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1578578535.git.michal.simek@xilinx.com>
References: <cover.1578578535.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Label property is adding capability to distiguish chips from each other
when iio framework is used.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index df2bc5a41c8d..2e92634c77f9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -212,84 +212,98 @@ i2c@0 {
 			u67: ina226@40 { /* u67 */
 				compatible = "ti,ina226";
 				#io-channel-cells = <1>;
+				label = "ina226-u67";
 				reg = <0x40>;
 				shunt-resistor = <2000>;
 			};
 			u59: ina226@41 { /* u59 */
 				compatible = "ti,ina226";
 				#io-channel-cells = <1>;
+				label = "ina226-u59";
 				reg = <0x41>;
 				shunt-resistor = <5000>;
 			};
 			u61: ina226@42 { /* u61 */
 				compatible = "ti,ina226";
 				#io-channel-cells = <1>;
+				label = "ina226-u61";
 				reg = <0x42>;
 				shunt-resistor = <5000>;
 			};
 			u60: ina226@43 { /* u60 */
 				compatible = "ti,ina226";
 				#io-channel-cells = <1>;
+				label = "ina226-u60";
 				reg = <0x43>;
 				shunt-resistor = <5000>;
 			};
 			u64: ina226@45 { /* u64 */
 				compatible = "ti,ina226";
 				#io-channel-cells = <1>;
+				label = "ina226-u64";
 				reg = <0x45>;
 				shunt-resistor = <5000>;
 			};
 			u69: ina226@46 { /* u69 */
 				compatible = "ti,ina226";
 				#io-channel-cells = <1>;
+				label = "ina226-u69";
 				reg = <0x46>;
 				shunt-resistor = <2000>;
 			};
 			u66: ina226@47 { /* u66 */
 				compatible = "ti,ina226";
 				#io-channel-cells = <1>;
+				label = "ina226-u66";
 				reg = <0x47>;
 				shunt-resistor = <5000>;
 			};
 			u65: ina226@48 { /* u65 */
 				compatible = "ti,ina226";
 				#io-channel-cells = <1>;
+				label = "ina226-u65";
 				reg = <0x48>;
 				shunt-resistor = <5000>;
 			};
 			u63: ina226@49 { /* u63 */
 				compatible = "ti,ina226";
 				#io-channel-cells = <1>;
+				label = "ina226-u63";
 				reg = <0x49>;
 				shunt-resistor = <5000>;
 			};
 			u3: ina226@4a { /* u3 */
 				compatible = "ti,ina226";
 				#io-channel-cells = <1>;
+				label = "ina226-u3";
 				reg = <0x4a>;
 				shunt-resistor = <5000>;
 			};
 			u71: ina226@4b { /* u71 */
 				compatible = "ti,ina226";
 				#io-channel-cells = <1>;
+				label = "ina226-u71";
 				reg = <0x4b>;
 				shunt-resistor = <5000>;
 			};
 			u77: ina226@4c { /* u77 */
 				compatible = "ti,ina226";
 				#io-channel-cells = <1>;
+				label = "ina226-u77";
 				reg = <0x4c>;
 				shunt-resistor = <5000>;
 			};
 			u73: ina226@4d { /* u73 */
 				compatible = "ti,ina226";
 				#io-channel-cells = <1>;
+				label = "ina226-u73";
 				reg = <0x4d>;
 				shunt-resistor = <5000>;
 			};
 			u79: ina226@4e { /* u79 */
 				compatible = "ti,ina226";
 				#io-channel-cells = <1>;
+				label = "ina226-u79";
 				reg = <0x4e>;
 				shunt-resistor = <5000>;
 			};
-- 
2.24.0

