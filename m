Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 700C81999BD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 17:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbgCaPci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 11:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730607AbgCaPch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:32:37 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC7E420848;
        Tue, 31 Mar 2020 15:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585668757;
        bh=bmkXYYgvw1XSZNm/X50bQ/Cgpms8RFKqYh9xAdP+cuY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q5+DuvjwofW/NxsUc3JfbmW7ShRD98IQBS2DvV2tbKVdx34U3F2S1b/WmFoRj5URf
         nvrLLjyuoP7a/EhQImwcMauBCl1aEqWZmjT9GRsBTt/Q6E1EDTgiITIKLh/4HjT6c3
         e4cP43e6tVvv2svOgg0kMqbeOUi9bA2o3wbrGEa8=
Date:   Wed, 1 Apr 2020 00:32:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] riscv: introduce interfaces to patch kernel code
Message-Id: <20200401003233.17fe4b6f7075e5b8f0ed5114@kernel.org>
In-Reply-To: <d27d9e68491e1df67dbee6c22df6a72ff95bab18.1583772574.git.zong.li@sifive.com>
References: <cover.1583772574.git.zong.li@sifive.com>
        <d27d9e68491e1df67dbee6c22df6a72ff95bab18.1583772574.git.zong.li@sifive.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 10 Mar 2020 00:55:43 +0800
Zong Li <zong.li@sifive.com> wrote:

> On strict kernel memory permission, we couldn't patch code without
> writable permission. Preserve two holes in fixmap area, so we can map
> the kernel code temporarily to fixmap area, then patch the instructions.
> 
> We need two pages here because we support the compressed instruction, so
> the instruction might be align to 2 bytes. When patching the 32-bit
> length instruction which is 2 bytes alignment, it will across two pages.
> 
> Introduce two interfaces to patch kernel code:
> riscv_patch_text_nosync:
>  - patch code without synchronization, it's caller's responsibility to
>    synchronize all CPUs if needed.
> riscv_patch_text:
>  - patch code and always synchronize with stop_machine()
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/include/asm/fixmap.h |   2 +
>  arch/riscv/include/asm/patch.h  |  12 ++++
>  arch/riscv/kernel/Makefile      |   4 +-
>  arch/riscv/kernel/patch.c       | 120 ++++++++++++++++++++++++++++++++
>  4 files changed, 137 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/patch.h
>  create mode 100644 arch/riscv/kernel/patch.c
> 
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 42d2c42f3cc9..2368d49eb4ef 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -27,6 +27,8 @@ enum fixed_addresses {
>  	FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
>  	FIX_PTE,
>  	FIX_PMD,
> +	FIX_TEXT_POKE1,
> +	FIX_TEXT_POKE0,
>  	FIX_EARLYCON_MEM_BASE,
>  	__end_of_fixed_addresses
>  };
> diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
> new file mode 100644
> index 000000000000..b5918a6e0615
> --- /dev/null
> +++ b/arch/riscv/include/asm/patch.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 SiFive
> + */
> +
> +#ifndef _ASM_RISCV_PATCH_H
> +#define _ASM_RISCV_PATCH_H
> +
> +int riscv_patch_text_nosync(void *addr, const void *insns, size_t len);
> +int riscv_patch_text(void *addr, u32 insn);
> +
> +#endif /* _ASM_RISCV_PATCH_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f40205cb9a22..d189bd3d8501 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -4,7 +4,8 @@
>  #
>  
>  ifdef CONFIG_FTRACE
> -CFLAGS_REMOVE_ftrace.o = -pg
> +CFLAGS_REMOVE_ftrace.o	= -pg
> +CFLAGS_REMOVE_patch.o	= -pg
>  endif
>  
>  extra-y += head.o
> @@ -26,6 +27,7 @@ obj-y	+= traps.o
>  obj-y	+= riscv_ksyms.o
>  obj-y	+= stacktrace.o
>  obj-y	+= cacheinfo.o
> +obj-y	+= patch.o
>  obj-$(CONFIG_MMU) += vdso.o vdso/
>  
>  obj-$(CONFIG_RISCV_M_MODE)	+= clint.o
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> new file mode 100644
> index 000000000000..8a4fc65ee022
> --- /dev/null
> +++ b/arch/riscv/kernel/patch.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 SiFive
> + */
> +
> +#include <linux/spinlock.h>
> +#include <linux/mm.h>
> +#include <linux/uaccess.h>
> +#include <linux/stop_machine.h>
> +#include <asm/kprobes.h>
> +#include <asm/cacheflush.h>
> +#include <asm/fixmap.h>
> +
> +struct riscv_insn_patch {
> +	void *addr;
> +	u32 insn;
> +	atomic_t cpu_count;
> +};
> +
> +#ifdef CONFIG_MMU
> +static DEFINE_RAW_SPINLOCK(patch_lock);
> +
> +static void __kprobes *patch_map(void *addr, int fixmap)

Please use NOKPROBE_SYMBOL() instead of __kprobes. __kprobes is old style.

> +{
> +	uintptr_t uintaddr = (uintptr_t) addr;
> +	struct page *page;
> +
> +	if (core_kernel_text(uintaddr))
> +		page = phys_to_page(__pa_symbol(addr));
> +	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> +		page = vmalloc_to_page(addr);
> +	else
> +		return addr;
> +
> +	BUG_ON(!page);
> +
> +	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
> +					 (uintaddr & ~PAGE_MASK));
> +}
> +
> +static void __kprobes patch_unmap(int fixmap)
> +{
> +	clear_fixmap(fixmap);
> +}
> +
> +static int __kprobes riscv_insn_write(void *addr, const void *insn, size_t len)

Why would you add "riscv_" prefix for those functions? It seems a bit odd.

> +{
> +	void *waddr = addr;
> +	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
> +	unsigned long flags = 0;
> +	int ret;
> +
> +	raw_spin_lock_irqsave(&patch_lock, flags);

This looks a bit odd since stop_machine() is protected by its own mutex,
and also the irq is already disabled here.

Thank you,

> +
> +	if (across_pages)
> +		patch_map(addr + len, FIX_TEXT_POKE1);
> +
> +	waddr = patch_map(addr, FIX_TEXT_POKE0);
> +
> +	ret = probe_kernel_write(waddr, insn, len);
> +
> +	patch_unmap(FIX_TEXT_POKE0);
> +
> +	if (across_pages)
> +		patch_unmap(FIX_TEXT_POKE1);
> +
> +	raw_spin_unlock_irqrestore(&patch_lock, flags);
> +
> +	return ret;
> +}
> +#else
> +static int __kprobes riscv_insn_write(void *addr, const void *insn, size_t len)
> +{
> +	return probe_kernel_write(addr, insn, len);
> +}
> +#endif /* CONFIG_MMU */
> +
> +int __kprobes riscv_patch_text_nosync(void *addr, const void *insns, size_t len)
> +{
> +	u32 *tp = addr;
> +	int ret;
> +
> +	ret = riscv_insn_write(tp, insns, len);
> +
> +	if (!ret)
> +		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
> +
> +	return ret;
> +}
> +
> +static int __kprobes riscv_patch_text_cb(void *data)
> +{
> +	struct riscv_insn_patch *patch = data;
> +	int ret = 0;
> +
> +	if (atomic_inc_return(&patch->cpu_count) == 1) {
> +		ret =
> +		    riscv_patch_text_nosync(patch->addr, &patch->insn,
> +					    GET_INSN_LENGTH(patch->insn));
> +		atomic_inc(&patch->cpu_count);
> +	} else {
> +		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
> +			cpu_relax();
> +		smp_mb();
> +	}
> +
> +	return ret;
> +}
> +
> +int __kprobes riscv_patch_text(void *addr, u32 insn)
> +{
> +	struct riscv_insn_patch patch = {
> +		.addr = addr,
> +		.insn = insn,
> +		.cpu_count = ATOMIC_INIT(0),
> +	};
> +
> +	return stop_machine_cpuslocked(riscv_patch_text_cb,
> +				       &patch, cpu_online_mask);
> +}
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
