Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4DA921795
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 13:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfEQLU5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 May 2019 07:20:57 -0400
Received: from ozlabs.org ([203.11.71.1]:36533 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbfEQLU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 07:20:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4555Sk1dFjz9s3q;
        Fri, 17 May 2019 21:20:54 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     srikanth <sraithal@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     bharata@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: PROBLEM: Power9: kernel oops on memory hotunplug from ppc64le guest
In-Reply-To: <16a7a635-c592-27e2-75b4-d02071833278@linux.vnet.ibm.com>
References: <16a7a635-c592-27e2-75b4-d02071833278@linux.vnet.ibm.com>
Date:   Fri, 17 May 2019 21:20:53 +1000
Message-ID: <87h89t8gyy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

srikanth <sraithal@linux.vnet.ibm.com> writes:
> Hello,
>
> On power9 host, performing memory hotunplug from ppc64le guest results 
> in kernel oops.

Thanks for the report.

Did this used to work in the past? If so what is the last version that
worked?

> Kernel used : https://github.com/torvalds/linux/tree/v5.1 built using 
> ppc64le_defconfig for host and ppc64le_guest_defconfig for guest.
>
> Recreation steps:
>
> 1. Boot a guest with below mem configuration:
>    <maxMemory slots='32' unit='KiB'>33554432</maxMemory>
>    <memory unit='KiB'>8388608</memory>
>    <currentMemory unit='KiB'>4194304</currentMemory>
>    <cpu>
>      <numa>
>        <cell id='0' cpus='0-31' memory='8388608' unit='KiB'/>
>      </numa>
>    </cpu>
>
> 2. From host hotplug 8G memory -> verify memory hotadded succesfully -> 
> now reboot guest -> once guest comes back try to unplug 8G memory

I assume the reboot is required to trigger the bug? ie. if you unplug
without rebooting it doesn't crash?

> mem.xml used:
> <memory model='dimm'>
> <target>
> <size unit='GiB'>8</size>
> <node>0</node>
> </target>
> </memory>
>
> Memory attach and detach commands used:
>      virsh attach-device vm1 ./mem.xml --live
>      virsh detach-device vm1 ./mem.xml --live
>
> Trace seen inside guest after unplug, guest just hangs there forever:
>
> [   21.962986] kernel BUG at arch/powerpc/mm/pgtable-frag.c:113!
> [   21.963064] Oops: Exception in kernel mode, sig: 5 [#1]
> [   21.963090] LE PAGE_SIZE=64K MMU=Radix MMU=Hash SMP NR_CPUS=2048 NUMA 
> pSeries
> [   21.963131] Modules linked in: xt_tcpudp iptable_filter squashfs fuse 
> vmx_crypto ib_iser rdma_cm iw_cm ib_cm ib_core libiscsi 
> scsi_transport_iscsi ip_tables x_tables autofs4 btrfs zstd_decompress 
> zstd_compress lzo_compress raid10 raid456 async_raid6_recov async_memcpy 
> async_pq async_xor async_tx xor raid6_pq multipath crc32c_vpmsum
> [   21.963281] CPU: 11 PID: 316 Comm: kworker/u64:5 Kdump: loaded Not 
> tainted 5.1.0-dirty #2
> [   21.963323] Workqueue: pseries hotplug workque pseries_hp_work_fn
> [   21.963355] NIP:  c000000000079e18 LR: c000000000c79308 CTR: 
> 0000000000008000
> [   21.963392] REGS: c0000003f88034f0 TRAP: 0700   Not tainted (5.1.0-dirty)
> [   21.963422] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  
> CR: 28002884  XER: 20040000
> [   21.963470] CFAR: c000000000c79304 IRQMASK: 0
> [   21.963470] GPR00: c000000000c79308 c0000003f8803780 c000000001521000 
> 0000000000fff8c0

Can you try not to word wrap these, it makes them much harder to read.

There's some instructions here on configuring Thunderbird:
  https://www.kernel.org/doc/html/latest/process/email-clients.html#thunderbird-gui

> [   21.963470] GPR04: 0000000000000001 00000000ffe30005 0000000000000005 
> 0000000000000020
> [   21.963470] GPR08: 0000000000000000 0000000000000001 c00a000000fff8e0 
> c0000000016d21a0
> [   21.963470] GPR12: c0000000016e7b90 c000000007ff2700 c00a000000a00000 
> c0000003ffe30100
> [   21.963470] GPR16: c0000003ffe30000 c0000000014aa4de c00a0000009f0000 
> c0000000016d21b0
> [   21.963470] GPR20: c0000000014de588 0000000000000001 c0000000016d21b8 
> c00a000000a00000
> [   21.963470] GPR24: 0000000000000000 ffffffffffffffff c00a000000a00000 
> c0000003ffe96000
> [   21.963470] GPR28: c00a000000a00000 c00a000000a00000 c0000003fffec000 
> c00a000000fff8c0
> [   21.963802] NIP [c000000000079e18] pte_fragment_free+0x48/0xd0
> [   21.963838] LR [c000000000c79308] remove_pagetable+0x49c/0x5b4
> [   21.963873] Call Trace:
> [   21.963890] [c0000003f8803780] [c0000003ffe997f0] 0xc0000003ffe997f0 
> (unreliable)
> [   21.963933] [c0000003f88037b0] [0000000000000000] (null)
> [   21.963969] [c0000003f88038c0] [c00000000006f038] 
> vmemmap_free+0x218/0x2e0
> [   21.964006] [c0000003f8803940] [c00000000036f100] 
> sparse_remove_one_section+0xd0/0x138
> [   21.964050] [c0000003f8803980] [c000000000383a50] 
> __remove_pages+0x410/0x560
> [   21.964093] [c0000003f8803a90] [c000000000c784d8] 
> arch_remove_memory+0x68/0xdc
> [   21.964136] [c0000003f8803ad0] [c000000000385d74] 
> __remove_memory+0xc4/0x110
> [   21.964180] [c0000003f8803b10] [c0000000000d44e4] 
> dlpar_remove_lmb+0x94/0x140
> [   21.964223] [c0000003f8803b50] [c0000000000d52b4] 
> dlpar_memory+0x464/0xd00
> [   21.964259] [c0000003f8803be0] [c0000000000cd5c0] 
> handle_dlpar_errorlog+0xc0/0x190
> [   21.964303] [c0000003f8803c50] [c0000000000cd6bc] 
> pseries_hp_work_fn+0x2c/0x60
> [   21.964346] [c0000003f8803c80] [c00000000013a4a0] 
> process_one_work+0x2b0/0x5a0
> [   21.964388] [c0000003f8803d10] [c00000000013a818] 
> worker_thread+0x88/0x610
> [   21.964434] [c0000003f8803db0] [c000000000143884] kthread+0x1a4/0x1b0
> [   21.964468] [c0000003f8803e20] [c00000000000bdc4] 
> ret_from_kernel_thread+0x5c/0x78
> [   21.964506] Instruction dump:
> [   21.964527] fbe1fff8 f821ffd1 78638502 78633664 ebe90000 7fff1a14 
> 395f0020 813f0020
> [   21.964569] 7d2907b4 7d2900d0 79290fe0 69290001 <0b090000> 7c0004ac 
> 7d205028 3129ffff
> [   21.964613] ---[ end trace aaa571aa1636fee6 ]---
> [   21.966349]
> [   21.966383] Sending IPI to other CPUs
> [   21.978335] IPI complete
> [   21.981354] kexec: Starting switchover sequence.
> I'm in purgatory

It's not hung here, it's just not executing what we want it to :)

If you break into the qemu monitor and issue `info registers` it should
give you some idea of what's going on.

cheers
