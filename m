Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A311529492
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 11:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390011AbfEXJY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 05:24:26 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39950 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389788AbfEXJY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 05:24:26 -0400
Received: by mail-it1-f193.google.com with SMTP id h11so12807763itf.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 02:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HYgiw9gdlhueg6+WRAGyhJKX3AtGrR1zYnjTbOTRfuY=;
        b=wFonep2dku0EgPsJQkwjn4qapIzbxEItS07MsYZtekZBxqqCxFWH+MeuyJ6bjDF28a
         KpuMxHLx4Dey+j1/UoQ0wEodShezvwCAaVP8ACNkyacJvevRpu9drmOiaT4m7EKklQqk
         jQU3VG3IbBvFEEQ+u2u2r/Z4MWdh9ywg9cey7DPiNvK/PTrUhJdOQ4lcCn+invrdaAB9
         x/MFN1bt83Gy7Rpatti38cgt1xZ5RA1W4y+lRbbLgzBM7IYWHHeSbgceaYm3DhNY1M1Z
         uftoxhYDz76QZHEF+QurEEU+8+XHbJ3lQGO1ZP47YB5JC53IIMAZtqQX7S8S95j5YX1g
         xlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HYgiw9gdlhueg6+WRAGyhJKX3AtGrR1zYnjTbOTRfuY=;
        b=KS3WxqJVvgdNKsa13pRgE+N3/Mo37LYe7K88aze65ChyUm+/2afR0MMOXDkK6sdbP8
         8CHBa7s5LPu8CmCjipj7+NxFvOsF+TQuQUhjoNP5WJUB5ABCRaP5ILx7O+rlC22TNNMe
         wX7S50bbX786Je6+nKcbnhZc1nXpYKWmspfQOs3CnBe/f7oS9VQVtSe0RVGnT97l21fH
         og3e0Df+xS54SHkJ/ayCb2yehASk1o33sUeqOa3LswX7NjfTKFVOIbN1vHf96axnpNfP
         t79/3iFGFCBo4sUEMXwNtyfjsu5HcFsR3uTkV/LMDUnXrvOQbBWk8dvJP4NydUvQ9ayC
         Wswg==
X-Gm-Message-State: APjAAAWqcAygilUmnc279RbRCtFt+SXpxqUZ3Izl0wHzVYJ/xQB7okA7
        IyZ3rVt78RHEFd+vBbrsIq9Rr5rb90AtmteeZfcK2g==
X-Google-Smtp-Source: APXvYqzSFjcTrQ2rHAw6gfH24REoDGsW3b8LRVtsKU42COArxlGqgL+aTZ/NtgQ7xnvLKEwhjywv57YGeuFjAvP552U=
X-Received: by 2002:a02:1384:: with SMTP id 126mr60762476jaz.72.1558689865209;
 Fri, 24 May 2019 02:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008666df05899b7663@google.com> <649cac1e-c77c-daf8-6ae7-b02c8571b988@iogearbox.net>
In-Reply-To: <649cac1e-c77c-daf8-6ae7-b02c8571b988@iogearbox.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 24 May 2019 11:24:14 +0200
Message-ID: <CACT4Y+Y_iA=5Bdtcg+X-ky7Q3m5hxGOexo+246b6b2ow_GLUGg@mail.gmail.com>
Subject: Re: bpf build error
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     syzbot <syzbot+cbe357153903f8d9409a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:08 AM Daniel Borkmann <daniel@iogearbox.net> wro=
te:
>
> On 05/24/2019 07:28 AM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    e6f6cd0d bpf: sockmap, fix use after free from sleep in=
 ps..
> > git tree:       bpf
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16f116e4a00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfc045131472=
947d7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dcbe357153903f=
8d9409a
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> > Reported-by: syzbot+cbe357153903f8d9409a@syzkaller.appspotmail.com
> >
> > net/core/skbuff.c:2340:6: error: =E2=80=98struct msghdr=E2=80=99 has no=
 member named =E2=80=98flags=E2=80=99
>
> Disregard, tossed from bpf tree.

Let's close it then

#syz invalid

or it will hang open on the dashboard distracting people looking for
open bugs and new bpf build breakages won't be reported.
