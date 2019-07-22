Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F36E7055B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfGVQXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 12:23:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37543 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfGVQXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:23:48 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpb6H-0004Yy-P0; Mon, 22 Jul 2019 18:23:45 +0200
Date:   Mon, 22 Jul 2019 18:23:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT pull] sched/urgent for 5.3-rc2
Message-ID: <alpine.DEB.2.21.1907221820570.1659@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

up to:  b8d3349803ba: sched/rt, Kconfig: Unbreak def/oldconfig with CONFIG_PREEMPT=y

The PREEMPT_RT stub config renamed PREEMPT to PREEMPT_LL and defined
PREEMPT outside of the menu and made it selectable by both PREEMPT_LL and
PREEMPT_RT.

Stupid me missed that 114 defconfigs select CONFIG_PREEMPT which obviously
can't work anymore. oldconfig builds are affected as well, but it's more
obvious as the user gets asked. [old]defconfig silently fixes it up and
selects PREEMPT_NONE. Unbreak it by undoing the rename and adding a
intermediate config symbol which is selected by both PREEMPT and
PREEMPT_RT. That requires to chase down a few #ifdefs, but it's better than
tweaking 114 defconfigs and annoying users.

Sorry for the inconveniance.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      sched/rt, Kconfig: Unbreak def/oldconfig with CONFIG_PREEMPT=y


 kernel/Kconfig.preempt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index fc020c09b7e8..deff97217496 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -35,10 +35,10 @@ config PREEMPT_VOLUNTARY
 
 	  Select this if you are building a kernel for a desktop system.
 
-config PREEMPT_LL
+config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT
+	select PREEMPTION
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 	help
 	  This option reduces the latency of the kernel by making
@@ -58,7 +58,7 @@ config PREEMPT_LL
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
 	depends on EXPERT && ARCH_SUPPORTS_RT
-	select PREEMPT
+	select PREEMPTION
 	help
 	  This option turns the kernel into a real-time kernel by replacing
 	  various locking primitives (spinlocks, rwlocks, etc.) with
@@ -77,6 +77,6 @@ endchoice
 config PREEMPT_COUNT
        bool
 
-config PREEMPT
+config PREEMPTION
        bool
        select PREEMPT_COUNT
