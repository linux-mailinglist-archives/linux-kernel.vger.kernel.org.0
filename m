Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBE8133A52
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 05:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgAHEZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 23:25:57 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10446 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbgAHEZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 23:25:55 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1559c00000>; Tue, 07 Jan 2020 20:25:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 20:25:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 Jan 2020 20:25:54 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 04:25:53 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 8 Jan 2020 04:25:53 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.162.131]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1559d00000>; Tue, 07 Jan 2020 20:25:53 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 21/21] ASoC: nau8825: change Tegra clk_out_2 provider to tegra_pmc
Date:   Tue, 7 Jan 2020 20:25:15 -0800
Message-ID: <1578457515-3477-22-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578457536; bh=pWNZAo13Br7GvFxHxRFIS/1sozX6HF632kX/lxY43iQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=NFkGm820zbY010IcHMC5idC6pN9XMW/B7u/1UVUjVw3kSpwdoCesS38MFXmORb1wD
         0JKF+xvJOGoPt/2IYWIbPcejn9m1P5LGbR6h8sUa7Th8hp+i0sG2otGiz7D+HaR+6Y
         KoE6qNR6Z9KcgqTNmbx+3+o5ox9W75jU1brrdpDTSk4xTcOeCL7FrEN7XrHhjiUgPd
         X9YESHjIlC0Ef8wskMMZoyCjmu+szWoY/+RyUQpqeznr+BOGoo3gIMcrjQ+ECWbR5e
         2Vfmv3x06GDumeVhCUBch7pl+jMn/1D+DDS14/ev0X2JYBAE6ib89+VWgmZTVP/lC0
         +D3xtfmLHdJ2w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra clk_out_1, clk_out_2, and clk_out_3 are part of PMC block and
these clocks are moved from clock drvier to pmc driver with pmc as
a provider for these clocks.

Update bindings document to use pmc as clock provider for clk_out_2 and
change id to pmc clock id.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/sound/nau8825.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/nau8825.txt b/Documentation/devicetree/bindings/sound/nau8825.txt
index d16d96839bcb..388a7bc60b1f 100644
--- a/Documentation/devicetree/bindings/sound/nau8825.txt
+++ b/Documentation/devicetree/bindings/sound/nau8825.txt
@@ -101,5 +101,5 @@ Example:
       nuvoton,crosstalk-enable;
 
       clock-names = "mclk";
-      clocks = <&tegra_car TEGRA210_CLK_CLK_OUT_2>;
+      clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_2>;
   };
-- 
2.7.4

