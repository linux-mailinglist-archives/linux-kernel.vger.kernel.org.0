Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181617A4EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 11:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbfG3Jop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 05:44:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:25682 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfG3Joo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:44:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45yWqY4NmFz9vBLV;
        Tue, 30 Jul 2019 11:44:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=f1cEUQin; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id iGCYl8cF8axD; Tue, 30 Jul 2019 11:44:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45yWqY370Rz9vBLN;
        Tue, 30 Jul 2019 11:44:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1564479881; bh=VdYKK+YSpvMaj6YTHxEjAE3L6fR8opLRNMn0FGSQBcg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=f1cEUQinoonCEuYv57Lh3FcFKWxydZE4rtPElNT27QTsBUBPliVDKXNyy9cds+wmI
         Vg4w95bSX+AzVtqqUvszg4k2OLt1q9JufqylY7weAM24O+yVOsGjOvg5IEtvY+from
         nwIuRrfUDHV1LissnP93YcBRc7DjIx08t4xQ8psE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 923DE8B803;
        Tue, 30 Jul 2019 11:44:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tsqn-8Xg7D6M; Tue, 30 Jul 2019 11:44:42 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 467628B801;
        Tue, 30 Jul 2019 11:44:42 +0200 (CEST)
Subject: Re: [PATCH v2 07/10] powerpc/fsl_booke/32: randomize the kernel image
 offset
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        yebin10@huawei.com, thunder.leizhen@huawei.com,
        jingxiangfeng@huawei.com, fanchengyang@huawei.com,
        zhaohongjiang@huawei.com
References: <20190730074225.39544-1-yanaijie@huawei.com>
 <20190730074225.39544-8-yanaijie@huawei.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b41c4650-ef30-6f02-d5b3-bc95c5ad3ce0@c-s.fr>
Date:   Tue, 30 Jul 2019 11:44:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730074225.39544-8-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 30/07/2019 à 09:42, Jason Yan a écrit :
> After we have the basic support of relocate the kernel in some
> appropriate place, we can start to randomize the offset now.
> 
> Entropy is derived from the banner and timer, which will change every
> build and boot. This not so much safe so additionally the bootloader may
> pass entropy via the /chosen/kaslr-seed node in device tree.
> 
> We will use the first 512M of the low memory to randomize the kernel
> image. The memory will be split in 64M zones. We will use the lower 8
> bit of the entropy to decide the index of the 64M zone. Then we chose a
> 16K aligned offset inside the 64M zone to put the kernel in.
> 
>      KERNELBASE
> 
>          |-->   64M   <--|
>          |               |
>          +---------------+    +----------------+---------------+
>          |               |....|    |kernel|    |               |
>          +---------------+    +----------------+---------------+
>          |                         |
>          |----->   offset    <-----|
> 
>                                kimage_vaddr
> 
> We also check if we will overlap with some areas like the dtb area, the
> initrd area or the crashkernel area. If we cannot find a proper area,
> kaslr will be disabled and boot from the original kernel.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Cc: Diana Craciun <diana.craciun@nxp.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>   arch/powerpc/kernel/kaslr_booke.c | 334 +++++++++++++++++++++++++++++-
>   1 file changed, 332 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kaslr_booke.c b/arch/powerpc/kernel/kaslr_booke.c
> index 960bce4aa8b9..0bb02e45b928 100644
> --- a/arch/powerpc/kernel/kaslr_booke.c
> +++ b/arch/powerpc/kernel/kaslr_booke.c
> @@ -23,6 +23,8 @@
>   #include <linux/delay.h>
>   #include <linux/highmem.h>
>   #include <linux/memblock.h>
> +#include <linux/libfdt.h>
> +#include <linux/crash_core.h>
>   #include <asm/pgalloc.h>
>   #include <asm/prom.h>
>   #include <asm/io.h>
> @@ -34,15 +36,341 @@
>   #include <asm/machdep.h>
>   #include <asm/setup.h>
>   #include <asm/paca.h>
> +#include <asm/kdump.h>
>   #include <mm/mmu_decl.h>
> +#include <generated/compile.h>
> +#include <generated/utsrelease.h>
> +
> +#ifdef DEBUG
> +#define DBG(fmt...) printk(KERN_ERR fmt)
> +#else
> +#define DBG(fmt...)
> +#endif
> +
> +struct regions {
> +	unsigned long pa_start;
> +	unsigned long pa_end;
> +	unsigned long kernel_size;
> +	unsigned long dtb_start;
> +	unsigned long dtb_end;
> +	unsigned long initrd_start;
> +	unsigned long initrd_end;
> +	unsigned long crash_start;
> +	unsigned long crash_end;
> +	int reserved_mem;
> +	int reserved_mem_addr_cells;
> +	int reserved_mem_size_cells;
> +};
>   
>   extern int is_second_reloc;
>   
> +/* Simplified build-specific string for starting entropy. */
> +static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
> +		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
> +
> +static __init void kaslr_get_cmdline(void *fdt)
> +{
> +	const char *cmdline = CONFIG_CMDLINE;
> +	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
> +		int node;
> +		const u8 *prop;
> +		node = fdt_path_offset(fdt, "/chosen");
> +		if (node < 0)
> +			goto out;
> +
> +		prop = fdt_getprop(fdt, node, "bootargs", NULL);
> +		if (!prop)
> +			goto out;
> +		cmdline = prop;
> +	}
> +out:
> +	strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);

boot_command_line is set by early_init_devtree() in 
arch/powerpc/kernel/prom.c
Is that too late for you ?

If so, what about calling early_init_dt_scan_chosen() instead of recoding ?

Christophe
