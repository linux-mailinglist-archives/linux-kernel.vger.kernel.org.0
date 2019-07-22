Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4798870913
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 21:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbfGVS5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 14:57:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38025 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbfGVS5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:57:00 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpdUY-0002OO-43; Mon, 22 Jul 2019 20:56:58 +0200
Message-Id: <20190722105218.855189979@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 22 Jul 2019 20:47:06 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [patch V3 01/25] x86/kgbd: Use NMI_VECTOR not APIC_DM_NMI
References: <20190722104705.550071814@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

apic->send_IPI_allbutself() takes a vector number as argument.

APIC_DM_NMI is clearly not a vector number. It's defined to 0x400 which is
outside the vector space.

Use NMI_VECTOR instead as that's what it is intended to be.

Fixes: 82da3ff89dc2 ("x86: kgdb support")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190704155608.347938562@linutronix.de

---
V2: New patch
---
 arch/x86/kernel/kgdb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -416,7 +416,7 @@ static void kgdb_disable_hw_debug(struct
  */
 void kgdb_roundup_cpus(void)
 {
-	apic->send_IPI_allbutself(APIC_DM_NMI);
+	apic->send_IPI_allbutself(NMI_VECTOR);
 }
 #endif
 


