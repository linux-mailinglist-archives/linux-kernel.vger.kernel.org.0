Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2533A1457B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 15:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgAVOYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 09:24:42 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:34133 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgAVOYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:24:42 -0500
Received: by mail-qv1-f66.google.com with SMTP id o18so3303206qvf.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 06:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9EOtDPRsqZedtcudRq1AD81ej0463sWnMh8/49dqlNI=;
        b=gOnNFqhwLwiLzMgC2iShGAQOPeyOgZL6M67kZxnUPLtwbIaho7nblhnskv9aZtcHJC
         UbdDJ8DBenTeZBYGTEJCJ6rvtDAmM7f4EJV1wjm4D64QlO6hTs1TodffanUYHxOaqtE+
         KR9q6tcY6RYsomsindbVHCimHLSTwauxeB2gY7oP+fUy96x4Ge8JujEyyHLZabkEoyhi
         +wedyI2nVngEW2MTqfCf9H2gyQ0Zq6Oj6FhRcaTJMiFJ7RemR5lTVUsvV2VTKA5lwN+5
         tn/Oc8B5ok6sSH28fek83bSfh7oavvwVc+OyyNyY52Sn4OU7bugAA9ypUrUBm79Oj6WQ
         2KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EOtDPRsqZedtcudRq1AD81ej0463sWnMh8/49dqlNI=;
        b=jhnLDBhowGnCEOSADeQGQCqiVE++BrjWsbJjhsgYOdBTub0Ke7gHulvqKrsJt6wMY8
         BWZqhwpYE1aWlPbHye/cfS46z1LKyC98FfjS/DNGzexJ2C4FuARwjQwaumtINZBzX6TI
         KjYPHG5VIOSUU/OlpJ0bX/XRI201ytuoHIGbSN0eWhiccp5bEu9Soa1eKyIOUzvSlGr1
         6aE6f1z6gkA3miDnuOTRz++ME1AXDb87EuaviOyx4Kpb72q+q43okA2eVPu3n6JHb1Qe
         W8+xtzOE7g4wO4awVyDxBm3Fv8849HFxhOKnpwVYRrMqjup8uhtwBr1+2jed1X6F4NpJ
         dfnA==
X-Gm-Message-State: APjAAAVGjvQ6+JGxvdFdALXpHFs69wKvzS9alJ9+vDOg96t4ypaT5aFs
        m4PmqHyKtc5ch7ePbe04YyPuILd0vgjspfHQFXASXg==
X-Google-Smtp-Source: APXvYqyr3UHmh9dEw4tsZ5jCd1wIGOCJ1jSpzdVLE5X9QzWaQId3N5ZsjbTR56ZpOPYQR/BtwhB/EGj0xC3hlNIuq6w=
X-Received: by 2002:a0c:c351:: with SMTP id j17mr10856301qvi.80.1579703080516;
 Wed, 22 Jan 2020 06:24:40 -0800 (PST)
MIME-Version: 1.0
References: <000000000000951cea059cba579b@google.com>
In-Reply-To: <000000000000951cea059cba579b@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 22 Jan 2020 15:24:27 +0100
Message-ID: <CACT4Y+YJmVWFEhdWCtF391EM6qN5OBGTBFLuK4tLL61RiQr+MQ@mail.gmail.com>
Subject: Re: linux-next build error (7)
To:     syzbot <syzbot+dc92421ed22129134c0f@syzkaller.appspotmail.com>,
        steven.price@arm.com, Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 2:17 PM syzbot
<syzbot+dc92421ed22129134c0f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    ba0b4dfd Add linux-next specific files for 20200122
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17caa985e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7b604c617a6b217c
> dashboard link: https://syzkaller.appspot.com/bug?extid=dc92421ed22129134c0f
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+dc92421ed22129134c0f@syzkaller.appspotmail.com
>
> /syzkaller/managers/upstream-linux-next-kasan-gce-root/kernel/arch/x86/platform/efi/efi_64.c:560: undefined reference to `__efi64_thunk'
> /syzkaller/managers/upstream-linux-next-kasan-gce-root/kernel/arch/x86/platform/efi/efi_64.c:902: undefined reference to `efi_uv1_memmap_phys_prolog'
> /syzkaller/managers/upstream-linux-next-kasan-gce-root/kernel/arch/x86/platform/efi/efi_64.c:921: undefined reference to `efi_uv1_memmap_phys_epilog'

There are 2 recent commits in linux-next touching this file:

commit 6616face70e25c80420539075a943ac1bc9b990c
Date:   Wed Jan 22 09:12:37 2020 +1100
    x86: mm+efi: convert ptdump_walk_pgd_level() to take a mm_struct

commit 3cc028619e284188cdde652631e1c3c5a83692b9
Date:   Sat Jan 18 17:57:03 2020 +0100
    efi/x86: avoid KASAN false positives when accessing the 1: 1 mapping

Not sure which one is this. But linux-next is build broken.
