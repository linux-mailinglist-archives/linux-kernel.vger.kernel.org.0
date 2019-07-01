Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2ECE2D640
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 09:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfE2HZu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 May 2019 03:25:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52742 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2HZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:25:50 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hVsxw-0002SA-HC; Wed, 29 May 2019 09:25:40 +0200
Date:   Wed, 29 May 2019 09:25:40 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2] x86/fpu: Use fault_in_pages_writeable() for pre-faulting
Message-ID: <20190529072540.g46j4kfeae37a3iu@linutronix.de>
References: <20190526173325.lpt5qtg7c6rnbql5@linutronix.de>
 <20190528211826.0fa593de5f2c7480357d3ca5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190528211826.0fa593de5f2c7480357d3ca5@linux-foundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hughd@google.com>

Since commit

   d9c9ce34ed5c8 ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigframe() fails")

we use get_user_pages_unlocked() to pre-faulting user's memory if a
write generates a pagefault while the handler is disabled.
This works in general and uncovered a bug as reported by Mike Rapoport.
It has been pointed out that this function may be fragile and a
simple pre-fault as in fault_in_pages_writeable() would be a better
solution. Better as in taste and simplicity: That write (as performed by
the alternative function) performs exactly the same faulting of memory
that we had before. This was suggested by Hugh Dickins and Andrew
Morton.

Use fault_in_pages_writeable() for pre-faulting of user's stack.

Fixes: d9c9ce34ed5c8 ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigframe() fails")
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Hugh Dickins <hughd@google.com>
[bigeasy: patch description]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2: Added a Fixes tag.

 arch/x86/kernel/fpu/signal.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 5a8d118bc423e..060d6188b4533 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -5,6 +5,7 @@
 
 #include <linux/compat.h>
 #include <linux/cpu.h>
+#include <linux/pagemap.h>
 
 #include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
@@ -189,15 +190,7 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	fpregs_unlock();
 
 	if (ret) {
-		int aligned_size;
-		int nr_pages;
-
-		aligned_size = offset_in_page(buf_fx) + fpu_user_xstate_size;
-		nr_pages = DIV_ROUND_UP(aligned_size, PAGE_SIZE);
-
-		ret = get_user_pages_unlocked((unsigned long)buf_fx, nr_pages,
-					      NULL, FOLL_WRITE);
-		if (ret == nr_pages)
+		if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_size))
 			goto retry;
 		return -EFAULT;
 	}
-- 
2.20.1

