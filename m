Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C9318FA44
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 17:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgCWQpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 12:45:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33912 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgCWQpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:45:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id t3so7484137pgn.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7erQfF+qqDwND3ylPP5gvL50DvRnfbR+337QCSJOWg=;
        b=BqgLw6YK0fCGmlwlUq2U9m5+BOnoOGb6uxfB82uNv6pmtyYEaPi0S1mut35YyDOtYI
         2vSEcewRapTVqZFCXC9RC9e8FbE8vDjXx+YSvEeN24OP1vqqWDfstdguHqkNXcsKZAZ0
         WDSQ5jersECj9ahOpLS6P8bWpxmEWsvKAUQJO0OxwUQIqg6X0DxibRZqfgyvIf331wlZ
         NnWsJwnkyF6sMoENhS3aQU8IrOiINR1oLjjhsBJFloY9kgOtWRjd0LoQGeXUexLO+wBv
         jV5stIOKNeLXoKd3vN3gp2YaKa61QIfyjsctE50OHAeAtAIkn8fU+PuvHjQl7LpDmwAu
         fj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7erQfF+qqDwND3ylPP5gvL50DvRnfbR+337QCSJOWg=;
        b=C9JoZQVA/dgWFsern6iEiy/uAbZRx51m8fjZd5hnguDJHxO9/59TIMFKui5Q3WoiEU
         RcWN7kQzJfM7xEYhA+x3m5ScBtfljOgmBonuwYCgwMrGDrzLUyoQWz3v22VlWcWIQGMB
         wXIDsMKdIX3vFXVLAuuWnh2GaF/epGIzkCzvmTso/jiuWSdyBKFtMl4LrkJn2o8OUzHQ
         /QAUVjbmLNXMRlg28WoIUZ28v3yAMSEL5gZ4ofHkOV0bW+yqjBhUppPuf4z2LWf3af8c
         Tf7CfqOmfsyJm5nU2RWJ0dA/pnUUUlq3gW0H9L2n7z/gpRPbEIYuimvcJ0XFsgFpK50P
         Efmg==
X-Gm-Message-State: ANhLgQ2d8AgAH8gKzY4P/TautmhqqvxaTIM3eYjrnFSQOwaJXcuTpdA7
        Xty9TF1Ts1taKy8xMHHtIBx4GW9Ii0TWEk7IiUKRig==
X-Google-Smtp-Source: ADFU+vtTWC+3e0hgu5sR7c8nsBElA/8yhjLWg38EN0vSS/iqghwtAHQPjULAOsoEZirveksBfESFwrkb4loUrz50q9A=
X-Received: by 2002:aa7:8b15:: with SMTP id f21mr5875990pfd.306.1584981928768;
 Mon, 23 Mar 2020 09:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAEAjamtb2Kbn0He5O++=d_HCG1eQvLnGGbcVUOQ76+NfDiNybQ@mail.gmail.com>
In-Reply-To: <CAEAjamtb2Kbn0He5O++=d_HCG1eQvLnGGbcVUOQ76+NfDiNybQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 23 Mar 2020 17:45:17 +0100
Message-ID: <CAAeHK+zy+seoWm7avxGSEXwoR1tuqHyO00eA_SWk3CC-ngbmLQ@mail.gmail.com>
Subject: Re: BUG: KASAN: use-after-free in usb_hcd_unlink_urb+0x5f/0x170 drivers/usb/core/hcd.c
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, laurentiu.tudor@nxp.com,
        noring@nocrew.org, Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        tony@atomide.com, rrangel@chromium.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Dave Tian <dave.jing.tian@gmail.com>, linux-usb@vger.kernel.og,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 7:16 AM Kyungtae Kim <kt0755@gmail.com> wrote:
>
> We report a bug (in linux-5.5.11) found by FuzzUSB (a modified version
> of syzkaller)

Hi Kyungtae,

Sounds interesting! Could you share what approach to USB fuzzing you
have taken? Based on the stack trace I see you're fuzzing the USB
storage layer, for which we don't yet have any descriptions in
syzkaller's USB fuzzer itself [1].

Thanks!

[1] https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_usb.md

>
> In function usb_hcd_unlink_urb (driver/usb/core/hcd.c:1607), it tries to
> read "urb->use_count". But it seems the instance "urb" was
> already freed (right after urb->dev at line 1597) by the function "urb_destroy"
> in a different thread, which caused memory access violation.
> To solve, it may need to check if urb is valid before urb->use_count,
> to avoid such freed memory access.
>
> kernel config: https://kt0755.github.io/etc/config_v5.5.11
>
> ==================================================================
> BUG: KASAN: use-after-free in atomic_read
> include/asm-generic/atomic-instrumented.h:26 [inline]
> BUG: KASAN: use-after-free in usb_hcd_unlink_urb+0x5f/0x170
> drivers/usb/core/hcd.c:1607
> Read of size 4 at addr ffff888065379610 by task kworker/u4:1/27
>
> CPU: 1 PID: 27 Comm: kworker/u4:1 Not tainted 5.5.11 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.10.2-1ubuntu1 04/01/2014
> Workqueue: scsi_tmf_2 scmd_eh_abort_handler
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xce/0x128 lib/dump_stack.c:118
>  print_address_description.constprop.4+0x21/0x3c0 mm/kasan/report.c:374
>  __kasan_report+0x153/0x1cb mm/kasan/report.c:506
>  kasan_report+0x12/0x20 mm/kasan/common.c:639
>  check_memory_region_inline mm/kasan/generic.c:185 [inline]
>  check_memory_region+0x152/0x1b0 mm/kasan/generic.c:192
>  __kasan_check_read+0x11/0x20 mm/kasan/common.c:95
>  atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
>  usb_hcd_unlink_urb+0x5f/0x170 drivers/usb/core/hcd.c:1607
>  usb_unlink_urb+0x72/0xb0 drivers/usb/core/urb.c:657
>  usb_sg_cancel+0x14e/0x290 drivers/usb/core/message.c:602
>  usb_stor_stop_transport+0x5e/0xa0 drivers/usb/storage/transport.c:937
>  command_abort+0x19d/0x200 drivers/usb/storage/scsiglue.c:439
>  scsi_try_to_abort_cmd drivers/scsi/scsi_error.c:927 [inline]
>  scmd_eh_abort_handler+0x18e/0x410 drivers/scsi/scsi_error.c:145
>  process_one_work+0x9dd/0x1710 kernel/workqueue.c:2266
>  worker_thread+0x8b/0xc40 kernel/workqueue.c:2412
>  kthread+0x35f/0x440 kernel/kthread.c:255
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>
> Allocated by task 2532:
>  save_stack+0x21/0x90 mm/kasan/common.c:72
>  set_track mm/kasan/common.c:80 [inline]
>  __kasan_kmalloc.constprop.3+0xa7/0xd0 mm/kasan/common.c:513
>  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
>  __kmalloc+0x148/0x380 mm/slub.c:3812
>  kmalloc include/linux/slab.h:561 [inline]
>  usb_alloc_urb+0x42/0x90 drivers/usb/core/urb.c:74
>  usb_sg_init+0x323/0xa00 drivers/usb/core/message.c:406
>  usb_stor_bulk_transfer_sglist+0xbe/0x280 drivers/usb/storage/transport.c:423
>  usb_stor_bulk_srb+0x10d/0x230 drivers/usb/storage/transport.c:465
>  usb_stor_Bulk_transport+0x55f/0x1060 drivers/usb/storage/transport.c:1161
>  usb_stor_invoke_transport+0xef/0x15f0 drivers/usb/storage/transport.c:606
>  usb_stor_transparent_scsi_command+0x1d/0x30 drivers/usb/storage/protocol.c:108
>  usb_stor_control_thread+0x6d8/0xa80 drivers/usb/storage/usb.c:380
>  kthread+0x35f/0x440 kernel/kthread.c:255
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>
> Freed by task 2532:
>  save_stack+0x21/0x90 mm/kasan/common.c:72
>  set_track mm/kasan/common.c:80 [inline]
>  kasan_set_free_info mm/kasan/common.c:335 [inline]
>  __kasan_slab_free+0x135/0x190 mm/kasan/common.c:474
>  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
>  slab_free_hook mm/slub.c:1425 [inline]
>  slab_free_freelist_hook mm/slub.c:1458 [inline]
>  slab_free mm/slub.c:3005 [inline]
>  kfree+0xf7/0x410 mm/slub.c:3966
>  urb_destroy drivers/usb/core/urb.c:26 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  usb_free_urb.part.0+0x95/0x100 drivers/usb/core/urb.c:96
>  usb_free_urb+0x1f/0x30 drivers/usb/core/urb.c:95
>  sg_clean+0x111/0x270 drivers/usb/core/message.c:263
>  usb_sg_wait+0x26d/0x440 drivers/usb/core/message.c:573
>  usb_stor_bulk_transfer_sglist+0x127/0x280 drivers/usb/storage/transport.c:447
>  usb_stor_bulk_srb+0x10d/0x230 drivers/usb/storage/transport.c:465
>  usb_stor_Bulk_transport+0x55f/0x1060 drivers/usb/storage/transport.c:1161
>  usb_stor_invoke_transport+0xef/0x15f0 drivers/usb/storage/transport.c:606
>  usb_stor_transparent_scsi_command+0x1d/0x30 drivers/usb/storage/protocol.c:108
>  usb_stor_control_thread+0x6d8/0xa80 drivers/usb/storage/usb.c:380
>  kthread+0x35f/0x440 kernel/kthread.c:255
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>
> The buggy address belongs to the object at ffff888065379600
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 16 bytes inside of
>  192-byte region [ffff888065379600, ffff8880653796c0)
> The buggy address belongs to the page:
> page:ffffea000194de40 refcount:1 mapcount:0 mapping:ffff88806c002a00 index:0x0
> flags: 0x100000000000200(slab)
> raw: 0100000000000200 ffffea0000ee7a00 0000000500000005 ffff88806c002a00
> raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff888065379500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888065379580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> >ffff888065379600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                          ^
>  ffff888065379680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff888065379700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/CAEAjamtb2Kbn0He5O%2B%2B%3Dd_HCG1eQvLnGGbcVUOQ76%2BNfDiNybQ%40mail.gmail.com.
