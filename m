Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C781F6B97
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 22:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfKJVWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 16:22:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55043 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfKJVV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:21:59 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iTuef-0003aT-RX; Sun, 10 Nov 2019 22:21:54 +0100
Date:   Sun, 10 Nov 2019 22:21:52 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 7/9] x86/iopl: Restrict iopl() permission scope
In-Reply-To: <CALCETrXLNub_pTMKvVQiq26=8VQPnx865+w0e-ZnHEg9a397_A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911102214250.12583@nanos.tec.linutronix.de>
References: <20191106193459.581614484@linutronix.de> <20191106202806.425388355@linutronix.de> <a1afc4bb-c90e-db58-42f2-da91a50b1872@kernel.org> <alpine.DEB.2.21.1911102125110.12583@nanos.tec.linutronix.de>
 <CALCETrXLNub_pTMKvVQiq26=8VQPnx865+w0e-ZnHEg9a397_A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Nov 2019, Andy Lutomirski wrote:
> On Sun, Nov 10, 2019 at 12:31 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Sun, 10 Nov 2019, Andy Lutomirski wrote:
> > > On 11/6/19 11:35 AM, Thomas Gleixner wrote:
> > > > +
> > > > +   if (IS_ENABLED(CONFIG_X86_IOPL_EMULATION)) {
> > > > +           struct tss_struct *tss;
> > > > +           unsigned int tss_base;
> > > > +
> > > > +           /* Prevent racing against a task switch */
> > > > +           preempt_disable();
> > > > +           tss = this_cpu_ptr(&cpu_tss_rw);
> > > > +           if (level == 3) {
> > > > +                   /* Grant access to all I/O ports */
> > > > +                   set_thread_flag(TIF_IO_BITMAP);
> > > > +                   tss_base = IO_BITMAP_OFFSET_VALID_ALL;
> > >
> > > Where is the actual TSS updated?
> >
> > Here. It sets the offset to the all zero bitmap. That's all it needs.
> 
> Ah, I see.
> 
> > > I think what you need to do is have a single function, called by
> > > exit_thread(), switch_to(), and here, that updates the TSS to match a
> > > given task's IO bitmap state.  This is probably switch_to_bitmap() or
> > > similar.
> >
> > Well, no. exit_thread() and this here actually fiddle with the TIF bit
> > which is not what the switch to case does. There is some stuff which can be
> > shared.
> 
> I was thinking that the code that read iopl_emul and t->io_bitmap_ptr
> and updated x86_tss.io_bitmap_base could be factored out of
> switch_to().  Suppose you call that tss_update_io_bitmap().  And you
> could have another tiny helper:
> 
> static void update_tif_io_bitmap(void)
> {
>   if (...->iopl_emul || ...->io_bitmap_ptr)
>     set_thread_flag(TIF_IO_BITMAP);
>   else
>     clear_thread_flag(TIF_IO_BITMAP);
> }
> 
> Then the whole iopl emulation path becomes:

Yes. I'm almost done with that already :)
> > It's in that very same patch:
> >
> > > -static void tss_update_io_bitmap(struct tss_struct *tss,
> > > -                                struct thread_struct *thread)
> 
> But where did the line you just deleted come from?  I'm obviously just
> bad at reading emails somewhere.

patch 5/9 :)
 
Let me finish that stuff and send out another version which has that reuse
of the switch to code in a separate patch.

There is another new detail in the series. I split out all the io bitmap
data into a separate data struct, which also allows me to stick a refcount
into it which removes the kmemdup() from the fork path.

Thanks,

	tglx
