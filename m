Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E21B019060F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 08:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgCXHHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 03:07:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50358 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbgCXHHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585033669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZaSi0ZO+Ks2DlAc0F4wKniHNa/ruO7TTk/TDQ9gB5fA=;
        b=ORIX3y1yOLfIyLrwGvMrFJZqLVmxtaCSRKqsphhrWZnsByjjCFmLuqGOBE/Cf52fJZ3cLw
        L4swKxplvEv1ZlUCumyiNH/NQNzcxvLbcLWV9+9eD4VO5WRrkdPllF4R7bwwb7t0IbayT2
        Ptm+S6SbCskuVBsOcQt/ipi1Ma/NIpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-sHWL7KGCMh2yyJpLJRO4bw-1; Tue, 24 Mar 2020 03:07:46 -0400
X-MC-Unique: sHWL7KGCMh2yyJpLJRO4bw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 644718017CE;
        Tue, 24 Mar 2020 07:07:45 +0000 (UTC)
Received: from localhost (ovpn-12-69.pek2.redhat.com [10.72.12.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7B191C947;
        Tue, 24 Mar 2020 07:07:44 +0000 (UTC)
Date:   Tue, 24 Mar 2020 15:07:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org
Subject: Re: [5.6.0-rc7] Kernel crash while running ndctl tests
Message-ID: <20200324070742.GJ2987@MiWiFi-R3L-srv>
References: <CF20E440-4DCB-4EFD-88B6-0AB98DC7FBD4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CF20E440-4DCB-4EFD-88B6-0AB98DC7FBD4@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sachin,

On 03/24/20 at 11:25am, Sachin Sant wrote:
> While running ndctl[1] tests against 5.6.0-rc7 following crash is encou=
ntered.
>=20
> Bisect leads me to  commit d41e2f3bd546=20
> mm/hotplug: fix hot remove failure in SPARSEMEM|!VMEMMAP case
>=20
> Reverting this commit helps and the tests complete without any crash.

Could you paste your kernel config and the boot log?

If it's confidential, private attachment is also OK.

Thanks
Baoquan

>=20
> pmem0: detected capacity change from 0 to 10720641024
> BUG: Kernel NULL pointer dereference on read at 0x00000000
> Faulting instruction address: 0xc000000000c3447c
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSeries
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in: dm_mod nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 li=
bcrc32c ip6_tables nft_compat ip_set rfkill nf_tables nfnetlink sunrpc sg=
 pseries_rng papr_scm uio_pdrv_genirq uio sch_fq_codel ip_tables sd_mod t=
10_pi ibmvscsi scsi_transport_srp ibmveth
> CPU: 11 PID: 7519 Comm: lt-ndctl Not tainted 5.6.0-rc7-autotest #1
> NIP:  c000000000c3447c LR: c000000000088354 CTR: c00000000018e990
> REGS: c0000006223fb630 TRAP: 0300   Not tainted  (5.6.0-rc7-autotest)
> MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24048888 =
 XER: 00000000
> CFAR: c00000000000dec4 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0=
=20
> GPR00: c0000000003c5820 c0000006223fb8c0 c000000001684900 0000000004000=
000=20
> GPR04: c00c000101000000 0000000007ffffff c00000067ff20900 c00c000000000=
000=20
> GPR08: 0000000000000000 c00c000100000000 0000000000000000 c000000003f00=
000=20
> GPR12: 0000000000008000 c00000001ec70200 00007fffc102f9e8 000000001002e=
088=20
> GPR16: 0000000000000000 0000000010050d88 000000001002f778 000000001002f=
770=20
> GPR20: 0000000000000000 0000000000000100 0000000000000001 0000000000001=
000=20
> GPR24: 0000000000000008 0000000000000000 0000000004000000 c00c000100004=
000=20
> GPR28: c000000003101aa0 c00c000100000000 0000000001000000 0000000004000=
100=20
> NIP [c000000000c3447c] vmemmap_populated+0x98/0xc0
> LR [c000000000088354] vmemmap_free+0x144/0x320
> Call Trace:
> [c0000006223fb8c0] [c0000006223fb960] 0xc0000006223fb960 (unreliable)
> [c0000006223fb980] [c0000000003c5820] section_deactivate+0x220/0x240
> [c0000006223fba30] [c0000000003dc1d8] __remove_pages+0x118/0x170
> [c0000006223fba80] [c000000000086e5c] arch_remove_memory+0x3c/0x150
> [c0000006223fbb00] [c00000000041a3bc] memunmap_pages+0x1cc/0x2f0
> [c0000006223fbb80] [c0000000007d6d00] devm_action_release+0x30/0x50
> [c0000006223fbba0] [c0000000007d7de8] release_nodes+0x2f8/0x3e0
> [c0000006223fbc50] [c0000000007d0b38] device_release_driver_internal+0x=
168/0x270
> [c0000006223fbc90] [c0000000007ccf50] unbind_store+0x130/0x170
> [c0000006223fbcd0] [c0000000007cc0b4] drv_attr_store+0x44/0x60
> [c0000006223fbcf0] [c00000000051fdb8] sysfs_kf_write+0x68/0x80
> [c0000006223fbd10] [c00000000051f200] kernfs_fop_write+0x100/0x290
> [c0000006223fbd60] [c00000000042037c] __vfs_write+0x3c/0x70
> [c0000006223fbd80] [c00000000042404c] vfs_write+0xcc/0x240
> [c0000006223fbdd0] [c00000000042442c] ksys_write+0x7c/0x140
> [c0000006223fbe20] [c00000000000b278] system_call+0x5c/0x68
> Instruction dump:
> 2ea80000 4196003c 794a2428 7d685215 41820030 7d48502a 71480002 41820024=
=20
> 714a0008 4082002c e90b0008 786adf62 <e8680000> 7c635436 70630001 4c8200=
20=20
> ---[ end trace 579b48162da1b890 ]=E2=80=94
>=20
> Thanks
> -Sachin
>=20
> [1] https://github.com/avocado-framework-tests/avocado-misc-tests/blob/=
master/memory/ndctl.py
>=20

