Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 606C110607
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 10:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfEAIXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 04:23:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46184 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfEAIXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 04:23:19 -0400
Received: from zn.tnic (p200300EC2F11E2009473B5BAF18BC17A.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:e200:9473:b5ba:f18b:c17a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 068411EC027B;
        Wed,  1 May 2019 10:23:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556698998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2GeMQHYqw4HK5LdgAG7iSJgsBMier0kNe7aOM8426Rc=;
        b=o/vjwaaz3yOd3R12Mozryy/RyDm641iJROnyYZOJNtsQeKFmy1IqbqoqPJAXaUbgH3yg8f
        +17/3GJEWeVuDBIElfHXwAcYxRas1Dnv0I6GeMYVo3XzeQkLmVrbbOUL7wMrs3h4fDP1XM
        4iLEk1MXLdd4rBVgz1TMGV895/s7g/A=
Date:   Wed, 1 May 2019 10:23:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Qian Cai <cai@lca.pw>
Cc:     bigeasy@linutronix.de, dave.hansen@intel.com, tglx@linutronix.de,
        x86@kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        luto@amacapital.net, hpa@zytor.com, mingo@kernel.org
Subject: Re: copy_fpstate_to_sigframe()  use-after-free
Message-ID: <20190501082312.GA3908@zn.tnic>
References: <1556657902.6132.13.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1556657902.6132.13.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:58:22PM -0400, Qian Cai wrote:
> The commit eeec00d73be2 ("x86/fpu: Fault-in user stack if
> copy_fpstate_to_sigframe() fails") causes use-after-free when running the LTP
> signal06 test case. Reverted this commit fixed the issue.

Thanks for the report, I can trigger it very easily in a VM too, see below.
Patch is delayed until this has been resolved.

---

[   84.134481] ==================================================================
[   84.134639] BUG: KASAN: use-after-free in page_move_anon_rmap+0x24/0x60
[   84.134639] Read of size 8 at addr ffff888068295188 by task signal06/4472
[   84.134639] 
[   84.134639] CPU: 4 PID: 4472 Comm: signal06 Not tainted 5.1.0-rc7+ #2
[   84.134639] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[   84.134639] Call Trace:
[   84.134639]  dump_stack+0x5b/0x90
[   84.134639]  ? page_move_anon_rmap+0x24/0x60
[   84.134639]  print_address_description+0x6c/0x23c
[   84.134639]  ? page_move_anon_rmap+0x24/0x60
[   84.134639]  ? page_move_anon_rmap+0x24/0x60
[   84.134639]  __kasan_report.cold.3+0x1a/0x33
[   84.134639]  ? page_move_anon_rmap+0x24/0x60
[   84.134639]  kasan_report+0xe/0x20
[   84.134639]  page_move_anon_rmap+0x24/0x60
[   84.134639]  do_wp_page+0x8df/0xa30
[   84.134639]  ? finish_mkwrite_fault+0x260/0x260
[   84.134639]  ? _raw_spin_lock+0x78/0xc0
[   84.134639]  ? _raw_read_lock_irq+0x40/0x40
[   84.134639]  ? bsearch+0x54/0x80
[   84.134639]  __handle_mm_fault+0xfe2/0x1910
[   84.134639]  ? __pmd_alloc+0x1c0/0x1c0
[   84.134639]  ? vmacache_find+0xf0/0x130
[   84.134639]  ? _raw_spin_unlock+0xe/0x30
[   84.134639]  ? follow_page_pte+0x50f/0x670
[   84.134639]  handle_mm_fault+0x9a/0x160
[   84.134639]  __get_user_pages+0x3ab/0x9d0
[   84.134639]  ? refcount_dec_and_lock_irqsave+0x27/0x80
[   84.134639]  ? follow_page_mask+0x990/0x990
[   84.134639]  ? __do_page_fault+0x113/0x610
[   84.134639]  ? __bad_area_nosemaphore.constprop.28+0x4b/0x250
[   84.134639]  ? __dequeue_signal+0x1c7/0x250
[   84.134639]  ? kmem_cache_free+0x75/0x1d0
[   84.134639]  get_user_pages+0x80/0xb0
[   84.134639]  copy_fpstate_to_sigframe+0x1ba/0x470
[   84.134639]  ? __fpu__restore_sig+0x6f0/0x6f0
[   84.134639]  ? kick_process+0x32/0xd0
[   84.134639]  do_signal+0x8dc/0xaf0
[   84.134639]  ? do_send_sig_info+0xce/0x120
[   84.134639]  ? setup_sigcontext+0x260/0x260
[   84.134639]  ? check_kill_permission+0xac/0x1e0
[   84.134639]  ? do_send_specific+0x72/0xc0
[   84.134639]  exit_to_usermode_loop+0xcf/0x100
[   84.134639]  do_syscall_64+0x147/0x170
[   84.134639]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   84.134639] RIP: 0033:0x555555558e3e
[   84.134639] Code: c4 00 00 00 0f 85 be 00 00 00 89 c7 31 db ba c8 00 00 00 be 01 00 00 00 eb 0c 66 90 75 1d 81 fb 30 75 00 00 74 71 89 d0 0f 05 <f2> 0f 10 05 ba c1 01 00 83 c3 01 66 0f 2e c1 7b e1 31 c0 41 89 d8
[   84.134639] RSP: 002b:00007fffffffe990 EFLAGS: 00000283 ORIG_RAX: 00000000000000c8
[   84.134639] RAX: 0000000000000000 RBX: 0000000000006b28 RCX: 0000555555558e3e
[   84.134639] RDX: 00000000000000c8 RSI: 0000000000000001 RDI: 0000000000001178
[   84.134639] RBP: 0000555555558d10 R08: 00007ffff7815700 R09: 00007ffff7815700
[   84.134639] R10: 00007ffff78159d0 R11: 0000000000000283 R12: 00007fffffffe9a8
[   84.134639] R13: 0000000000000000 R14: 00007ffff7fdd690 R15: 0000000000000000
[   84.134639] 
[   84.134639] Allocated by task 4475:
[   84.134639]  save_stack+0x19/0x80
[   84.134639]  __kasan_kmalloc.constprop.5+0xf0/0x100
[   84.134639]  kmem_cache_alloc+0xc4/0x1b0
[   84.134639]  vm_area_dup+0x1b/0x80
[   84.134639]  __split_vma+0x78/0x290
[   84.134639]  mprotect_fixup+0x3d2/0x480
[   84.134639]  do_mprotect_pkey.constprop.31+0x1d0/0x310
[   84.134639]  __x64_sys_mprotect+0x4c/0x70
[   84.134639]  do_syscall_64+0x63/0x170
[   84.134639]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   84.134639] 
[   84.134639] Freed by task 4475:
[   84.134639]  save_stack+0x19/0x80
[   84.134639]  __kasan_slab_free+0x12c/0x180
[   84.134639]  kmem_cache_free+0x75/0x1d0
[   84.134639]  __vma_adjust+0x587/0xb00
[   84.134639]  vma_merge+0x4e7/0x580
[   84.134639]  mprotect_fixup+0x273/0x480
[   84.134639]  do_mprotect_pkey.constprop.31+0x1d0/0x310
[   84.134639]  __x64_sys_mprotect+0x4c/0x70
[   84.134639]  do_syscall_64+0x63/0x170
[   84.134639]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   84.134639] 
[   84.134639] The buggy address belongs to the object at ffff888068295100
[   84.134639]  which belongs to the cache vm_area_struct of size 192
[   84.134639] The buggy address is located 136 bytes inside of
[   84.134639]  192-byte region [ffff888068295100, ffff8880682951c0)
[   84.134639] The buggy address belongs to the page:
[   84.134639] page:ffffea0001a0a500 count:1 mapcount:0 mapping:ffff88806cd7fe00 index:0x0 compound_mapcount: 0
[   84.134639] flags: 0x3ffe000000010200(slab|head)
[   84.134639] raw: 3ffe000000010200 0000000000000000 0000001700000001 ffff88806cd7fe00
[   84.134639] raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
[   84.134639] page dumped because: kasan: bad access detected
[   84.134639] 
[   84.134639] Memory state around the buggy address:
[   84.134639]  ffff888068295080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[   84.134639]  ffff888068295100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   84.134639] >ffff888068295180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[   84.134639]                       ^
[   84.134639]  ffff888068295200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   84.134639]  ffff888068295280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[   84.134639] ==================================================================
[   84.134639] Disabling lock debugging due to kernel taint

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
