Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010E9708FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 20:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbfGVS5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 14:57:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38073 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731903AbfGVS5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:57:05 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpdUd-0002Pb-LI; Mon, 22 Jul 2019 20:57:03 +0200
Message-Id: <20190722105219.725264153@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 22 Jul 2019 20:47:15 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [patch V3 10/25] x86/apic/uv: Make x2apic_extra_bits static
References: <20190722104705.550071814@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not used outside of the UV apic source.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/apic.h        |    2 --
 arch/x86/kernel/apic/x2apic_uv_x.c |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -467,8 +467,6 @@ static inline unsigned default_get_apic_
 
 #ifdef CONFIG_X86_64
 extern void apic_send_IPI_self(int vector);
-
-DECLARE_PER_CPU(int, x2apic_extra_bits);
 #endif
 
 extern void generic_bigsmp_probe(void);
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -22,7 +22,7 @@
 #include <asm/uv/uv.h>
 #include <asm/apic.h>
 
-DEFINE_PER_CPU(int, x2apic_extra_bits);
+static DEFINE_PER_CPU(int, x2apic_extra_bits);
 
 static enum uv_system_type	uv_system_type;
 static bool			uv_hubless_system;


