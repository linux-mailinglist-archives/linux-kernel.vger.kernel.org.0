Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7D91048F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 04:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfKUDTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 22:19:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:32886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfKUDTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:19:30 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD5B420721;
        Thu, 21 Nov 2019 03:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306369;
        bh=4GfdPB5jOzjO+xt5kQ0DZRHDgqNQ2xIh+jw78VaMXWM=;
        h=From:To:Cc:Subject:Date:From;
        b=AK7c0yssmkKf9g7yQ+FbEGdBJDaNt3YhKXGQt8xCyYzTqnQi0rSapERqCp6Kclypb
         mDODXGARhffwh7KBbfDACRkh52uj28QuzDMB+dpPTW8VzD9hzNam4IXF1FusAc0Oku
         /lXqZCdjFHg+hAiKnQfddybSrnpy3jwglHwtJ6EE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2] irqchip: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:19:26 +0100
Message-Id: <1574306366-29476-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/irqchip/Kconfig | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 697e6a8ccaae..d8f4862f13bb 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -276,9 +276,9 @@ config VERSATILE_FPGA_IRQ
 	select IRQ_DOMAIN
 
 config VERSATILE_FPGA_IRQ_NR
-       int
-       default 4
-       depends on VERSATILE_FPGA_IRQ
+	int
+	default 4
+	depends on VERSATILE_FPGA_IRQ
 
 config XTENSA_MX
 	bool
@@ -328,7 +328,7 @@ config INGENIC_TCU_IRQ
 	  If unsure, say N.
 
 config RENESAS_H8300H_INTC
-        bool
+	bool
 	select IRQ_DOMAIN
 
 config RENESAS_H8S_INTC
@@ -368,7 +368,7 @@ config MVEBU_PIC
 	bool
 
 config MVEBU_SEI
-        bool
+	bool
 
 config LS_EXTIRQ
 	def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
@@ -410,19 +410,19 @@ config IRQ_UNIPHIER_AIDET
 	  Support for the UniPhier AIDET (ARM Interrupt Detector).
 
 config MESON_IRQ_GPIO
-       bool "Meson GPIO Interrupt Multiplexer"
-       depends on ARCH_MESON
-       select IRQ_DOMAIN_HIERARCHY
-       help
-         Support Meson SoC Family GPIO Interrupt Multiplexer
+	bool "Meson GPIO Interrupt Multiplexer"
+	depends on ARCH_MESON
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Support Meson SoC Family GPIO Interrupt Multiplexer
 
 config GOLDFISH_PIC
-       bool "Goldfish programmable interrupt controller"
-       depends on MIPS && (GOLDFISH || COMPILE_TEST)
-       select IRQ_DOMAIN
-       help
-         Say yes here to enable Goldfish interrupt controller driver used
-         for Goldfish based virtual platforms.
+	bool "Goldfish programmable interrupt controller"
+	depends on MIPS && (GOLDFISH || COMPILE_TEST)
+	select IRQ_DOMAIN
+	help
+	  Say yes here to enable Goldfish interrupt controller driver used
+	  for Goldfish based virtual platforms.
 
 config QCOM_PDC
 	bool "QCOM PDC"
-- 
2.7.4

