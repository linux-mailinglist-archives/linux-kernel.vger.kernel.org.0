Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC33FA0502
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 16:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfH1Obu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 10:31:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47536 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfH1Obm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:31:42 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2yz6-00061y-MO; Wed, 28 Aug 2019 16:31:40 +0200
Message-Id: <20190828143124.063353972@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 28 Aug 2019 16:24:47 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Song Liu <songliubraving@fb.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>
Subject: [patch 2/2] x86/mm/pti: Do not invoke PTI functions when PTI is
 disabled
References: <20190828142445.454151604@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PTI is disabled at boot time either because the CPU is not affected or
PTI has been disabled on the command line, the boot code still calls into
pti_finalize() which then unconditionally invokes:

     pti_clone_entry_text()
     pti_clone_kernel_text()

pti_clone_kernel_text() was called unconditionally before the 32bit support
was added and 32bit added the call to pti_clone_entry_text().

The call has no side effects as cloning the page tables into the available
second one, which was allocated for PTI does not create damage. But it does
not make sense either and in case that this functionality would be extended
later this might actually lead to hard to diagnose issue.

Neither function should be called when PTI is runtime disabled. Make the
invocation conditional.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/mm/pti.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -668,6 +668,8 @@ void __init pti_init(void)
  */
 void pti_finalize(void)
 {
+	if (!boot_cpu_has(X86_FEATURE_PTI))
+		return;
 	/*
 	 * We need to clone everything (again) that maps parts of the
 	 * kernel image.


