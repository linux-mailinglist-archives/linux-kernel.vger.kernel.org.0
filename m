Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F4481819
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 13:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfHELYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 07:24:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:56520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727158AbfHELYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:24:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A560EAEFD;
        Mon,  5 Aug 2019 11:24:38 +0000 (UTC)
Date:   Mon, 5 Aug 2019 13:24:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pankaj.suryawanshi@einfochips.com
Subject: Re: oom-killer
Message-ID: <20190805112437.GF7597@dhcp22.suse.cz>
References: <CACDBo54Jbueeq1XbtbrFOeOEyF-Q4ipZJab8mB7+0cyK1Foqyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACDBo54Jbueeq1XbtbrFOeOEyF-Q4ipZJab8mB7+0cyK1Foqyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 03-08-19 18:53:50, Pankaj Suryawanshi wrote:
> Hello,
> 
> Below are the logs from oom-kller. I am not able to interpret/decode the
> logs as well as not able to find root cause of oom-killer.
> 
> Note: CPU Arch: Arm 32-bit , Kernel - 4.14.65

Fixed up line wrapping and trimmed to the bare minimum

> [  727.941258] kworker/u8:2 invoked oom-killer: gfp_mask=0x15080c0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), nodemask=(null),  order=1, oom_score_adj=0

This tells us that this is order 1 (two physically contiguous pages)
request restricted to GFP_KERNEL (GFP_KERNEL_ACCOUNT is GFP_KERNEL |
__GFP_ACCOUNT) and that means that the request can be satisfied only
from the low memory zone. This is important because you are running 32b
system and that means that only low 1G is directly addressable by the
kernel. The rest is in highmem.

> [  727.954355] CPU: 0 PID: 56 Comm: kworker/u8:2 Tainted: P           O  4.14.65 #606
[...]
> [  728.029390] [<c034a094>] (oom_kill_process) from [<c034af24>] (out_of_memory+0x140/0x368)
> [  728.037569]  r10:00000001 r9:c12169bc r8:00000041 r7:c121e680 r6:c1216588 r5:dd347d7c > [  728.045392]  r4:d5737080
> [  728.047929] [<c034ade4>] (out_of_memory) from [<c03519ac>]  (__alloc_pages_nodemask+0x1178/0x124c)
> [  728.056798]  r7:c141e7d0 r6:c12166a4 r5:00000000 r4:00001155
> [  728.062460] [<c0350834>] (__alloc_pages_nodemask) from [<c021e9d4>] (copy_process.part.5+0x114/0x1a28)
> [  728.071764]  r10:00000000 r9:dd358000 r8:00000000 r7:c1447e08 r6:c1216588 r5:00808111
> [  728.079587]  r4:d1063c00
> [  728.082119] [<c021e8c0>] (copy_process.part.5) from [<c0220470>] (_do_fork+0xd0/0x464)
> [  728.090034]  r10:00000000 r9:00000000 r8:dd008400 r7:00000000 r6:c1216588 r5:d2d58ac0
> [  728.097857]  r4:00808111

The call trace tells that this is a fork (of a usermodhlper but that is
not all that important.
[...]
> [  728.260031] DMA free:17960kB min:16384kB low:25664kB high:29760kB active_anon:3556kB inactive_anon:0kB active_file:280kB inactive_file:28kB unevictable:0kB writepending:0kB present:458752kB managed:422896kB mlocked:0kB kernel_stack:6496kB pagetables:9904kB bounce:0kB free_pcp:348kB local_pcp:0kB free_cma:0kB
> [  728.287402] lowmem_reserve[]: 0 0 579 579

So this is the only usable zone and you are close to the min watermark
which means that your system is under a serious memory pressure but not
yet under OOM for order-0 request. The situation is not great though
because there is close to no reclaimable memory (look at *_anon, *_file)
counters and it is quite likely that compaction will stubmle over
unmovable pages very often as well.

> [  728.326634] DMA: 71*4kB (EH) 113*8kB (UH) 207*16kB (UMH) 103*32kB (UMH) 70*64kB (UMH) 27*128kB (UMH) 5*256kB (UMH) 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB 0*8192kB 0*16384kB = 17524kB

This is more interesting because there seem to be order-1+ blocks to
be used for this allocation. H stands for High atomic reserve, U for
unmovable blocks and GFP_KERNEL belong to such an allocation and M is
for movable pageblock (see show_migration_types for all migration
types). From the above it would mean that the allocation should pass
through but note that the information is dumped after the last watermark
check so the situation might have changed.

In any case your system seems to be tight on the lowmem and I would
expect it could get to OOM in peak memory demand on top of the current
state.

-- 
Michal Hocko
SUSE Labs
