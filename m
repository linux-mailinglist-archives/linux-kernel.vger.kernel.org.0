Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900C722AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 06:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfETEtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 00:49:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39814 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbfETEtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 00:49:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so6097301plm.6;
        Sun, 19 May 2019 21:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=FfAUYEg+Y4R8++7nKVf7QwMzqkS7T9NF0tY9FUe281I=;
        b=C+HZQjhBRLztdOxCCdisjxLPqf+REKkTl0AbwQ6zVrN8btlVkNpecUAMKG+cL21sBk
         NXM9doymE0F92bvpdIfZ/mmJsjymInuJvxaxLMrGKJoO/YqOIQKCCc2ghjJYJ4dQ8CWy
         ixb0tugwN+CsdhLVCfRrIdWUSvvi4DHZfynivUGVAQ81yI2zqH3c8huyX7psgCPTId5d
         OFOjoBj7w25iwijNTzkrrunwvOOrItgYN1jze4U3LVnNABUxojQVHqW5QJX0ZzJM68Tr
         jYCWR5qYfRwsGKRTNjY59rBorQjYExjsGtYJT9eBUUQIVNeE1EjS0LhENoHCpvzDApnS
         bE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=FfAUYEg+Y4R8++7nKVf7QwMzqkS7T9NF0tY9FUe281I=;
        b=GqAJdRaEYUNJmooZZxy3m/CFQhN5ZeoBj/MLL57jfuUvRqjtlFyirM7bq+ZAsNxbMP
         J/m98NJkL8ZUoSEVrje7iraRXDTtri0zTHICEinvSE2PcuoSBSo76hpnEBDzp3da78J6
         ZCPZTuFk0s1b9lGm5CXjMNhj4Ij3XNXEUWxmIfXVoQpwpWlU9R4jhDswh/CbsEBDn30r
         zFrTuNSRQ67da7IAx/gI5SInGIQA9w1Baygr35oki+ymvN6xJzsaZa3Kjn/afs5feBbv
         DWPBdGin57NSOKrNAvKuoZstQHa+bbi2kPXRMg5MCrmIrwAKifNBaMWjsH+Bzfm3pDYQ
         ZG/g==
X-Gm-Message-State: APjAAAW3ZFHQNX2UC+czYlggRTAUJxVXdmPSjV4cjSSleu8SK0DxK+IG
        h96eoMhlEues6zX5KtK70+c=
X-Google-Smtp-Source: APXvYqwj6WrJnjhBNzQvnmV3/Ob1XB5+fNO2deVNG2T8zU4h8bWv0AD0J9T1O1jf2FppFxh3Joqwng==
X-Received: by 2002:a17:902:aa0a:: with SMTP id be10mr10078782plb.293.1558327770404;
        Sun, 19 May 2019 21:49:30 -0700 (PDT)
Received: from localhost (193-116-79-244.tpgi.com.au. [193.116.79.244])
        by smtp.gmail.com with ESMTPSA id g22sm18822827pfo.28.2019.05.19.21.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 21:49:29 -0700 (PDT)
Date:   Mon, 20 May 2019 14:48:35 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: PROBLEM: Power9: kernel oops on memory hotunplug from ppc64le
 guest
To:     bharata@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>
Cc:     aneesh.kumar@linux.ibm.com, bharata@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        srikanth <sraithal@linux.vnet.ibm.com>
References: <16a7a635-c592-27e2-75b4-d02071833278@linux.vnet.ibm.com>
        <20190518141434.GA22939@in.ibm.com>
        <878sv1993k.fsf@concordia.ellerman.id.au>
        <20190520042533.GB22939@in.ibm.com>
In-Reply-To: <20190520042533.GB22939@in.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1558327521.633yjtl8ki.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharata B Rao's on May 20, 2019 2:25 pm:
> On Mon, May 20, 2019 at 12:02:23PM +1000, Michael Ellerman wrote:
>> Bharata B Rao <bharata@linux.ibm.com> writes:
>> > On Thu, May 16, 2019 at 07:44:20PM +0530, srikanth wrote:
>> >> Hello,
>> >>=20
>> >> On power9 host, performing memory hotunplug from ppc64le guest result=
s in
>> >> kernel oops.
>> >>=20
>> >> Kernel used : https://github.com/torvalds/linux/tree/v5.1 built using
>> >> ppc64le_defconfig for host and ppc64le_guest_defconfig for guest.
>> >>=20
>> >> Recreation steps:
>> >>=20
>> >> 1. Boot a guest with below mem configuration:
>> >> =C2=A0 <maxMemory slots=3D'32' unit=3D'KiB'>33554432</maxMemory>
>> >> =C2=A0 <memory unit=3D'KiB'>8388608</memory>
>> >> =C2=A0 <currentMemory unit=3D'KiB'>4194304</currentMemory>
>> >> =C2=A0 <cpu>
>> >> =C2=A0=C2=A0=C2=A0 <numa>
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <cell id=3D'0' cpus=3D'0-31' memory=3D=
'8388608' unit=3D'KiB'/>
>> >> =C2=A0=C2=A0=C2=A0 </numa>
>> >> =C2=A0 </cpu>
>> >>=20
>> >> 2. From host hotplug 8G memory -> verify memory hotadded succesfully =
-> now
>> >> reboot guest -> once guest comes back try to unplug 8G memory
>> >>=20
>> >> mem.xml used:
>> >> <memory model=3D'dimm'>
>> >> <target>
>> >> <size unit=3D'GiB'>8</size>
>> >> <node>0</node>
>> >> </target>
>> >> </memory>
>> >>=20
>> >> Memory attach and detach commands used:
>> >> =C2=A0=C2=A0=C2=A0 virsh attach-device vm1 ./mem.xml --live
>> >> =C2=A0=C2=A0=C2=A0 virsh detach-device vm1 ./mem.xml --live
>> >>=20
>> >> Trace seen inside guest after unplug, guest just hangs there forever:
>> >>=20
>> >> [=C2=A0=C2=A0 21.962986] kernel BUG at arch/powerpc/mm/pgtable-frag.c=
:113!
>> >> [=C2=A0=C2=A0 21.963064] Oops: Exception in kernel mode, sig: 5 [#1]
>> >> [=C2=A0=C2=A0 21.963090] LE PAGE_SIZE=3D64K MMU=3DRadix MMU=3DHash SM=
P NR_CPUS=3D2048 NUMA
>> >> pSeries
>> >> [=C2=A0=C2=A0 21.963131] Modules linked in: xt_tcpudp iptable_filter =
squashfs fuse
>> >> vmx_crypto ib_iser rdma_cm iw_cm ib_cm ib_core libiscsi scsi_transpor=
t_iscsi
>> >> ip_tables x_tables autofs4 btrfs zstd_decompress zstd_compress lzo_co=
mpress
>> >> raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor asyn=
c_tx
>> >> xor raid6_pq multipath crc32c_vpmsum
>> >> [=C2=A0=C2=A0 21.963281] CPU: 11 PID: 316 Comm: kworker/u64:5 Kdump: =
loaded Not
>> >> tainted 5.1.0-dirty #2
>> >> [=C2=A0=C2=A0 21.963323] Workqueue: pseries hotplug workque pseries_h=
p_work_fn
>> >> [=C2=A0=C2=A0 21.963355] NIP:=C2=A0 c000000000079e18 LR: c000000000c7=
9308 CTR:
>> >> 0000000000008000
>> >> [=C2=A0=C2=A0 21.963392] REGS: c0000003f88034f0 TRAP: 0700=C2=A0=C2=
=A0 Not tainted (5.1.0-dirty)
>> >> [=C2=A0=C2=A0 21.963422] MSR:=C2=A0 800000000282b033 <SF,VEC,VSX,EE,F=
P,ME,IR,DR,RI,LE>=C2=A0 CR:
>> >> 28002884=C2=A0 XER: 20040000
>> >> [=C2=A0=C2=A0 21.963470] CFAR: c000000000c79304 IRQMASK: 0
>> >> [=C2=A0=C2=A0 21.963470] GPR00: c000000000c79308 c0000003f8803780 c00=
0000001521000
>> >> 0000000000fff8c0
>> >> [=C2=A0=C2=A0 21.963470] GPR04: 0000000000000001 00000000ffe30005 000=
0000000000005
>> >> 0000000000000020
>> >> [=C2=A0=C2=A0 21.963470] GPR08: 0000000000000000 0000000000000001 c00=
a000000fff8e0
>> >> c0000000016d21a0
>> >> [=C2=A0=C2=A0 21.963470] GPR12: c0000000016e7b90 c000000007ff2700 c00=
a000000a00000
>> >> c0000003ffe30100
>> >> [=C2=A0=C2=A0 21.963470] GPR16: c0000003ffe30000 c0000000014aa4de c00=
a0000009f0000
>> >> c0000000016d21b0
>> >> [=C2=A0=C2=A0 21.963470] GPR20: c0000000014de588 0000000000000001 c00=
00000016d21b8
>> >> c00a000000a00000
>> >> [=C2=A0=C2=A0 21.963470] GPR24: 0000000000000000 ffffffffffffffff c00=
a000000a00000
>> >> c0000003ffe96000
>> >> [=C2=A0=C2=A0 21.963470] GPR28: c00a000000a00000 c00a000000a00000 c00=
00003fffec000
>> >> c00a000000fff8c0
>> >> [=C2=A0=C2=A0 21.963802] NIP [c000000000079e18] pte_fragment_free+0x4=
8/0xd0
>> >> [=C2=A0=C2=A0 21.963838] LR [c000000000c79308] remove_pagetable+0x49c=
/0x5b4
>> >> [=C2=A0=C2=A0 21.963873] Call Trace:
>> >> [=C2=A0=C2=A0 21.963890] [c0000003f8803780] [c0000003ffe997f0] 0xc000=
0003ffe997f0
>> >> (unreliable)
>> >> [=C2=A0=C2=A0 21.963933] [c0000003f88037b0] [0000000000000000] (null)
>> >> [=C2=A0=C2=A0 21.963969] [c0000003f88038c0] [c00000000006f038]
>> >> vmemmap_free+0x218/0x2e0
>> >> [=C2=A0=C2=A0 21.964006] [c0000003f8803940] [c00000000036f100]
>> >> sparse_remove_one_section+0xd0/0x138
>> >> [=C2=A0=C2=A0 21.964050] [c0000003f8803980] [c000000000383a50]
>> >> __remove_pages+0x410/0x560
>> >> [=C2=A0=C2=A0 21.964093] [c0000003f8803a90] [c000000000c784d8]
>> >> arch_remove_memory+0x68/0xdc
>> >> [=C2=A0=C2=A0 21.964136] [c0000003f8803ad0] [c000000000385d74]
>> >> __remove_memory+0xc4/0x110
>> >> [=C2=A0=C2=A0 21.964180] [c0000003f8803b10] [c0000000000d44e4]
>> >> dlpar_remove_lmb+0x94/0x140
>> >> [=C2=A0=C2=A0 21.964223] [c0000003f8803b50] [c0000000000d52b4]
>> >> dlpar_memory+0x464/0xd00
>> >> [=C2=A0=C2=A0 21.964259] [c0000003f8803be0] [c0000000000cd5c0]
>> >> handle_dlpar_errorlog+0xc0/0x190
>> >> [=C2=A0=C2=A0 21.964303] [c0000003f8803c50] [c0000000000cd6bc]
>> >> pseries_hp_work_fn+0x2c/0x60
>> >> [=C2=A0=C2=A0 21.964346] [c0000003f8803c80] [c00000000013a4a0]
>> >> process_one_work+0x2b0/0x5a0
>> >> [=C2=A0=C2=A0 21.964388] [c0000003f8803d10] [c00000000013a818]
>> >> worker_thread+0x88/0x610
>> >> [=C2=A0=C2=A0 21.964434] [c0000003f8803db0] [c000000000143884] kthrea=
d+0x1a4/0x1b0
>> >> [=C2=A0=C2=A0 21.964468] [c0000003f8803e20] [c00000000000bdc4]
>> >> ret_from_kernel_thread+0x5c/0x78
>> >> [=C2=A0=C2=A0 21.964506] Instruction dump:
>> >> [=C2=A0=C2=A0 21.964527] fbe1fff8 f821ffd1 78638502 78633664 ebe90000=
 7fff1a14
>> >> 395f0020 813f0020
>> >> [=C2=A0=C2=A0 21.964569] 7d2907b4 7d2900d0 79290fe0 69290001 <0b09000=
0> 7c0004ac
>> >> 7d205028 3129ffff
>> >> [=C2=A0=C2=A0 21.964613] ---[ end trace aaa571aa1636fee6 ]---
>> >> [=C2=A0=C2=A0 21.966349]
>> >> [=C2=A0=C2=A0 21.966383] Sending IPI to other CPUs
>> >> [=C2=A0=C2=A0 21.978335] IPI complete
>> >> [=C2=A0=C2=A0 21.981354] kexec: Starting switchover sequence.
>> >> I'm in purgatory
>> >
>> > git bisect points to
>> >
>> > commit 4231aba000f5a4583dd9f67057aadb68c3eca99d
>> > Author: Nicholas Piggin <npiggin@gmail.com>
>> > Date:   Fri Jul 27 21:48:17 2018 +1000
>> >
>> >     powerpc/64s: Fix page table fragment refcount race vs speculative =
references
>> >
>> >     The page table fragment allocator uses the main page refcount raci=
ly
>> >     with respect to speculative references. A customer observed a BUG =
due
>> >     to page table page refcount underflow in the fragment allocator. T=
his
>> >     can be caused by the fragment allocator set_page_count stomping on=
 a
>> >     speculative reference, and then the speculative failure handler
>> >     decrements the new reference, and the underflow eventually pops wh=
en
>> >     the page tables are freed.
>> >
>> >     Fix this by using a dedicated field in the struct page for the pag=
e
>> >     table fragment allocator.
>> >
>> >     Fixes: 5c1f6ee9a31c ("powerpc: Reduce PTE table memory wastage")
>> >     Cc: stable@vger.kernel.org # v3.10+
>>=20
>> That's the commit that added the BUG_ON(), so prior to that you won't
>> see the crash.
>=20
> Right, but the commit says it fixes page table page refcount underflow by
> introducing a new field &page->pt_frag_refcount. Now we are hitting the u=
nderflow
> for this pt_frag_refcount.

The fixed underflow is caused by a bug (race on page count) that got=20
fixed by that patch. You are hitting a different underflow here. It's
not certain my patch caused it, I'm just trying to reproduce now.

>=20
> BTW, if I go below this commit, I don't hit the pagecount
>=20
> VM_BUG_ON_PAGE(page_ref_count(page) =3D=3D 0, page);
>=20
> which is in pte_fragment_free() path.

Do you have CONFIG_DEBUG_VM=3Dy?

Thanks,
Nick

=
