Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD1F963E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfHTPOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 11:14:25 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36292 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725983AbfHTPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:14:25 -0400
Received: (qmail 4357 invoked by uid 2102); 20 Aug 2019 11:14:24 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Aug 2019 11:14:24 -0400
Date:   Tue, 20 Aug 2019 11:14:24 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     keescook@chromium.org, <gustavo@embeddedor.com>,
        <andreyknvl@google.com>, <syzkaller-bugs@googlegroups.com>,
        <gregkh@linuxfoundation.org>,
        syzbot <syzbot+cfe6d93e0abab9a0de05@syzkaller.appspotmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: KASAN: use-after-free Read in iowarrior_disconnect
In-Reply-To: <1566311916.11678.26.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.1908201110510.1573-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019, Oliver Neukum wrote:

> Am Dienstag, den 20.08.2019, 10:18 -0400 schrieb Alan Stern:
> > On Mon, 19 Aug 2019, Oliver Neukum wrote:
> > 
> > > Am Montag, den 19.08.2019, 07:48 -0700 schrieb syzbot:
> > > > Hello,
> > > > 
> > > > syzbot found the following crash on:
> > > > 
> > > > HEAD commit:    d0847550 usb-fuzzer: main usb gadget fuzzer driver
> > > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=139be302600000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=dbc9c80cc095da19
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=cfe6d93e0abab9a0de05
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fe6b02600000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1548189c600000
> > > > 
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+cfe6d93e0abab9a0de05@syzkaller.appspotmail.com
> > > > 
> > > 
> > > #syz test: https://github.com/google/kasan.git d0847550
> > 
> > There's no need for us to work at cross purposes on this.  We can go 
> > with your approach.
> > 
> > However, the code is more complicated than your patch accounts for.  
> > The wait can finish in several different ways:
> > 
> > (1)	The control URB succeeds and the interrupt URB gets an 
> > 	acknowledgment.
> > 
> > (2)	The control URB completes with an error.
> > 
> > (3)	The wait times out.
> > 
> > (4)	A disconnect occurs.
> 
> I absolutely agree. There is something quite wrong in this driver.
> Unfortunately this is likely exploitable by a malicious gadget,
> so just ignoring this is a bad option. I will need to go through the
> logic. Or do you want to have a shot at it?
> 
> The patch was really only for testing. I wanted to know whether
> I was hitting this very issue. This driver will need more surgery.

If you would like to work on it, that's fine with me.

Alan Stern

