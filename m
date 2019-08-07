Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4831084C4E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388125AbfHGNEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 09:04:12 -0400
Received: from ozlabs.org ([203.11.71.1]:44327 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388115AbfHGNEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:04:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463Wt146ZRz9sNy;
        Wed,  7 Aug 2019 23:04:09 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jason Yan <yanaijie@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        diana.craciun@nxp.com, christophe.leroy@c-s.fr,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        yebin10@huawei.com, thunder.leizhen@huawei.com,
        jingxiangfeng@huawei.com, fanchengyang@huawei.com,
        zhaohongjiang@huawei.com, Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH v5 06/10] powerpc/fsl_booke/32: implement KASLR infrastructure
In-Reply-To: <20190807065706.11411-7-yanaijie@huawei.com>
References: <20190807065706.11411-1-yanaijie@huawei.com> <20190807065706.11411-7-yanaijie@huawei.com>
Date:   Wed, 07 Aug 2019 23:04:05 +1000
Message-ID: <87wofpt9dm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Yan <yanaijie@huawei.com> writes:
> This patch add support to boot kernel from places other than KERNELBASE.
> Since CONFIG_RELOCATABLE has already supported, what we need to do is
> map or copy kernel to a proper place and relocate. Freescale Book-E
> parts expect lowmem to be mapped by fixed TLB entries(TLB1). The TLB1
> entries are not suitable to map the kernel directly in a randomized
> region, so we chose to copy the kernel to a proper place and restart to
> relocate.

So to be 100% clear you are randomising the location of the kernel in
virtual and physical space, by the same amount, and retaining the 1:1
linear mapping.

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 77f6ebf97113..755378887912 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -548,6 +548,17 @@ config RELOCATABLE
>  	  setting can still be useful to bootwrappers that need to know the
>  	  load address of the kernel (eg. u-boot/mkimage).
>  
> +config RANDOMIZE_BASE
> +	bool "Randomize the address of the kernel image"
> +	depends on (FSL_BOOKE && FLATMEM && PPC32)
> +	select RELOCATABLE

I think this should depend on RELOCATABLE, rather than selecting it.

> diff --git a/arch/powerpc/kernel/kaslr_booke.c b/arch/powerpc/kernel/kaslr_booke.c
> new file mode 100644
> index 000000000000..30f84c0321b2
> --- /dev/null
> +++ b/arch/powerpc/kernel/kaslr_booke.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2019 Jason Yan <yanaijie@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

You don't need that paragraph now that you have the SPDX tag.

Rather than using a '//' comment followed by a single line block comment
you can format it as:

// SPDX-License-Identifier: GPL-2.0-only
//
// Copyright (C) 2019 Jason Yan <yanaijie@huawei.com>


> +#include <linux/signal.h>
> +#include <linux/sched.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/ptrace.h>
> +#include <linux/mman.h>
> +#include <linux/mm.h>
> +#include <linux/swap.h>
> +#include <linux/stddef.h>
> +#include <linux/vmalloc.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/highmem.h>
> +#include <linux/memblock.h>
> +#include <asm/pgalloc.h>
> +#include <asm/prom.h>
> +#include <asm/io.h>
> +#include <asm/mmu_context.h>
> +#include <asm/pgtable.h>
> +#include <asm/mmu.h>
> +#include <linux/uaccess.h>
> +#include <asm/smp.h>
> +#include <asm/machdep.h>
> +#include <asm/setup.h>
> +#include <asm/paca.h>
> +#include <mm/mmu_decl.h>

Do you really need all those headers?

> +extern int is_second_reloc;

That should be in a header.

Any reason why it isn't a bool?

cheers

