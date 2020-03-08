Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5701217D102
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 04:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCHDUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 22:20:24 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40908 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgCHDUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 22:20:24 -0500
Received: by mail-qv1-f67.google.com with SMTP id u17so2861688qvv.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 19:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=59Y2hQbANibD/z8jkNxEcTFEgdYSf1wMpFMXrMl1QT0=;
        b=JqJYtxPgZIeo9JAU7ciljieR5SYMVby7MeOLRQp5Rd2K4q1JzS2gVXok0AmJaqe0Bx
         5m5WDDG/uimVTo82aoHT4n8uzE1vJ0bPbNVphA14Sji2W5exSTOQLqmi8H67w5tVVlRq
         KrsS3bIa6EA+MyVKCvryB/+fOzz/gVIf5Ob0yKOdhBh3S40CUwIGf2X79/nDtDspNgWn
         oIkfT0Hjz2l2HTePKzQApjK7ASHW9SYo07qxeLf13E3tElbvD7Y97tcqnRScZOJviDdN
         2HHKC7YsfrVM/MSOcB/I7+rJz2CxkCDXqWRcHb7kld4Ozk5OwYJFPQxCU+QVetepw4zT
         XSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=59Y2hQbANibD/z8jkNxEcTFEgdYSf1wMpFMXrMl1QT0=;
        b=EYDoDBWm4c25tnCdQPrSEt2vtoxspV/4dI9QRS7pMCkWNGG6uySOB2LXNnYD1ny8lz
         n1rxEexCz6ZzL/RqPhJDiPzwLD99HBTlUAEci8XpEbYQ8Dl1I+tyDpKV0LQtEMwyMMAm
         MGm4EW6qMzid427Ewou5evGwD23UWsAefDj78Z6qYY/8NQTiY3BEfTKbI3VC/P5Z84qN
         7wAPFtncM3+UuYPiw0tXczVsgwXyruLgs9q+uaBKZiCFfWb8ejSA6iqXDVsRnRrL0G5G
         kP2iwqRcIUwBWZqS1TY4I9j6JZZimZIDH2kqh+nmzFUOBYMrdj8Ib8VpAzmUVk4h28N9
         UHww==
X-Gm-Message-State: ANhLgQ0qZlU+P2v9wLrEwoMMUmYFoLaGYIM+M6k51JU2ngwjpVBk7m22
        RsV+qVKjdEYP7TagwE9/H4fugA==
X-Google-Smtp-Source: ADFU+vsCBjGXAcstfj9FGuploSxhp/ikbG9z5xprFQVpeFF+vcHGbQgB5dIMO9R3M6ueWxuac7YJwQ==
X-Received: by 2002:ad4:4e73:: with SMTP id ec19mr9047172qvb.78.1583637622347;
        Sat, 07 Mar 2020 19:20:22 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p126sm20336301qkd.108.2020.03.07.19.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2020 19:20:21 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] mm, numa: fix bad pmd by atomically check for
 pmd_trans_huge when marking page tables prot_numa
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200307030530.GB4093@t490s>
Date:   Sat, 7 Mar 2020 22:20:20 -0500
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        mgorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9124C8B9-FB47-44F5-8606-DD9261BCB383@lca.pw>
References: <20200216191800.22423-1-aquini@redhat.com>
 <2E0766B8-DDD1-4448-8605-8535A16670FC@lca.pw> <20200307030530.GB4093@t490s>
To:     Rafael Aquini <aquini@redhat.com>,
        linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if it is really worth hurrying this into -rc5 now given...

> On Mar 6, 2020, at 10:05 PM, Rafael Aquini <aquini@redhat.com> wrote:
>>=20
>> After reverted this patch, it is no longer possible to reproduce a =
bug under memory pressure
>> with swapping on linux-next 20200306,
>>=20
>=20
> Would you mind sharing your .config ? Also it would be nice to know =
your
> system and workload details so I can try to reproduce.

LTP oom02 in a tight loop,

# i=3D0; while :; echo $((i++)); ./oom02; sleep 10; done

HPE ProLiant DL385 Gen10
AMD EPYC 7601 32-Core Processor
65536 MB memory, 400 GB disk space

Processors	128
Cores	64
Sockets	2

linux-next 20200306

>=20
> Cheers,
> -- Rafael
>=20
>> The trace is a bit off for some reasons, but it is basically,
>>=20
>> kernel BUG at include/linux/page-flags.h:317!
>>=20
>> end_swap_bio_write()
>>   SetPageError(page)
>>       VM_BUG_ON_PAGE(1 && PageCompound(page))=20
>>=20
>> The page was allocated in,
>>=20
>> do_huge_pmd_anonymous_page()
>>=20
>> [ 9598.551238][  T794] oom_reaper: reaped process 49120 (oom02), now =
anon-rss:0kB, file-rss:0kB, shmem-rss:0kB=20
>> [ 9690.896638][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffcc0000 =
flags=3D0x0010]=20
>> [ 9690.910129][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffcc1000 =
flags=3D0x0010]=20
>> [ 9690.923933][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffcc1900 =
flags=3D0x0010]=20
>> [ 9690.937669][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffcc1d00 =
flags=3D0x0010]=20
>> [ 9690.951468][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffcc2000 =
flags=3D0x0010]=20
>> [ 9690.964803][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffcc2400 =
flags=3D0x0010]=20
>> [ 9690.978256][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffcc2800 =
flags=3D0x0010]=20
>> [ 9690.991423][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffcc2c00 =
flags=3D0x0010]=20
>> [ 9691.004294][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffcc3000 =
flags=3D0x0010]=20
>> [ 9691.017228][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffcc3400 =
flags=3D0x0010]=20
>> [ 9691.029804][  T814] AMD-Vi: Event logged [IO_PAGE_FAULT =
device=3D23:00.0 domain=3D0x0027 address=3D0xffffffffffcc3800 =
flags=3D0x0010]=20
>> [ 9691.041623][  T814] AMD-Vi: Event logged [IO_PAGE_FAULT =
device=3D23:00.0 domain=3D0x0027 address=3D0xffffffffffcc3c00 =
flags=3D0x0010]=20
>> [ 9692.767064][    C8] smartpqi 0000:23:00.0: controller is offline: =
status code 0x14803=20
>> [ 9692.775562][    C8] smartpqi 0000:23:00.0: controller offline=20
>> [ 9692.841721][   C36] sd 0:1:0:0: [sda] tag#693 UNKNOWN(0x2003) =
Result: hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D1s=20
>> [ 9692.841970][   C87] blk_update_request: I/O error, dev sda, sector =
59046400 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0=20
>> [ 9692.842718][   C31] blk_update_request: I/O error, dev sda, sector =
36509696 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0=20
>> [ 9692.842748][   C18] sd 0:1:0:0: [sda] tag#616 UNKNOWN(0x2003) =
Result: hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D1s=20
>> [ 9692.842757][   C28] sd 0:1:0:0: [sda] tag#841 UNKNOWN(0x2003) =
Result: hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D1s=20
>> [ 9692.842766][  C109] sd 0:1:0:0: [sda] tag#393 UNKNOWN(0x2003) =
Result: hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D1s=20
>> [ 9692.842811][  C109] sd 0:1:0:0: [sda] tag#393 CDB: opcode=3D0x2a =
2a 00 01 60 c8 00 00 02 00 00=20
>> [ 9692.842840][   C13] sd 0:1:0:0: [sda] tag#324 UNKNOWN(0x2003) =
Result: hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D1s=20
>> [ 9692.842924][   C18] sd 0:1:0:0: [sda] tag#616 CDB: opcode=3D0x2a =
2a 00 01 c7 8c 00 00 02 00 00=20
>> [ 9692.842932][  C109] blk_update_request: I/O error, dev sda, sector =
23119872 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0=20
>> [ 9692.842938][   C28] sd 0:1:0:0: [sda] tag#841 CDB: opcode=3D0x2a =
2a 00 03 2f cc 00 00 02 00 00=20
>> [ 9692.842984][  T213] sd 0:1:0:0: [sda] tag#47 UNKNOWN(0x2003) =
Result: hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D1s=20
>> [ 9692.842995][   C28] blk_update_request: I/O error, dev sda, sector =
53464064 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0=20
>> [ 9692.843000][   C81] sd 0:1:0:0: [sda] tag#10 UNKNOWN(0x2003) =
Result: hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D1s=20
>> [ 9692.843031][   C18] blk_update_request: I/O error, dev sda, sector =
29854720 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0=20
>> [ 9692.843056][   C13] sd 0:1:0:0: [sda] tag#324 CDB: opcode=3D0x2a =
2a 00 03 17 66 00 00 02 00 00=20
>> [ 9692.843101][   C81] sd 0:1:0:0: [sda] tag#10 CDB: opcode=3D0x2a 2a =
00 00 52 a4 00 00 02 00 00=20
>> [ 9692.843129][   C13] blk_update_request: I/O error, dev sda, sector =
51865088 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0=20
>> [ 9692.843192][   C81] blk_update_request: I/O error, dev sda, sector =
5415936 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0=20
>> [ 9692.843338][  T213] sd 0:1:0:0: [sda] tag#47 CDB: opcode=3D0x2a 2a =
00 02 be 5a 00 00 02 00 00=20
>> [ 9692.843358][   C13] sd 0:1:0:0: [sda] tag#325 UNKNOWN(0x2003) =
Result: hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D1s=20
>> [ 9692.843480][  T213] blk_update_request: I/O error, dev sda, sector =
46029312 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0=20
>> [ 9692.843485][   C13] sd 0:1:0:0: [sda] tag#325 CDB: opcode=3D0x2a =
2a 00 03 17 68 00 00 02 00 00=20
>> [ 9692.843510][   C13] blk_update_request: I/O error, dev sda, sector =
51865600 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0=20
>> [ 9692.843685][  C103] blk_update_request: I/O error, dev sda, sector =
34941952 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0=20
>> [ 9692.843725][   C96] sd 0:1:0:0: [sda] tag#877 UNKNOWN(0x2003) =
Result: hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D1s=20
>> [ 9692.843744][   C92] Write-error on swap-device (254:1:39256632)=20
>> [ 9692.843791][  C118] sd 0:1:0:0: [sda] tag#230 UNKNOWN(0x2003) =
Result: hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D1s=20
>> [ 9692.843866][   C64] Write-error on swap-device (254:1:63030016)=20
>> [ 9692.843891][   C96] sd 0:1:0:0: [sda] tag#877 CDB: opcode=3D0x2a =
2a 00 03 1e 48 00 00 02 00 00=20
>> [ 9692.844013][  C118] sd 0:1:0:0: [sda] tag#230 CDB: opcode=3D0x2a =
2a 00 03 c6 26 00 00 02 00 00=20
>> [ 9692.844615][   C92] Write-error on swap-device (254:1:39256640)=20
>> [ 9692.844643][   C64] Write-error on swap-device (254:1:63030024)=20
>> [ 9692.845109][   C61] Write-error on swap-device (254:1:17105384)=20
>> [ 9692.845192][   C25] page:fffff3b2ec3a8000 refcount:512 mapcount:0 =
mapping:000000009eb0338c index:0x7f6e58200 head:fffff3b2ec3a8000 order:9 =
compound_mapcount:0 compound_pincount:0=20
>> [ 9692.845226][   C25] anon flags: =
0x45fffe0000d8454(uptodate|lru|workingset|owner_priv_1|writeback|head|recl=
aim|swapbacked)=20
>> [ 9692.845254][   C25] raw: 045fffe0000d8454 fffff3b2f9d48008 =
fffff3b2f3270008 ffff97c3090f8209=20
>> [ 9692.845283][   C25] raw: 00000007f6e58200 000000000053c800 =
00000200ffffffff ffff97c8d71e9000=20
>> [ 9692.845293][  C122] Write-error on swap-device (254:1:39080184)=20
>> [ 9692.845316][  T213] page:fffff3b2f77d8000 refcount:512 mapcount:0 =
mapping:00000000a4517f4e index:0x7f69d2200 head:fffff3b2f77d8000 order:9 =
compound_mapcount:0 compound_pincount:0=20
>> [ 9692.845330][   C25] page dumped because: VM_BUG_ON_PAGE(1 && =
PageCompound(page))=20
>> [ 9692.845427][  T213] anon flags: =
0x45fffe0000d8454(uptodate|lru|workingset|owner_priv_1|writeback|head|recl=
aim|swapbacked)=20
>> [ 9692.845433][   C25] page->mem_cgroup:ffff97c8d71e9000=20
>> [ 9692.845443][   C25] page_owner tracks the page as allocated=20
>> [ 9692.845520][  T213] raw: 045fffe0000d8454 fffff3b2f5ec2f08 =
fffff3b2f6b88008 ffff97c715cc0609=20
>> [ 9692.845535][   C25] page last allocated via order 9, migratetype =
Movable, gfp_mask 0x1c20ca(GFP_TRANSHUGE_LIGHT)=20
>> [ 9692.845606][   C25]  prep_new_page+0x1cd/0x1f0=20
>> [ 9692.845628][   C25]  get_page_from_freelist+0x18ac/0x24d0=20
>> [ 9692.845639][  T213] raw: 00000007f69d2200 00000000000bf400 =
00000200ffffffff ffff97c8d71e9000=20
>> [ 9692.845654][   C25]  __alloc_pages_nodemask+0x1b1/0x450=20
>> [ 9692.845733][  T213] page dumped because: VM_BUG_ON_PAGE(1 && =
PageCompound(page))=20
>> [ 9692.845757][   C25]  alloc_pages_vma+0x8a/0x2c0=20
>> [ 9692.845762][  T213] page->mem_cgroup:ffff97c8d71e9000=20
>> [ 9692.845779][   C25]  do_huge_pmd_anonymous_page+0x1d4/0xc30=20
>> [ 9692.845786][  T213] page_owner tracks the page as allocated=20
>> [ 9692.845807][   C25]  __handle_mm_fault+0xd27/0xd50=20
>> [ 9692.845819][  T213] page last allocated via order 9, migratetype =
Movable, gfp_mask 0x1c20ca(GFP_TRANSHUGE_LIGHT)=20
>> [ 9692.845833][   C25]  handle_mm_fault+0xfc/0x2f0=20
>> [ 9692.845856][  T213]  prep_new_page+0x1cd/0x1f0=20
>> [ 9692.845876][   C25]  do_page_fault+0x263/0x6f9=20
>> [ 9692.845892][  T213]  get_page_from_free7219][   C25]  =
clone_endio+0xe4/0x2c0 [dm_mod]=20
>> [ 9692.847226][  T213] kernel BUG at include/linux/page-flags.h:317!=20=

>> [ 9692.847234][   C64] Write-error on swap-device (254:1:63030064)=20
>> [ 9692.847250][   C25]  bio_endio+0x297/0x560=20
>> [ 9692.847255][   C61] Write-error on swap-device (254:1:17105424)=20
>> [ 9692.847263][   C25]  ? bio_advance+0x92/0x190=20
>> [ 9692.847267][  C122] Write-error on swap-device (254:1:39080224)=20
>> [ 9692.847276][   C25]  blk_update_request+0x201/0x920=20
>> [ 9692.847287][   C25]  ? ___ratelimit+0x138/0x1e0=20
>> [ 9692.847312][   C25]  scsi_end_request+0x6b/0x4b0=20
>> [ 9692.847320][   C25]  ? ___ratelimit+0x3e/0x1e0=20
>> [ 9692.847329][   C25]  scsi_io_completion+0x509/0x7e0=20
>> [ 9692.847340][   C25]  scsi_finish_command+0x1ed/0x2a0=20
>> [ 9692.847350][   C25]  scsi_softirq_done+0x1c9/0x1d0=20
>> [ 9692.847354][   C64] Write-error on swap-device (254:1:63030072)=20
>> [ 9692.847363][   C25]  ? blk_mq_check_inflight+0xa0/0xa0=20
>> [ 9692.847383][   C61] Write-error on swap-device (254:1:17105432)=20
>> [ 9692.847397][  C122] Write-erro692.848242][   C25] RSP: =
0018:ffffb02006b68bb0 EFLAGS: 00010086=20
>> [ 9692.848333][  T213] Workqueue: events pqi_ctrl_offline_worker =
[smartpqi]=20
>> [ 9692.848346][   C61] Write-error on swap-device (254:1:17105528)=20
>> [ 9692.848351][  C122] Write-error on swap-device (254:1:39080328)=20
>> [ 9692.848428][   C25] RAX: 0000000000000000 RBX: ffff97c76d8d4b80 =
RCX: ffffffff9d51e8f0=20
>> [ 9692.848433][   C61] Write-error on swap-device (254:1:17105536)=20
>> [ 9692.848437][  C122] Write-error on swap-device (254:1:39080336)=20
>> [ 9692.848445][  T213] RIP: 0010:end_swap_bio_write+0x90/0x280=20
>> [ 9692.848450][   C25] RDX: 0000000000000000 RSI: 0000000000000000 =
RDI: ffff97c7e539f00a=20
>> [ 9692.848461][  T213] Code: 80 7b 1a 00 0f 84 58 01 00 00 4c 89 e6 =
bf 10 00 00 00 e8 33 f8 ff ff 84 c0 74 1d 48 c7 c6 18 7e 3b 9a 4c 89 e7 =
e8 20 78 fa ff <0f> 0b 48 c7 c7 b0 0b 6e 9a e8 04 ee 2b 00 4d 8d 74 24 =
08 ba 08 00=20
>> [ 9692.848466][   C25] RBP: ffffb02006b68bf0 R08: 0000000000000000 =
R09: 000097c7e539f00a=20
>> [ 9692.848471][  T213] RSP: 0018:ffffb02006dd3908 EFLAGS: 00010286=20
>> [ 9692.848485][   C25] R10: 0000b02006b689a0 R11: =
000097c7e5ax_pmem_core efivars acpi_cpufreq efivarfs ip_tables x_tables =
xfs sd_mod smartpqi scsi_transport_sas tg3 mlx5_core=20
>> [ 9692.849818][  C122] Write-error on swap-device (254:1:39080440)=20
>> [ 9692.849884][  T213]  libphy=20
>> [ 9692.849889][  C122] Write-error on swap-device (254:1:39080448)=20
>> [ 9692.849952][  T213]  firmware_class=20
>> [ 9692.849959][  C122] Write-error on swap-device (254:1:39080456)=20
>> [ 9692.849963][  T213]  dm_mirror dm_region_hash dm_log dm_mod=20
>> [ 9692.849990][  C122] Write-error on swap-device (254:1:39080464)=20
>> [ 9692.850069][  C122] Write-error on swap-device (254:1:39080472)=20
>> [ 9692.850107][  C122] Write-error on swap-device (254:1:39080480)=20
>> [ 9692.850156][  C122] Write-error on swap-device (254:1:39080488)=20
>> [ 9692.850220][  C122] Write-error on swap-device (254:1:39080496)=20
>> [ 9692.850264][  C122] Write-error on swap-device (254:1:39080504)=20
>> [ 9692.850323][  C122] Write-error on swap-device (254:1:39080512)=20
>> [ 9692.850361][  C122] Write-error on swap-device (254:1:39080520)=20
>> [ 9692.850411][  C122] Write-error on swap-device (254:1:39080528) =20=

>>=20
>>>=20
>>> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Rafael Aquini <aquini@redhat.com>
>>> ---
>>> mm/mprotect.c | 38 ++++++++++++++++++++++++++++++++++++--
>>> 1 file changed, 36 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>>> index 7a8e84f86831..9ea8cc0ab2fd 100644
>>> --- a/mm/mprotect.c
>>> +++ b/mm/mprotect.c
>>> @@ -161,6 +161,31 @@ static unsigned long change_pte_range(struct =
vm_area_struct *vma, pmd_t *pmd,
>>> 	return pages;
>>> }
>>>=20
>>> +/*
>>> + * Used when setting automatic NUMA hinting protection where it is
>>> + * critical that a numa hinting PMD is not confused with a bad PMD.
>>> + */
>>> +static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t =
*pmd)
>>> +{
>>> +	pmd_t pmdval =3D pmd_read_atomic(pmd);
>>> +
>>> +	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier =
*/
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +	barrier();
>>> +#endif
>>> +
>>> +	if (pmd_none(pmdval))
>>> +		return 1;
>>> +	if (pmd_trans_huge(pmdval))
>>> +		return 0;
>>> +	if (unlikely(pmd_bad(pmdval))) {
>>> +		pmd_clear_bad(pmd);
>>> +		return 1;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> static inline unsigned long change_pmd_range(struct vm_area_struct =
*vma,
>>> 		pud_t *pud, unsigned long addr, unsigned long end,
>>> 		pgprot_t newprot, int dirty_accountable, int prot_numa)
>>> @@ -178,8 +203,17 @@ static inline unsigned long =
change_pmd_range(struct vm_area_struct *vma,
>>> 		unsigned long this_pages;
>>>=20
>>> 		next =3D pmd_addr_end(addr, end);
>>> -		if (!is_swap_pmd(*pmd) && !pmd_trans_huge(*pmd) && =
!pmd_devmap(*pmd)
>>> -				&& pmd_none_or_clear_bad(pmd))
>>> +
>>> +		/*
>>> +		 * Automatic NUMA balancing walks the tables with =
mmap_sem
>>> +		 * held for read. It's possible a parallel update to =
occur
>>> +		 * between pmd_trans_huge() and a =
pmd_none_or_clear_bad()
>>> +		 * check leading to a false positive and clearing.
>>> +		 * Hence, it's ecessary to atomically read the PMD value
>>> +		 * for all the checks.
>>> +		 */
>>> +		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
>>> +		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
>>> 			goto next;
>>>=20
>>> 		/* invoke the mmu notifier if the pmd is populated */
>>> --=20
>>> 2.24.1
>>>=20
>>>=20
>>=20
>=20

