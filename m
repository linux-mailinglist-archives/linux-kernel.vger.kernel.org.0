Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A8A1A89F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2019 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfEKRJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 13:09:30 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:49816 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfEKRJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 13:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1557594567; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=GR6dHTPinqlaxYbv7F2UbOWKgpz0RUv1LMiBQKwlanM=;
        b=bGJwB+HkyeQqymTNwuTTB+Kq2tTdNVgEtrhECb5mB07qlTbp9+NGWgKEKQC0bg4JFhHJl2
        Sm+aodVn02AK2JBHt7bTVezRpad9efwuv0Dn6KzRz55k1TLSZuBLnbM7LnLQ+kQEh1PKfC
        yEbG7w0CxSLEStnQphg6T8ur0kxueeQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] irqchip: ingenic: Drop dependency on MACH_INGENIC, use COMPILE_TEST
Date:   Sat, 11 May 2019 19:09:16 +0200
Message-Id: <20190511170916.12990-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on MACH_INGENIC prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

On other architectures, this driver can still be built, thanks to
COMPILE_TEST. This is used by automated tools to find bugs, for
instance.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/irqchip/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5438abb1baba..864dc38782e8 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -286,9 +286,9 @@ config MIPS_GIC
 	select MIPS_CM
 
 config INGENIC_IRQ
-	bool
-	depends on MACH_INGENIC
-	default y
+	bool "Ingenic JZ47xx IRQ controller driver"
+	depends on MIPS || COMPILE_TEST
+	default MACH_INGENIC
 
 config RENESAS_H8300H_INTC
         bool
-- 
2.21.0.593.g511ec345e18

