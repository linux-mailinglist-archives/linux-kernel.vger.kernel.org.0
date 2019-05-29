Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9F22E771
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 23:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfE2V3W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 May 2019 17:29:22 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:64309 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726189AbfE2V3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:29:22 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16725551-1500050 
        for multiple; Wed, 29 May 2019 22:29:06 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190529072540.g46j4kfeae37a3iu@linutronix.de>
Cc:     Hugh Dickins <hughd@google.com>, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20190526173325.lpt5qtg7c6rnbql5@linutronix.de>
 <20190528211826.0fa593de5f2c7480357d3ca5@linux-foundation.org>
 <20190529072540.g46j4kfeae37a3iu@linutronix.de>
Message-ID: <155916534299.2252.10999808950517357760@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v2] x86/fpu: Use fault_in_pages_writeable() for pre-faulting
Date:   Wed, 29 May 2019 22:29:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sebastian Andrzej Siewior (2019-05-29 08:25:40)
> From: Hugh Dickins <hughd@google.com>
> 
> Since commit
> 
>    d9c9ce34ed5c8 ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigframe() fails")
> 
> we use get_user_pages_unlocked() to pre-faulting user's memory if a
> write generates a pagefault while the handler is disabled.
> This works in general and uncovered a bug as reported by Mike Rapoport.
> It has been pointed out that this function may be fragile and a
> simple pre-fault as in fault_in_pages_writeable() would be a better
> solution. Better as in taste and simplicity: That write (as performed by
> the alternative function) performs exactly the same faulting of memory
> that we had before. This was suggested by Hugh Dickins and Andrew
> Morton.
> 
> Use fault_in_pages_writeable() for pre-faulting of user's stack.
> 
> Fixes: d9c9ce34ed5c8 ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigframe() fails")
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> [bigeasy: patch description]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I am able to reliably hit the bug here by putting the system under
mempressure, and afterwards processes would die as the exit. This patch
also greatly reduces cycletest latencies while under that mempressure,
~320ms -> ~16ms (on a bxt while also spinning on i915.ko).

Tested-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
