Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 872A921DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 20:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfEQSrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 14:47:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55459 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfEQSrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:47:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id x64so7834283wmb.5;
        Fri, 17 May 2019 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Btaw5CgxhYac28zaC8EYgFvIIeyjC0ToJx7hPAKP9QY=;
        b=rvS8TdrrNuTuTAczO/sCk3JYQDiJx2zGD/6UYxqHovGm+wntVw99HRWQrWG6B6Ziup
         +eXBKtuGsJr+1pfo0wvcjK1XPoXYQOKCCDRzcSdX5Gf0G5QudaJLmAM75dro9XSfdJ9z
         UnFgsYIydmslSPMlnICV/EntlzRoteVF2Kb6B8hzHgbAI0HDkqV49pbgIrvE4Nj5R9xl
         ZKlpEyQF8ZMmSe/S6bFlC3qhXjP35nbVs8HjS0qO5AjAfWaUItFmW57IEcjJ3f1i9tio
         voD5XCP+9ELMbiBE9y+JLbCsYS1gHbGHQlmp7euB2Mp1d3Dal57AFoAqLOoXfHV3Myyh
         Ya5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Btaw5CgxhYac28zaC8EYgFvIIeyjC0ToJx7hPAKP9QY=;
        b=J5SgBN+2JguE/MmeRk5PJibJ2B2ZnBbvL5ib+kH8Dv8GodHVB8nzNyoO+WRMXNpJ9J
         YolMJ6ddEhuYCP83q92KzuESR62DKE5B7GslpEwKFNtU9Q8GaTNWDPqITaZJxC5D5b8O
         DA7ANznpFlywAbkTzjCvxjMfjKf0bSbFqzpYnsblIIOWShcSzLy+NPc7ndLpUE2A6O4i
         ofmUlvKysxh6Q+OX27gg0uC8h+9WyUqUVl5Zp0VPMufDbXsaU8CYCoaJ57sHWVhRk6mV
         +rnuhdZEZqR+DiJRWEup0dgkjiG4/s4/8GAdHNrUl7bsRTZC8c/mm0I/ct4x0pt+cxsM
         pwAw==
X-Gm-Message-State: APjAAAWP8vFTqnA0c8ys/5hxsieDkPF6cS7B0JUms9tR3VoEHOOxdwTR
        HgV+WWp7BIfbaH9ZPxSK5T8=
X-Google-Smtp-Source: APXvYqzArrwsBcPq+tVBrTz90U11Q0am6+wnQ5F3p77yNdgZ3iQekw5aa3vsszJncLjFku7dlsgqUQ==
X-Received: by 2002:a1c:9616:: with SMTP id y22mr3268422wmd.73.1558118832056;
        Fri, 17 May 2019 11:47:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id v20sm5801112wmj.10.2019.05.17.11.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:47:11 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 5/6] arm64: dts: allwinner: Add ARM Mali GPU node for H6
Date:   Fri, 17 May 2019 20:46:58 +0200
Message-Id: <20190517184659.18828-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517184659.18828-1-peron.clem@gmail.com>
References: <20190517184659.18828-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mali gpu node to the H6 device-tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 16c5c3d0fd81..6aad06095c40 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -157,6 +157,20 @@
 			allwinner,sram = <&ve_sram 1>;
 		};
 
+		gpu: gpu@1800000 {
+			compatible = "allwinner,sun50i-h6-mali",
+				     "arm,mali-t720";
+			reg = <0x01800000 0x4000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "job", "mmu", "gpu";
+			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
+			clock-names = "core", "bus";
+			resets = <&ccu RST_BUS_GPU>;
+			status = "disabled";
+		};
+
 		syscon: syscon@3000000 {
 			compatible = "allwinner,sun50i-h6-system-control",
 				     "allwinner,sun50i-a64-system-control";
-- 
2.17.1

