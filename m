Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 815CC187C0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 11:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfEIJ3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 05:29:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:58592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfEIJ3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 05:29:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 966AAAB42;
        Thu,  9 May 2019 09:29:43 +0000 (UTC)
Date:   Thu, 9 May 2019 11:29:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Crashes in linux-next on powerpc with CONFIG_PPC_KUAP and
 CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
Message-ID: <20190509092942.ei4myfzt5dczuptj@pathway.suse.cz>
References: <87k1f2wc04.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1f2wc04.fsf@concordia.ellerman.id.au>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-05-08 00:54:51, Michael Ellerman wrote:
> Hi folks,
> 
> Just an FYI in case anyone else is seeing crashes very early in boot in
> linux-next with the above config options.
>
> The problem is the combination of some new code called via printk(),
> check_pointer() which calls probe_kernel_read(). That then calls 
> allow_user_access() (PPC_KUAP) and that uses mmu_has_feature() too early
> (before we've patched features). With the JUMP_LABEL debug enabled that
> causes us to call printk() & dump_stack() and we end up recursing and
> overflowing the stack.

Sigh, the check_pointer() stuff is in Linus's tree now, see
the commit 3e5903eb9cff707301712 ("vsprintf: Prevent crash when
dereferencing invalid pointers").

> Because it happens so early you don't get any output, just an apparently
> dead system.
> 
> The stack trace (which you don't see) is something like:
> 
>   ...
>   dump_stack+0xdc
>   probe_kernel_read+0x1a4
>   check_pointer+0x58
>   string+0x3c
>   vsnprintf+0x1bc
>   vscnprintf+0x20
>   printk_safe_log_store+0x7c
>   printk+0x40
>   dump_stack_print_info+0xbc
>   dump_stack+0x8
>   probe_kernel_read+0x1a4
>   probe_kernel_read+0x19c
>   check_pointer+0x58
>   string+0x3c
>   vsnprintf+0x1bc
>   vscnprintf+0x20
>   vprintk_store+0x6c
>   vprintk_emit+0xec
>   vprintk_func+0xd4
>   printk+0x40
>   cpufeatures_process_feature+0xc8
>   scan_cpufeatures_subnodes+0x380
>   of_scan_flat_dt_subnodes+0xb4
>   dt_cpu_ftrs_scan_callback+0x158
>   of_scan_flat_dt+0xf0
>   dt_cpu_ftrs_scan+0x3c
>   early_init_devtree+0x360
>   early_setup+0x9c
> 
> 
> The simple fix is to use early_mmu_has_feature() in allow_user_access(),
> but we'd rather not do that because it penalises all
> copy_to/from_users() for the life of the system with the cost of the
> runtime check vs the jump label. The irony is probe_kernel_read()
> shouldn't be allowing user access at all, because we're reading the
> kernel not userspace.

I have tried to find a lightweight way for a safe reading of unknown
kernel pointer. But I have not succeeded so far. I see only variants
with user access. The user access is handled in arch-specific code
and I do not see any variant without it.

I am not sure on which level it should get fixed.

Could you please send it to lkml to get a wider audience?

Best Regards,
Petr

> For now if you're hitting it just turn off 
> CONFIG_PPC_KUAP and/or CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG.
> 
> cheers
