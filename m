Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD15143B22
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 11:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbgAUKhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 05:37:48 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:41180 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbgAUKh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:37:29 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id sydS2100C5USYZQ01ydSJQ; Tue, 21 Jan 2020 11:37:27 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-00011E-2U; Tue, 21 Jan 2020 11:37:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-0000Tt-0W; Tue, 21 Jan 2020 11:37:26 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH 04/20] ARM: aspeed: Drop unneeded select of HAVE_SMP
Date:   Tue, 21 Jan 2020 11:37:06 +0100
Message-Id: <20200121103722.1781-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121103722.1781-1-geert+renesas@glider.be>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the 6th generation Aspeed SoCs depends on ARCH_MULTI_V7.
As the latter selects HAVE_SMP, there is no need for MACH_ASPEED_G6 to
select HAVE_SMP.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
---
All patches in this series are independent of each other.
Cover letter at https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be

 arch/arm/mach-aspeed/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index e8d6e9957d65b717..ea96d11b850241ce 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -39,7 +39,6 @@ config MACH_ASPEED_G6
 	select PINCTRL_ASPEED_G6
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
-	select HAVE_SMP
 	help
 	 Say yes if you intend to run on an Aspeed ast2600 or similar
 	 sixth generation Aspeed BMCs.
-- 
2.17.1

