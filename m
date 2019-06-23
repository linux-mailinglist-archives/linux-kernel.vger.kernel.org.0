Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0FC4FBD7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2019 15:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfFWN1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 09:27:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33469 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfFWN1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:46 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2X2-0001kY-9r; Sun, 23 Jun 2019 15:27:44 +0200
Message-Id: <20190623132435.348089155@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:54 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [patch 14/29] x86/hpet: Remove not required includes
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1,22 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/export.h>
 #include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/i8253.h>
-#include <linux/slab.h>
 #include <linux/hpet.h>
-#include <linux/init.h>
 #include <linux/cpu.h>
-#include <linux/pm.h>
-#include <linux/io.h>
+#include <linux/irq.h>
 
-#include <asm/cpufeature.h>
-#include <asm/irqdomain.h>
-#include <asm/fixmap.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
 


