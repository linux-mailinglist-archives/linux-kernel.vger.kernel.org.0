Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74426407B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 07:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfGJFO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 01:14:56 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:23257 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfGJFO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:14:56 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6A5DREA030499;
        Wed, 10 Jul 2019 14:13:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6A5DREA030499
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562735608;
        bh=1BDNIyvXOAp0AhR4Ns6txoUKEiiNIiaFMGdXhnp1IlA=;
        h=From:To:Cc:Subject:Date:From;
        b=xu/Tm5EfBojLuxqcXEj6YrZ+KlsaQOyl37TSrPSoWJSlWQGwyHhX0E4DWraNxAeT/
         /TmFjanhNNaJ9kcpkW6bNu7CAjvYfIdt8hKAJfYe2qpFlbquFqQCuPypciPd1X+YaY
         MwlOc/whgDiycb9L/0Dp5q1Stq7GGYr6W3ocDO4ID0hVkjhbJIu//IPqwpaxezSdkb
         6Z3O5AmttAuNKsoisx1H57RbPiyyvgFiq6yYvvSLMC8jZKwLUK+s7eE0zwjcWGmU/I
         dnbio/j9JL2ASOMq7aLzEB8o2sRHOQT5XAlKgaaPOS0s565C5uQY8c4DwqV1c22WTJ
         cjJTUmYAP/bBA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: stm32: use "depends on" instead of "if" after prompt
Date:   Wed, 10 Jul 2019 14:13:20 +0900
Message-Id: <20190710051320.8738-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This appeared after the global fixups by commit e32465429490 ("ARM: use
"depends on" for SoC configs instead of "if" after prompt"). Fix it now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-stm32/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 05d6b5aada80..57699bd8f107 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_STM32
-	bool "STMicroelectronics STM32 family" if ARM_SINGLE_ARMV7M || ARCH_MULTI_V7
+	bool "STMicroelectronics STM32 family"
+	depends on ARM_SINGLE_ARMV7M || ARCH_MULTI_V7
 	select ARMV7M_SYSTICK if ARM_SINGLE_ARMV7M
 	select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
 	select ARM_GIC if ARCH_MULTI_V7
-- 
2.17.1

