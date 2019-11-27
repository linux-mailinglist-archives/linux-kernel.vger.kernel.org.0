Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A06010A9A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 06:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfK0E7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 23:59:47 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15259 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfK0E7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 23:59:40 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dde02bd0000>; Tue, 26 Nov 2019 20:59:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Nov 2019 20:59:39 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Nov 2019 20:59:39 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov
 2019 04:59:38 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Nov 2019 04:59:38 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.149]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dde02b90000>; Tue, 26 Nov 2019 20:59:38 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <tglx@linutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/11] dt-bindings: soc: tegra-pmc: Add id for Tegra PMC blink control
Date:   Tue, 26 Nov 2019 20:59:25 -0800
Message-ID: <1574830773-14892-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574830781; bh=63eFiSPz4MqupbpIiCdG57XX3PH0P9e9XUqT1iGtGIk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=FWAhWaKyEXNQsePRPUlommZzV0syu6JB4j7o+wFy0J331DUpy5/DO9RU/Aa7MhkqK
         hXU5Ex9m31V0HeNyTQ2Qcynmo4EcwL4fK7UvNauZKZAKhLxUHV8BgZHWO8mqAv8vX3
         Bk1bbWFx0hIdikRtnM7aaMMDx9c7m/5aeWWrmG/dxrOEQTgU3PaD9wobhJ8dbTaoXW
         nGc+u4jwsOoIcuzb+ho8peFCWB9/y9qWDmR/c/xoCDcZYmmJ2LomNj3xCJYOd92bWU
         fjg/g9gyVtwpR33ODQ+YCBJ/L4YVUKlqTaF/UV5csxDKHedpB++LUpcLLOKBNVBbFE
         iCEs0/1L6h/zQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC has a blinking control to output 32 KHz clock to blink
pin.

This patch adds id for this blink control to use for enabling or
disabling the blink output through devicetree.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 include/dt-bindings/soc/tegra-pmc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/soc/tegra-pmc.h b/include/dt-bindings/soc/tegra-pmc.h
index 705ee8083070..6fe28516017e 100644
--- a/include/dt-bindings/soc/tegra-pmc.h
+++ b/include/dt-bindings/soc/tegra-pmc.h
@@ -12,7 +12,8 @@
 #define TEGRA_PMC_CLK_OUT_2		3
 #define TEGRA_PMC_CLK_OUT_3_MUX		4
 #define TEGRA_PMC_CLK_OUT_3		5
+#define TEGRA_PMC_CLK_BLINK		6
 
-#define TEGRA_PMC_CLK_MAX		6
+#define TEGRA_PMC_CLK_MAX		7
 
 #endif	/* _DT_BINDINGS_SOC_TEGRA_PMC_H */
-- 
2.7.4

