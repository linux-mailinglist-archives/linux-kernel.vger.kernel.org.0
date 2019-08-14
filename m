Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4425B8D3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 14:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfHNMwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 08:52:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHNMw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:52:29 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14D1A206C2;
        Wed, 14 Aug 2019 12:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787149;
        bh=92Dv0hab1SjjodxPx7Hc3x0MCwpXsuMnnSOxwF4X0Ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fmg835nK/pDBasV6OMsO8E3wK6MBK/ieQu0bWK4NsRq1gmICLYLjSNhGaOHGo0HVk
         plorxT6juuA0pXk13dJV54yYXNevFXFo0C0/zeDYvVgOesC3kmMWDlsnbMv6jV1rXN
         4JmgZjPEQm41hHG9JaXah4mQg+2WlRq0hTFAnuoo=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/22] arm64: dts: qcom: pm8150b: Add gpio node
Date:   Wed, 14 Aug 2019 18:20:01 +0530
Message-Id: <20190814125012.8700-12-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814125012.8700-1-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the gpio node found in pm8150b PMIC.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pm8150b.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index 846197bd65cd..2bb2384461f7 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -65,6 +65,25 @@
 				label = "smb1355_therm";
 			};
 		};
+
+		pm8150b_gpios: gpio@c000 {
+			compatible = "qcom,pm8150b-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <0x2 0xc0 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc1 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc2 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc3 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc4 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc5 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc6 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc7 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc8 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc9 0 IRQ_TYPE_NONE>,
+				     <0x2 0xca 0 IRQ_TYPE_NONE>,
+				     <0x2 0xcb 0 IRQ_TYPE_NONE>;
+		};
 	};
 
 	qcom,pm8150@3 {
-- 
2.20.1

