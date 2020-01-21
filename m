Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 996ED143B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 11:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgAUKha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 05:37:30 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:51420 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgAUKh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:37:28 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id sydS2100K5USYZQ06ydSyB; Tue, 21 Jan 2020 11:37:26 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-00011N-5r; Tue, 21 Jan 2020 11:37:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-0000U2-4L; Tue, 21 Jan 2020 11:37:26 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 07/20] ARM: berlin: Drop unneeded select of HAVE_SMP
Date:   Tue, 21 Jan 2020 11:37:09 +0100
Message-Id: <20200121103722.1781-7-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121103722.1781-1-geert+renesas@glider.be>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for Marvell Berlin SoCs depends on ARCH_MULTI_V7.
As the latter selects HAVE_SMP, there is no need for MACH_BERLIN_BG2 to
select HAVE_SMP.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
All patches in this series are independent of each other.
Cover letter at https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be

 arch/arm/mach-berlin/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index 5b1f61fd78780300..01861fa72c9714b7 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -19,7 +19,6 @@ config MACH_BERLIN_BG2
 	select CPU_PJ4B
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
 	select PINCTRL_BERLIN_BG2
 
 config MACH_BERLIN_BG2CD
-- 
2.17.1

