Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE48A75FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 09:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfGZH0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 03:26:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2765 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726323AbfGZH0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:26:22 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F0961D2C6880CA9EA506;
        Fri, 26 Jul 2019 15:26:19 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Jul 2019
 15:26:13 +0800
Subject: Re: [RFC PATCH 00/10] implement KASLR for powerpc/fsl_booke/32
To:     Diana Madalina Craciun <diana.craciun@nxp.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "yebin10@huawei.com" <yebin10@huawei.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "jingxiangfeng@huawei.com" <jingxiangfeng@huawei.com>,
        "fanchengyang@huawei.com" <fanchengyang@huawei.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
References: <20190717080621.40424-1-yanaijie@huawei.com>
 <e6ad41bc-5d5a-cf3f-b308-e1863b4fef99@huawei.com>
 <VI1PR0401MB24632CD6AB1C5EDCFF817705FFC00@VI1PR0401MB2463.eurprd04.prod.outlook.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <b50275ae-9eb8-11da-248c-1ad7dbf93469@huawei.com>
Date:   Fri, 26 Jul 2019 15:26:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB24632CD6AB1C5EDCFF817705FFC00@VI1PR0401MB2463.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/26 15:04, Diana Madalina Craciun wrote:
> Hi Jason,
> 
> I have briefly tested yesterday on a P4080 board and did not see any
> issues. I do not have much expertise on KASLR, but I will take a look
> over the code.
> 

Hi Diana, thanks. Looking forward to your suggestions.

> Regards,
> Diana
> 
> On 7/25/2019 10:16 AM, Jason Yan wrote:
>> Hi all, any comments?
>>
>>
>> On 2019/7/17 16:06, Jason Yan wrote:
>>> This series implements KASLR for powerpc/fsl_booke/32, as a security
>>> feature that deters exploit attempts relying on knowledge of the location
>>> of kernel internals.
>>>
>>> Since CONFIG_RELOCATABLE has already supported, what we need to do is
>>> map or copy kernel to a proper place and relocate. Freescale Book-E
>>> parts expect lowmem to be mapped by fixed TLB entries(TLB1). The TLB1
>>> entries are not suitable to map the kernel directly in a randomized
>>> region, so we chose to copy the kernel to a proper place and restart to
>>> relocate.
>>>
>>> Entropy is derived from the banner and timer base, which will change every
>>> build and boot. This not so much safe so additionally the bootloader may
>>> pass entropy via the /chosen/kaslr-seed node in device tree.
>>>
>>> We will use the first 512M of the low memory to randomize the kernel
>>> image. The memory will be split in 64M zones. We will use the lower 8
>>> bit of the entropy to decide the index of the 64M zone. Then we chose a
>>> 16K aligned offset inside the 64M zone to put the kernel in.
>>>
>>>       KERNELBASE
>>>
>>>           |-->   64M   <--|
>>>           |               |
>>>           +---------------+    +----------------+---------------+
>>>           |               |....|    |kernel|    |               |
>>>           +---------------+    +----------------+---------------+
>>>           |                         |
>>>           |----->   offset    <-----|
>>>
>>>                                 kimage_vaddr
>>>
>>> We also check if we will overlap with some areas like the dtb area, the
>>> initrd area or the crashkernel area. If we cannot find a proper area,
>>> kaslr will be disabled and boot from the original kernel.
>>>
>>> Jason Yan (10):
>>>     powerpc: unify definition of M_IF_NEEDED
>>>     powerpc: move memstart_addr and kernstart_addr to init-common.c
>>>     powerpc: introduce kimage_vaddr to store the kernel base
>>>     powerpc/fsl_booke/32: introduce create_tlb_entry() helper
>>>     powerpc/fsl_booke/32: introduce reloc_kernel_entry() helper
>>>     powerpc/fsl_booke/32: implement KASLR infrastructure
>>>     powerpc/fsl_booke/32: randomize the kernel image offset
>>>     powerpc/fsl_booke/kaslr: clear the original kernel if randomized
>>>     powerpc/fsl_booke/kaslr: support nokaslr cmdline parameter
>>>     powerpc/fsl_booke/kaslr: dump out kernel offset information on panic
>>>
>>>    arch/powerpc/Kconfig                          |  11 +
>>>    arch/powerpc/include/asm/nohash/mmu-book3e.h  |  10 +
>>>    arch/powerpc/include/asm/page.h               |   7 +
>>>    arch/powerpc/kernel/Makefile                  |   1 +
>>>    arch/powerpc/kernel/early_32.c                |   2 +-
>>>    arch/powerpc/kernel/exceptions-64e.S          |  10 -
>>>    arch/powerpc/kernel/fsl_booke_entry_mapping.S |  23 +-
>>>    arch/powerpc/kernel/head_fsl_booke.S          |  61 ++-
>>>    arch/powerpc/kernel/kaslr_booke.c             | 439 ++++++++++++++++++
>>>    arch/powerpc/kernel/machine_kexec.c           |   1 +
>>>    arch/powerpc/kernel/misc_64.S                 |   5 -
>>>    arch/powerpc/kernel/setup-common.c            |  23 +
>>>    arch/powerpc/mm/init-common.c                 |   7 +
>>>    arch/powerpc/mm/init_32.c                     |   5 -
>>>    arch/powerpc/mm/init_64.c                     |   5 -
>>>    arch/powerpc/mm/mmu_decl.h                    |  10 +
>>>    arch/powerpc/mm/nohash/fsl_booke.c            |   8 +-
>>>    17 files changed, 580 insertions(+), 48 deletions(-)
>>>    create mode 100644 arch/powerpc/kernel/kaslr_booke.c
>>>
>>
> 
> 
> .
> 

