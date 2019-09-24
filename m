Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA877BCA45
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 16:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441377AbfIXOdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 10:33:13 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49125 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2393376AbfIXOdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:33:13 -0400
Received: (qmail 8661 invoked by uid 500); 24 Sep 2019 10:33:12 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Sep 2019 10:33:12 -0400
Date:   Tue, 24 Sep 2019 10:33:12 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     syzbot <syzbot+dbd38fbb686a9681143a@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in open_rio
In-Reply-To: <CAAeHK+wE8ngx2Pa9=vD6Fw6MCbHpxfX6ss97deQUsmGD_Bw_Bw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1909241031550.6144-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019, Andrey Konovalov wrote:

> On Tue, Sep 24, 2019 at 4:19 PM syzbot
> <syzbot+dbd38fbb686a9681143a@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    d9e63adc usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1602b303600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f4fa60e981ee8e6a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=dbd38fbb686a9681143a
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+dbd38fbb686a9681143a@syzkaller.appspotmail.com

> Most probably the same bug:
> 
> https://syzkaller.appspot.com/bug?extid=745b0dff8028f9488eba
> 
> #syz dup: KASAN: invalid-free in disconnect_rio (2)

Even more to the point, a patch was recently posted to the mailing list 
to remove the rio500 driver entirely:

	https://marc.info/?l=linux-usb&m=156925553004947&w=2

Alan Stern

