Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F9110CBB3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 16:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfK1P3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 10:29:32 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36974 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfK1P3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:29:31 -0500
Received: by mail-oi1-f196.google.com with SMTP id 128so15547586oih.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8jbWiJP8zuPwo1h57bhn9bSCas9rrkjtaMb7mPh1IdA=;
        b=N+fcqekoOxQDhlpJGKAWkheEt+gN07VZ81/73rXPn1PTzGgsLa3Rcmh9TY+xjk+3Ih
         qDS65BfoaV4kxITCwQ9aynD1HSih7wmCgb7HKN1o0H2yuxRclj9Ujkcv+DZ9XG9qqLfs
         gYcHNBi7EmNxtYpBo1DwprVnLxrTtjU6Ewc2Z1bEnBpr9dgcHgNpZdxeFGtuNGpYZLXB
         hvMrqTF858ayZPTPJw8NVYywiC4NY9H/sx9/Hg0jnT8HOwWZT4svLjw62xcIlt+rlAQX
         SzBMJVlbbVULZs/zzvLYp6VnC0pl64WDBL9U0f3CF54c3vg/K2F81DElVEZbPOtUntZY
         PnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jbWiJP8zuPwo1h57bhn9bSCas9rrkjtaMb7mPh1IdA=;
        b=i2L4vQb2nD3mXvewh1bhkycF+VO8F29x8WNz3/k64lfmF9rGmvagNClmlV3gkWpKWD
         HFJYVBn2ZInRQVW2zt6j8VrYI9GI+MDcCsu0/L+naOEMC6L5RI7C1oiw3JU1loAw48fS
         45f7RRuCYy1h5gpZp3u6/T7X3qIkg+g3i430riIakZWXhSOIefNhoRtUngdKXgxqFoJV
         YBt5jaQQqh4QUVOe/JDd2mWYqL8YzhouOC6U8Ueb9pByLqBjjzz39UYnBaNvwhKsZ7SA
         AJ3dNxRmhO19WSK/yCQ4D234IYJKrfAnxuQBNubF8jIioY0a8hT1smr0WEi0MYMHVRqU
         XXJQ==
X-Gm-Message-State: APjAAAUaiP7540wFzQcN41Ukt32yELtQD3CS/gVXlxAW4+TPKovQptKn
        Js41qwu/+wzC00iCOEOC+xyGdsfxErztTUJhf4HGNw==
X-Google-Smtp-Source: APXvYqwQF8gySZpP3ML3y1V5QupQwMNy5TOx2Z2uDdHPjHuyVgwkY34m3prkUOx4mIROyml0+fITWq8uzCmVDZn6HVs=
X-Received: by 2002:aca:d783:: with SMTP id o125mr1403513oig.68.1574954969803;
 Thu, 28 Nov 2019 07:29:29 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009f46d4059863fdea@google.com> <71b86056-944f-c5e1-b4cf-35833a82761c@kernel.dk>
In-Reply-To: <71b86056-944f-c5e1-b4cf-35833a82761c@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 Nov 2019 16:29:03 +0100
Message-ID: <CAG48ez09ZN2v2rTvnSgybrZu7BAa28vcnkcOU=Z7549rbpqz1A@mail.gmail.com>
Subject: Re: INFO: trying to register non-static key in io_cqring_overflow_flush
To:     Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+be9e13497969768c0e6e@syzkaller.appspotmail.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 4:19 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 11/28/19 12:35 AM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    d7688697 Merge tag 'for-linus' of git://git.kernel.org/pub..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=145e5fcee00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=12f2051e3d8cdb3f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=be9e13497969768c0e6e
> > compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> > 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146c517ae00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16550b12e00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+be9e13497969768c0e6e@syzkaller.appspotmail.com
>
> This is the same as:
>
> syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com

syzbot listens to specific commands, see
<https://github.com/google/syzkaller/blob/master/docs/syzbot.md#status>
(linked in the report):

#syz dup: INFO: trying to register non-static key in io_cqring_ev_posted
