Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147D915F3CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 19:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393597AbgBNSPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 13:15:31 -0500
Received: from foss.arm.com ([217.140.110.172]:42868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389512AbgBNSP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:15:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5531C328;
        Fri, 14 Feb 2020 10:15:29 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F09B3F68E;
        Fri, 14 Feb 2020 10:15:28 -0800 (PST)
Subject: Re: RPI4: fail too boot with an initrd
To:     LABBE Corentin <clabbe@baylibre.com>
References: <20200214132748.GA23276@Red>
Cc:     u-boot@lists.denx.de, nsaenzjulienne@suse.de,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   James Morse <james.morse@arm.com>
Message-ID: <b726290c-1038-3771-5187-6ac370bc92c9@arm.com>
Date:   Fri, 14 Feb 2020 18:15:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200214132748.GA23276@Red>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

On 14/02/2020 13:27, LABBE Corentin wrote:
> Since the inclusion of the "enable network support in RPi4 config" serie on uboot, I
> have started to work on adding the rpi4 in kernelCI.
> But I fail to succeed in using a kernel/dtb/ramdisk downloaded via tftp.
> 
> Using booti I hit:
> [    0.000000] Linux version 5.6.0-rc1-next-20200212 (clabbe@build2-bionic-1804) (gcc version 7.4.1 20181213 [linaro-7.4-2019.02 revision 56ec6f6b99cc167ff0c2f8e1a2eed33b1edc85d4] (Linaro    GCC 7.4-2019.02)) #66 SMP PREEMPT Wed Feb 12 10:14:20 UTC 2020
> [    0.000000] Machine model: Raspberry Pi 4 Model B
> [    0.000000] earlycon: uart0 at MMIO32 0x00000000fe215040 (options '')
> [    0.000000] printk: bootconsole [uart0] enabled
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: UEFI not found.

So no EFI,

> [    0.000000] OF: reserved mem: failed to allocate memory for node 'linux,cma'

Out of memory.

> [    0.000000] cma: Failed to reserve 32 MiB
> [    0.000000] Kernel panic - not syncing: Failed to allocate page table page

Out of memory...

> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.6.0-rc1-next-20200212 #66
> [    0.000000] Hardware name: Raspberry Pi 4 Model B (DT)
> [    0.000000] Call trace:
> [    0.000000]  dump_backtrace+0x0/0x1a0
> [    0.000000]  show_stack+0x14/0x20
> [    0.000000]  dump_stack+0xbc/0x104
> [    0.000000]  panic+0x16c/0x37c
> [    0.000000]  early_pgtable_alloc+0x30/0xa0

... really early!

> [    0.000000]  __create_pgd_mapping+0x36c/0x588
> [    0.000000]  map_kernel_segment+0x70/0xa4
> [    0.000000]  paging_init+0xf4/0x528
> [    0.000000]  setup_arch+0x250/0x5d8
> [    0.000000]  start_kernel+0x90/0x6d8
> 
>  
> Since the same kernel boot with bootefi and that bootefi lack ramdisk address,

Booting with EFI will cause linux to use the EFI memory map.

Does your DT have a memory node? (or does it expect EFI to provide the information)


> I tried to add the address in the dtb via:
> fdt addr 0x02400000; fdt resize; fdt set /chosen linux,initrd-start 0x02700000; fdt set /chosen linux,initrd-end 0x10000000; bootefi 0x00080000 0x02400000
> But with that, I get:
> initrd not fully accessible via the linear mapping -- please check your bootloader ...

So this one is an EFI boot, but you can't find where to put the initramfs such that the
kernel agrees its in memory.

If you boot with 'efi=debug', linux will print the EFI memory map. Could you compare that
to where U-Boot thinks memory is?

(it sounds like your DT memory node is missing, and your EFI memory map is surprisingly small)


Thanks,

James
