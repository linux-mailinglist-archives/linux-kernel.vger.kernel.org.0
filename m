Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D305FBC5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 18:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfGDQeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 12:34:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59605 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfGDQd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:33:59 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4gH-0005eb-2O; Thu, 04 Jul 2019 18:33:57 +0200
Message-Id: <20190704155608.347938562@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 17:51:46 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch V2 01/25] x86/kgbd: Use NMI_VECTOR not APIC_DM_NMI
References: <20190704155145.617706117@linutronix.de>
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
---
V2: New patch
---
 arch/x86/kernel/kgdb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -424,7 +424,7 @@ static void kgdb_disable_hw_debug(struct
  */
 void kgdb_roundup_cpus(void)
 {
-	apic->send_IPI_allbutself(APIC_DM_NMI);
+	apic->send_IPI_allbutself(VECTOR_NMI);
 }
 #endif
 


