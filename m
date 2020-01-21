Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79BB1143B30
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 11:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgAUKiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 05:38:11 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:58072 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgAUKh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:37:28 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id sydS210055USYZQ01ydSpA; Tue, 21 Jan 2020 11:37:26 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-000118-0D; Tue, 21 Jan 2020 11:37:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquT-0000Tn-VK; Tue, 21 Jan 2020 11:37:25 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH 02/20] ARM: alpine: Drop unneeded select of HAVE_SMP
Date:   Tue, 21 Jan 2020 11:37:04 +0100
Message-Id: <20200121103722.1781-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121103722.1781-1-geert+renesas@glider.be>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for Annapurna Labs Alpine platforms depends on ARCH_MULTI_V7.
As the latter selects HAVE_SMP, there is no need for ARCH_ALPINE to
select HAVE_SMP.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>
---
All patches in this series are independent of each other.
Cover letter at https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be

 arch/arm/mach-alpine/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-alpine/Kconfig b/arch/arm/mach-alpine/Kconfig
index bc04c91294cf12e2..6a68a162385b8534 100644
--- a/arch/arm/mach-alpine/Kconfig
+++ b/arch/arm/mach-alpine/Kconfig
@@ -7,7 +7,6 @@ config ARCH_ALPINE
 	select ARM_GIC
 	select GENERIC_IRQ_CHIP
 	select HAVE_ARM_ARCH_TIMER
-	select HAVE_SMP
 	select MFD_SYSCON
 	select FORCE_PCI
 	select PCI_HOST_GENERIC
-- 
2.17.1

