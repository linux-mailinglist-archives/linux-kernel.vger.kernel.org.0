Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C31686AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 11:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfGOJwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 05:52:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfGOJwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gqsH7R9ZkCpew7P4VmFI5+NgnAM5dz6k+qa5c5AXO+A=; b=kr7yvRxPapRr2AO3/Xqa7aBYy
        040OJXK+Jn0t+zfT3XqTzjx3sJ+5Vu1+jE3P1kFhKJphToQvIaCx2MBhrLRmXvMT0YCEZGDXCTJZF
        CsyG+/COuGVA7pHXwYgC+1oqGQhaWIWzlLr0d7ggaphcwqLnOQRoD7XvcX24IiP+GoX6UlqBwIS1q
        ouACKGXrBSUl+PYrrhZsHd+CePY8FS9pS72BKC4ROZOu/gDL6A4RZP79R0KfPVcYSwwIr0EaSi+g0
        ycxw0pQo7MWMb3p2zZVL7t+rYPEQOog+kKVH1DN9ZHN6QmydMkVVXAtXPwkNd6U+Ew7vczqW85xlB
        wHShMbi4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmxeV-0006Yr-GQ; Mon, 15 Jul 2019 09:52:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E827A20B29100; Mon, 15 Jul 2019 11:52:09 +0200 (CEST)
Date:   Mon, 15 Jul 2019 11:52:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 00/22] x86, objtool: several fixes/improvements
Message-ID: <20190715095209.GA3419@hirez.programming.kicks-ass.net>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 07:36:55PM -0500, Josh Poimboeuf wrote:
> There have been a lot of objtool bug reports lately, mainly related to
> Clang and BPF.  As part of fixing those bugs, I added some improvements
> to objtool which uncovered yet more bugs (some kernel, some objtool).
> 
> I've given these patches a lot of testing with both GCC and Clang.  More
> compile testing of objtool would be appreciated, as the kbuild test
> robot doesn't seem to be paying much attention to my branches lately.
> 
> There are still at least three outstanding issues:
> 
> 1) With clang I see:
> 
>      drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x88: redundant UACCESS disable
> 
>    I haven't dug into it yet.
> 
> 2) There's also an issue in clang where a large switch table had a bunch
>    of unused (bad) entries.  It's not a code correctness issue, but
>    hopefully it can get fixed in clang anyway.  See patch 20/22 for more
>    details.
> 
> 3) CONFIG_LIVEPATCH is causing some objtool "unreachable instruction"
>    warnings due to the new -flive-patching flag.  I have some fixes
>    pending, but this patch set is already long enough.
> 
> 
> Jann Horn (1):
>   objtool: Support repeated uses of the same C jump table
> 
> Josh Poimboeuf (21):
>   x86/paravirt: Fix callee-saved function ELF sizes
>   x86/kvm: Fix fastop function ELF metadata
>   x86/kvm: Fix frame pointer usage in vmx_vmenter()
>   x86/kvm: Don't call kvm_spurious_fault() from .fixup
>   x86/entry: Fix thunk function ELF sizes
>   x86/head/64: Annotate start_cpu0() as non-callable
>   x86/uaccess: Remove ELF function annotation from
>     copy_user_handle_tail()
>   x86/uaccess: Don't leak AC flag into fentry from mcsafe_handle_tail()
>   x86/uaccess: Remove redundant CLACs in getuser/putuser error paths
>   bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()
>   objtool: Add mcsafe_handle_tail() to the uaccess safe list
>   objtool: Track original function across branches
>   objtool: Refactor function alias logic
>   objtool: Warn on zero-length functions
>   objtool: Change dead_end_function() to return boolean
>   objtool: Do frame pointer check before dead end check
>   objtool: Refactor sibling call detection logic
>   objtool: Refactor jump table code
>   objtool: Fix seg fault on bad switch table entry
>   objtool: convert insn type to enum
>   objtool: Support conditional retpolines

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
