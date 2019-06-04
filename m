Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D5935205
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 23:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfFDVmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 17:42:13 -0400
Received: from atlmailgw2.ami.com ([63.147.10.42]:50493 "EHLO
        atlmailgw2.ami.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDVmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 17:42:13 -0400
X-AuditID: ac10606f-bbfff70000003de9-15-5cf6e5b10449
Received: from atlms1.us.megatrends.com (atlms1.us.megatrends.com [172.16.96.144])
        (using TLS with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by atlmailgw2.ami.com (Symantec Messaging Gateway) with SMTP id B1.12.15849.2B5E6FC5; Tue,  4 Jun 2019 17:42:10 -0400 (EDT)
Received: from hongweiz-Ubuntu-AMI.us.megatrends.com (172.16.98.93) by
 atlms1.us.megatrends.com (172.16.96.144) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 4 Jun 2019 17:42:09 -0400
From:   Hongwei Zhang <hongweiz@ami.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Hongwei Zhang <hongweiz@ami.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3 linux dev-5.1 arm/soc v2] ARM: dts: aspeed: Add SGPM pinmux
Date:   Tue, 4 Jun 2019 17:42:04 -0400
Message-ID: <1559684524-15583-1-git-send-email-hongweiz@ami.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.98.93]
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWyRiBhgu6mp99iDLad47PYdZnDYv6Rc6wW
        v8//ZbaY8mc5k8Wmx9dYLZpXn2O2uLxrDpvF0usXmSxa9x5hd+D0uNq+i91jzbw1jB4XPx5j
        9ti0qpPN4861PWwem5fUe5yfsZDR4/MmuQCOKC6blNSczLLUIn27BK6Mvo5ZzAVrWCuaO+Yz
        NTCuZ+li5OSQEDCRuHG1jxnEFhLYxSRxewNjFyMXkH2IUeLP0k6wIjYBNYm9m+cwgSREBHYw
        Slz98QysillgPaNE466tjCBVwgL+Eo/fTgSzWQRUJKbf/MEOYvMKOEjM37iGFWKdnMTNc53M
        EHFBiZMzn4BtYBaQkDj44gXUGbIStw49ZoKoV5B43veYZQIj3ywkLbOQtCxgZFrFKJRYkpOb
        mJmTXm6kl5ibqZecn7uJERLI+TsYP340P8TIxMEI9BIHs5IIb+LtLzFCvCmJlVWpRfnxRaU5
        qcWHGKU5WJTEeVet+RYjJJCeWJKanZpakFoEk2Xi4JRqYJyat2VV6s9lL3fo6G/vlpuVzLMg
        Y8fVRx0T+LVz+P+sULxYP2fVzAOyW2sMfp9r27qgajnPqtrkIO2Tfwqz7kSyflI+9ftQyfqp
        O482Gfrfv7CCdevX3gyHuocKbGKB2nlVQr7eVb1Lj17141eIjNt05rnP23PG/YcnHD78g2eP
        mMP9tbkTSrKUWIozEg21mIuKEwHBh/8yUgIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SGPM pinmux to ast2500-pinctrl function and group, to prepare for
supporting SGPIO in AST2500 SoC.

Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 85ed9db..8d30818 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -1321,6 +1321,11 @@
 		groups = "SDA2";
 	};
 
+	pinctrl_sgpm_default: sgpm_default {
+		function = "SGPM";
+		groups = "SGPM";
+	};
+
 	pinctrl_sgps1_default: sgps1_default {
 		function = "SGPS1";
 		groups = "SGPS1";
-- 
2.7.4

