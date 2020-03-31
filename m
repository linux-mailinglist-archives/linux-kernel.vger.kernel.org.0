Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2892F19A1CD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 00:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbgCaWTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 18:19:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34618 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbgCaWTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:19:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id 65so28203028wrl.1;
        Tue, 31 Mar 2020 15:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UNPe3Sj9nisgX8TMQG4uvyThsRCvZnaiE/iNxuk8GJ8=;
        b=qrFz5M7Z6y0G8DwGgOPBaRfCA7u5c4Cdxtt9Lhv3B5gFQsQ7jGNHyGlT/aVlNc2R5t
         O/zt4WaLMU0nwnBZcvhJz49rQm9TsxnvQ3mHcWJfcuoMsZQWh/fGI22KdZip5hQjhaFS
         MopAMX8d3C49Qb7Uh8NdZfzxYNYdUrgwG+pL2SwI0VlFhouO89qZtDgM5FmVopdGibRQ
         xit0aUtMew7CL8y6w9uUkauAWFuoeg8hm3PXBcJhmj2vJ173ciED2KF3Zr5Kxc4d8+Ep
         NcuZuimmkrt2pjHzqD7pZLWBm3SPvWYXg4AT8VKTmu6Y+GlCabhlmvmJZupzxjlMCzqT
         Q76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UNPe3Sj9nisgX8TMQG4uvyThsRCvZnaiE/iNxuk8GJ8=;
        b=CNJ+Sw2vihIx/uCUrqF0kpXpDspd7k8Kqa/QegLUGj0UJtL7AfjKnTmV7JHEH9iqxJ
         fdQQgdX4rH4XFnFBF3DrRQHNStFjVsuWFcutNrMzKssbFSgzFPJp0l4feV4j0e0MiOQ2
         tY4BbvG7G/LXWI8l34m1c83s/U88h3sD8lYqyzEbjrVNxAdB1xUSXEOETKHjDz4Wvmv0
         oxw73NjTMElIkq7r9umGFPe4+wHnE835gvTn+1W/17AdT/Yuo+7aHNVcY14b5Xnh8xlP
         Z3nA5B5oF3yKhLmOkXiKYk6xhuAQQT4Q9/jnxqQ7yhN5SXzjtZ1UB8cUTL/e4uKeOZtN
         BIjQ==
X-Gm-Message-State: ANhLgQ2uFuCi98hjTbb209cgOsKpdu0Zvz5aCq0zsl8sE3UXm0p3QSi1
        WYK3pO1173D2l88stSxZMds=
X-Google-Smtp-Source: ADFU+vuYi0cP/6lLOYm4YxONdYB0ev0vaUIS/a2c2sxxas+tJIY5go+gkobqKGQbm6fqS/chr964rA==
X-Received: by 2002:adf:b307:: with SMTP id j7mr23741415wrd.128.1585693171030;
        Tue, 31 Mar 2020 15:19:31 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id i1sm140136wrq.89.2020.03.31.15.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:19:29 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] arm64: tegra: Add native timer support on Tegra186
Date:   Wed,  1 Apr 2020 00:19:11 +0200
Message-Id: <20200331221914.2966407-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331221914.2966407-1-thierry.reding@gmail.com>
References: <20200331221914.2966407-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The native timers IP block found on NVIDIA Tegra SoCs implements a
watchdog timer that can be used to recover from system hangs. Add the
device tree node on Tegra186.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 58100fb9cd8b..4dfa70e93693 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -167,6 +167,22 @@ emc: external-memory-controller@2c60000 {
 		};
 	};
 
+	timer@3010000 {
+		compatible = "nvidia,tegra186-timer";
+		reg = <0x0 0x03010000 0x0 0x000e0000>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	uarta: serial@3100000 {
 		compatible = "nvidia,tegra186-uart", "nvidia,tegra20-uart";
 		reg = <0x0 0x03100000 0x0 0x40>;
-- 
2.24.1

