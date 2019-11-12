Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6A0DF9B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 21:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKLU7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 15:59:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44705 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfKLU7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:59:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id g3so19375509ljl.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnvOYwfa6qDRGH1va7JtPEY4MALggxuc4YXJOwSoKVY=;
        b=bIPT90I+28Y1aSlcbzKemY/unFev3VpktnoJsw2rog25WeOeiXV2YOJCa+ttkBwlSO
         ZR69063yp6U5gZ2TTJIVI23n0ZboiBREakXYprN90R8ijIWb1A+8wIOx1iFnvuHiZoSD
         h/KA9xiVfnbLgjycX8QDmV+3dLXhmJg195C1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnvOYwfa6qDRGH1va7JtPEY4MALggxuc4YXJOwSoKVY=;
        b=O+gVYlSgfnpad1bvSSYeheOd/Y7mLn82YOQ7MWEFdNZReBS6NRBN2Y1s3t9upvKxFg
         h/dZ/EA01E+RZ41uJecc4eSrDkmPmFnsq2DtwTPr1YU9G3SeUtYOu4YCyA92LybINJQ4
         oA58oqy2QGdQRUjAf1sRvQwbvcjuRxqfJboWwYjsHR/jpzwL22CIys75QkprLj1jCdLf
         p3o+NLju1J8om53W9uOFYWN+Bny07Qfituqix+vJWdKT9j3n7lxcBQI5q4Madu+hV3eY
         +GnB08cXIcA8XWjGfYo/MR4XnJuRJ1BtWXrEsT42x5blgvnPq8gJrB11ZFQPKU7v1AJC
         m2oQ==
X-Gm-Message-State: APjAAAW1hezXffnzG81OXmX3YyDYGRZb2j6Vn2+4PuK9MCLJqDEKNnqj
        wLT5cjA7Ns5I+43NJJz7i9aSdJKReDk=
X-Google-Smtp-Source: APXvYqz51oGgmlh3tZI3VXw6ggmkKSfYVNEomEnluqLIyZuVyEM6WDt9SVYGaVBnuHTNx6+R+7jw4A==
X-Received: by 2002:a2e:b5a2:: with SMTP id f2mr21180715ljn.108.1573592354236;
        Tue, 12 Nov 2019 12:59:14 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id m18sm4754494ljg.3.2019.11.12.12.59.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 12:59:13 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id q28so9346lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:59:12 -0800 (PST)
X-Received: by 2002:a19:c790:: with SMTP id x138mr21291173lff.61.1573592352459;
 Tue, 12 Nov 2019 12:59:12 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjGd0Ce2xadkiErPWxVBT2mhyeZ4TKyih2sJwyE3ohdHw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121515400.1567-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1911121515400.1567-100000@iolanthe.rowland.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 12:58:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
Message-ID: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Marco Elver <elver@google.com>, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 12:29 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> I'm trying to solve a real problem: How to tell KCSAN and the compiler
> that we don't care about certain access patterns which result in
> hardware-level races, and how to guarantee that the object code will
> still work correctly when those races occur.  Not telling the compiler
> anything is a head-in-the-sand approach that will be dangerous in the
> long run.

I don't actually know how KCSAN ends up reading the annotations, but
since it's apparently not using the 'volatile' as a marker.

[ Goes off and fetches the thing ]

Ugh, that's just nasty.

Honestly, my preferred model would have been to just add a comment,
and have the reporting tool know to then just ignore it. So something
like

+               // Benign data-race on min_flt
                tsk->min_flt++;
                perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);

for the case that Eric mentioned - the tool would trigger on
"data-race", and the rest of the comment could/should be for humans.
Without making the code uglier, but giving the potential for a nice
leghibl.e explanation instead of a completely illegible "let's
randomly use WRITE_ONCE() here" or something like that.

Could the KCSAN code be taught to do something like that by simply not
instrumenting it? Or, as mentioned, just have the reporting logic
maybe have a list of those comments (easily generated with some
variation of "git grep -in data-race" or something) and logic to just
ignore any report that comes from a line below that kind of comment?

Because I do not see a pretty way to annotate random things like this
that actually makes the code more legible. The READ_ONCE/WRITE_ONCE
annotations have not imho improved the code quality.

                 Linus
