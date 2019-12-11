Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE8D11B255
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 16:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388136AbfLKPfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 10:35:25 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35738 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388098AbfLKPfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:35:20 -0500
Received: by mail-qt1-f196.google.com with SMTP id s8so6631484qte.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 07:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EEZbVUZTmwHpEhj5IiLNVT7HoJJ6hK9o2EwOkcWd0R0=;
        b=ByyfeRJbC64U8giuaSJyBfvkHapBhK2qAxMJttshjcpu4q7X5Gfa5KndB3Rsx+FfUi
         2f5Chh4ed41jCL/yUvEAObJLLvxAKzSB3oX9f4i85dEtBwM69NnnT1HWQccG3lMNxg2B
         0HxtpM2Bu3pbI0Mll/70NUJy6kuGduaNXfpbgt550b3TM2wZOmIXmZmDdat432CbG13Y
         QnOUIs7h+1UPahghLzsw89qEGjuu+VUedXyzVqknuDAvXHP5Xm8tsXdnalMqEsczvEva
         l2NRBcXAfvXC70PbdFm3ngvap4BqrNr7M9AZr7YXRhuTCxeiTPjTNLqUt1SKt0BGxnlV
         ti+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEZbVUZTmwHpEhj5IiLNVT7HoJJ6hK9o2EwOkcWd0R0=;
        b=p3AjVzn4ecbKAKxev+riDCpfdmQ2L+zWVRcG38TSn+5zKO9b1bBHlaYGaRGvciLQ9I
         twAn8ZkXyYx9CAD153rLP2CC/7uJuJstXd62QN1iIYRK7jePaCTgC5fWOf2bzM9KBBOk
         DAdNNEyI3elXY7Ha6Co/47TLrpS2OIxkMuAkaShTlVouc2+zPQAT2+6ef0bQU4HtlQGt
         /raBBmnxd7vEKt2TNbTf3zqHyT4GpTlCvC7OXzTFyiQ8XDpYz8ntAfzJ3ph9qeP5M8+M
         Oaxr/iFbkaAE/cjUdJgTSGaKJs8qjaLNQLX72TbZZ7CaBrmwCvmg/lxhYzSMgPsySb59
         HWtw==
X-Gm-Message-State: APjAAAWLSaTQhSymqQNqnWfA4EPro2zjEtWCj0oRB4YdoFz0mF7JbUIg
        nytewZRLHY7rBFwwCVHeuYvACQyD2fMQ8en/lZSW/Q==
X-Google-Smtp-Source: APXvYqzPgmO02LvwPR3MASeJmUeTLUSOMZa+8nNfTg7jaNAriHFXi9CTAzkRdwS2y9fl/VgOUeUZWqYTOIkuaCIyzmE=
X-Received: by 2002:aed:2465:: with SMTP id s34mr3283883qtc.158.1576078518501;
 Wed, 11 Dec 2019 07:35:18 -0800 (PST)
MIME-Version: 1.0
References: <CAAeHK+wFBYX8-L-D8w_nep3W=QjYoLAZbc=-0eoWK684wnuayA@mail.gmail.com>
 <Pine.LNX.4.44L0.1912111010490.1549-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1912111010490.1549-100000@iolanthe.rowland.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Dec 2019 16:35:07 +0100
Message-ID: <CACT4Y+aTq7iThhikGNGKsLF61RHcWMY5mh=oTGc6FHv02f1BBQ@mail.gmail.com>
Subject: Re: Re: KASAN: use-after-free Read in usbvision_v4l2_open
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        syzbot <syzbot+7fa38a608b1075dfd634@syzkaller.appspotmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 4:15 PM Alan Stern <stern@rowland.harvard.edu> wrote
>
> On Wed, 11 Dec 2019, Andrey Konovalov wrote:
>
> > On Tue, Dec 10, 2019 at 9:17 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Tue, 10 Dec 2019, syzbot wrote:
> > >
> > > > > On Mon, 9 Dec 2019, syzbot wrote:
> > > >
> > > > >> Hello,
> > > >
> > > > >> syzbot found the following crash on:
> > > >
> > > > >> HEAD commit:    1f22d15c usb: gadget: add raw-gadget interface
> > > > >> git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > >> console output: https://syzkaller.appspot.com/x/log.txt?x=1296f42ae00000
> > > > >> kernel config:
> > > > >> https://syzkaller.appspot.com/x/.config?x=8ccee2968018adcb
> > > > >> dashboard link:
> > > > >> https://syzkaller.appspot.com/bug?extid=c7b0ec009a216143df30
> > > > >> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > >
> > > > >> Unfortunately, I don't have any reproducer for this crash yet.
> > > >
> > > > >> IMPORTANT: if you fix the bug, please add the following tag to the
> > > > >> commit:
> > > > >> Reported-by: syzbot+c7b0ec009a216143df30@syzkaller.appspotmail.com
>
> > > > This crash does not have a reproducer. I cannot test it.
> > >
> > > Let's try the same patch with a different bug report -- one that has a
> > > reproducer.  I assume that syzbot gets the bug identity from the
> > > email's From: line (which has been updated acoordingly) rather than the
> > > Subject: line.
> >
> > Did you get a response for this test? I see the test attempt on the
> > dashboard (the patch failed to build), but I didn't get an email with
> > the result.
>
> No response so far.  On the other hand, syzbot has been a bit slow to
> respond to my tests recently (typical turnaround time is several
> hours).  I don't know what's going on.

The system is busy with bisections. Patch testing takes precedence
over bisection, but only after the current one finished. Bisections
can take a long time, up to days. The way it all works is a total hack
that one can put together in a few days.
