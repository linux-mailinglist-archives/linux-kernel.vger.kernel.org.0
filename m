Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA848362
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 15:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfFQNCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 09:02:07 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:41391 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfFQNCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:02:07 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MT9v5-1i3cOz1DcF-00UeXy; Mon, 17 Jun 2019 15:01:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Lokesh Vutla <lokeshvutla@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: ti: fix irq-ti-sci link error
Date:   Mon, 17 Jun 2019 15:01:05 +0200
Message-Id: <20190617130149.1782930-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FRdEe6tjuV8KyxJSyrTdyhJaUWE5AS9D7M4jEyC+sBbLA/FibZc
 DYw+IyzPdm/Jp25ioQ6PWJYlw51JAUxTu7+Hfs80p/pul4o4y+21YGFbHBdYwE8p5ap0von
 g++GFuW5ry3GclAiTwmHWDNf+QQxkiLPWOp5mhatqbbgseGiluC8lTi2pLMXg69dVNYzfLv
 VlhXhp1PNhNWvhlccS/xg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zd06hkM9Szw=:mMYc/1oT1VBq+1iFcHYDsw
 +dPi8sODpQ5PmH/geIGQNy+AiBUO5PB0DyfiOtJWGL4eksx8/x9XC3W9EWffYtiEFSAIhwpma
 K22sxiWrsBUKBRjuNuYMF5WkHymqHAaQg5r2ywmVlX96+8I6CL9gGjZ80wHzmBOWwJAmYoxgB
 RK5kA9QjgoKgsosNxy79ufYjSqtdRPxK9uU71EpIC6ofYCxJZdxNHAsNRCZEvSKEtq9CaHoah
 wLwmSWeNtfvnk3/Esi7H4Wy5hnRmDzQZqAazjWU2Sy6oWQDNvRrGlCaRhAYrSP1uZeOm8J4J2
 9jp0JjgaUKqajvKGI14a4Ygt4ZpyJGmw0AY7fbVpGlkve4vufJsNUhZPdpLAfBdsgW9on7GEj
 q6dk0icEfK6IlX8XgEgPVyuNTefCgVlSW87o+KTS1McMUSKgxZ0aQtm5DEp/J64VcFxjN9iqD
 8qAdv809c2TlJeP4ZwBw43I1w6vsJGFz74W43TVdOKP6WSac+0SYL1+YlByW3xzYMUKiHSvys
 kLmRn8U79CTj3GceSuGouRqIh2BuXx9ZtJCkXDcYj90HwHcYcuL2TbN552XEJfutO3brF0nI+
 QHLXDVFLNoX8fslO8ULdjA7gvinfTrDNZfLHaVnZ6SGsIl1iJBunfubMwER5BNMZ2ooemo3/G
 HSTCPBHRmEsKaswQRPNzLyg1U0NXBLBitKuDhgxs7kUS3wFu1EICV9SwQzhGm4+FrSKa4Eime
 jhYi5pax9Gkdd/2fLOmYX2vcXLxm/TaQ5IeYFQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irqchip driver depends on the SoC specific driver, but we want
to be able to compile-test it elsewhere:

WARNING: unmet direct dependencies detected for TI_SCI_INTA_MSI_DOMAIN
  Depends on [n]: SOC_TI [=n]
  Selected by [y]:
  - TI_SCI_INTA_IRQCHIP [=y] && TI_SCI_PROTOCOL [=y]

drivers/irqchip/irq-ti-sci-inta.o: In function `ti_sci_inta_irq_domain_probe':
irq-ti-sci-inta.c:(.text+0x204): undefined reference to `ti_sci_inta_msi_create_irq_domain'

Rearrange the Kconfig and Makefile so we build the soc driver whenever
its users are there, regardless of the SOC_TI option.

Fixes: 49b323157bf1 ("soc: ti: Add MSI domain bus support for Interrupt Aggregator")
Fixes: f011df6179bd ("irqchip/ti-sci-inta: Add msi domain support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/Makefile   | 2 +-
 drivers/soc/ti/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 524ecdc2a9bb..2ec355003524 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
 obj-y				+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
-obj-$(CONFIG_SOC_TI)		+= ti/
+obj-y				+= ti/
 obj-$(CONFIG_ARCH_U8500)	+= ux500/
 obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
 obj-y				+= xilinx/
diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index ea0859f7b185..d7d50d48d05d 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -75,10 +75,10 @@ config TI_SCI_PM_DOMAINS
 	  called ti_sci_pm_domains. Note this is needed early in boot before
 	  rootfs may be available.
 
+endif # SOC_TI
+
 config TI_SCI_INTA_MSI_DOMAIN
 	bool
 	select GENERIC_MSI_IRQ_DOMAIN
 	help
 	  Driver to enable Interrupt Aggregator specific MSI Domain.
-
-endif # SOC_TI
-- 
2.20.0

