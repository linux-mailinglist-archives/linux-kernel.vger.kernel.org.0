Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78E1ADF7C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 21:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405704AbfIITel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 15:34:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:43855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731156AbfIITel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 15:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568057627;
        bh=d4t6NvwMQ9YTypUWgwkNC+7VlgA/JtZpt8GrsPSKCHs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hMUpmG5bI7Ecc5qn5YxStKIYidbTDxDpIrG5t0X1WwthOKMSGEFnXbVwz2DSNffOa
         Sv8dyTkSeSeYMwFeuT2tmsZhrWzWS2lNLvaSMgvZ+8LtrhLlXGqZKkb/ZXcVFVfPAl
         e1W0am+4D0QCIP+kg00x2jQkHxmtfpcqdGHHqP+w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.90]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfjJY-1hkOv10G4S-00NDN8; Mon, 09
 Sep 2019 21:33:47 +0200
Subject: Re: [PATCH v5 0/4] Raspberry Pi 4 DMA addressing support
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        catalin.marinas@arm.com, hch@lst.de, marc.zyngier@arm.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
Cc:     f.fainelli@gmail.com, will@kernel.org,
        linux-kernel@vger.kernel.org, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, phill@raspberrypi.org,
        robin.murphy@arm.com, m.szyprowski@samsung.com
References: <20190909095807.18709-1-nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <5a8af6e9-6b90-ce26-ebd7-9ee626c9fa0e@gmx.net>
Date:   Mon, 9 Sep 2019 21:33:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909095807.18709-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:LS01oHKQzcvClmAtuMiV35GzDWGQjl4TMocrZcQk6DA6HAVrjMq
 joLIBQ7XFMXVpIeH/MS6IOvr05uJoNzY1DAliZFeoVMG1Smed9yI3/EPqAlOvnZYq+y4ifa
 1I+hzKfFlkjxIEeh48LA8fJ8+IW5/n72kNXSELzZybJBa7s3kQ74+muskUQhSuquNeriMTy
 XJfBatyvN85xpY5hnhDdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8DJJrmG3oug=:r20bBXJ9yriqQL0K7dlYtr
 3D5nkd2eNwi/fPIc7nA/XReM5DD2ystesZjI9WG/JWxtWZdVDqHxCXgsdG9upl0LqHxhPRWl2
 IoruO8dbxq2k9VpIfNo6q4WCvXtkCGKKsw3sH6oNySDjjYT6mZusv7UXmfHa0ovSI12/tyJNF
 OOZEkPvsa0wmVJ0R9v1XPZRNqH1eASiHW+iVlt/tB8NniA3l5NBhPYbYb9A3RtBjKmbDLZ2fh
 8+Kl9rh8JTvTgYcYKvF7i6fvXP9dJGs3ngxG+VI6VNtd1UsjcOj6HWI15CHZAaI0355vx7e+W
 ilwfYTgk0Ma1/6qI0EfInxLskbi5eBScqF0zN/rnknI20HdCFwethoNTw0+IwAybm5l3UwXAO
 AM9wUDmOGpXmAZFJhwHv0AW19s5t/ls0/XSr5XFmSl+urCrBLgkPcZ9BpUqXVF61h7a0IJ9c3
 vTmEd8/Wqk3gPrHkAulh/i0IDJfnrBYJFMu5cBLFIRU9L712b3+pkTe5wa2p7jKYvOUwH1R8C
 ALrokkoKreKkpotBT1Wsvgt+zLiHVr5Qu6134HCzGxj/jFln7a38J15ryJlaoEWj6xlXJaY5Y
 CpuXNF2mIRbRPoTDFkejvgHl/XDalzWfCh7pHDsl/wiBfUZAl6CNPHfjYKlxwQtU0DksbtlgK
 PP0UCzTwxEz0y/6CC+wlQfzGLv+iciCgw/bh6P54tMKmlxcIORsIiwzp0WsfICSPiSNNRA7b+
 gJImh/7edE5WeVs3jHJmk0zNCAljed+Y6pkB60wOgaQmFDoWHoJgUc6T/RRfIrjVpFD4f7ESQ
 NFIdgmkZ+ewXmvphXZpkC/kQ+b5umYYh8LAAu2IjmAC+NpVd2uqKGicmytJkmOl222yRcvS/i
 KxTvBPrPPOk8/UOGm74aUUxwB/WppNLQ/4sofAEQ53FOsXJ68c9YKnSwZKpUj3/ALYd22bFGN
 JM1GFT7CylIv1mlwb0SbD6PVHtccl4U7LVjkAh/OzirSupflS+QcIPLiDDdmWW7hsXYU2+bwk
 DkkoVrlTPhN4e3autQhPV2XrcsKf4pJePsFukIGhvvClKgUYrNQ2kyEwUV0mt2JiS5Gz0n6WZ
 pbUk1x1giL3IYcwkMwR3QV1KowVLihGeVN7uJ6LB+yEHapvBIqAHAxh4rEyq6qZ0wluGpNfAM
 RCCSySDoWoGQs49i1yGfO0WkT+22+w6nWSaDNcr32p+OEUFCd2Yvrc+Mfa6zY2E7Efv3o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Am 09.09.19 um 11:58 schrieb Nicolas Saenz Julienne:
> Hi all,
> this series attempts to address some issues we found while bringing up
> the new Raspberry Pi 4 in arm64 and it's intended to serve as a follow
> up of these discussions:
> v4: https://lkml.org/lkml/2019/9/6/352
> v3: https://lkml.org/lkml/2019/9/2/589
> v2: https://lkml.org/lkml/2019/8/20/767
> v1: https://lkml.org/lkml/2019/7/31/922
> RFC: https://lkml.org/lkml/2019/7/17/476
>
> The new Raspberry Pi 4 has up to 4GB of memory but most peripherals can
> only address the first GB: their DMA address range is
> 0xc0000000-0xfc000000 which is aliased to the first GB of physical
> memory 0x00000000-0x3c000000. Note that only some peripherals have these
> limitations: the PCIe, V3D, GENET, and 40-bit DMA channels have a wider
> view of the address space by virtue of being hooked up trough a second
> interconnect.
>
> Part of this is solved on arm32 by setting up the machine specific
> '.dma_zone_size = SZ_1G', which takes care of reserving the coherent
> memory area at the right spot. That said no buffer bouncing (needed for
> dma streaming) is available at the moment, but that's a story for
> another series.
>
> Unfortunately there is no such thing as 'dma_zone_size' in arm64. Only
> ZONE_DMA32 is created which is interpreted by dma-direct and the arm64
> arch code as if all peripherals where be able to address the first 4GB
> of memory.
>
> In the light of this, the series implements the following changes:
>
> - Create both DMA zones in arm64, ZONE_DMA will contain the first 1G
>   area and ZONE_DMA32 the rest of the 32 bit addressable memory. So far
>   the RPi4 is the only arm64 device with such DMA addressing limitations
>   so this hardcoded solution was deemed preferable.
>
> - Properly set ARCH_ZONE_DMA_BITS.
>
> - Reserve the CMA area in a place suitable for all peripherals.
>
> This series has been tested on multiple devices both by checking the
> zones setup matches the expectations and by double-checking physical
> addresses on pages allocated on the three relevant areas GFP_DMA,
> GFP_DMA32, GFP_KERNEL:
>
> - On an RPi4 with variations on the ram memory size. But also forcing
>   the situation where all three memory zones are nonempty by setting a 3G
>   ZONE_DMA32 ceiling on a 4G setup. Both with and without NUMA support.
>
i like to test this series on Raspberry Pi 4 and i have some questions
to get arm64 running:

Do you use U-Boot? Which tree?
Are there any config.txt tweaks necessary?

