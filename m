Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0A2F96A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 18:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKLRIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 12:08:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35012 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:08:53 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUZet-00089z-Jc; Tue, 12 Nov 2019 18:08:51 +0100
Date:   Tue, 12 Nov 2019 18:08:50 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V2 07/16] x86/ioperm: Move iobitmap data into a struct
In-Reply-To: <CALCETrX=T+d2ygrcGKMJpb+Dwz-E8cGWLB8=67eV-gXjd77Dhw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911121808360.1833@nanos.tec.linutronix.de>
References: <20191111220314.519933535@linutronix.de> <20191111223052.199713620@linutronix.de> <CALCETrX=T+d2ygrcGKMJpb+Dwz-E8cGWLB8=67eV-gXjd77Dhw@mail.gmail.com>
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

On Tue, 12 Nov 2019, Andy Lutomirski wrote:
> On Mon, Nov 11, 2019 at 2:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > --- /dev/null
> > +++ b/arch/x86/include/asm/iobitmap.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_X86_IOBITMAP_H
> > +#define _ASM_X86_IOBITMAP_H
> > +
> > +#include <asm/processor.h>
> > +
> > +struct io_bitmap {
> > +       unsigned int            io_bitmap_max;
> > +       union {
> > +               unsigned long   bits[IO_BITMAP_LONGS];
> > +               unsigned char   bitmap_bytes[IO_BITMAP_BYTES];
> > +       };
> 
> Now that you have bytes and longs, can you rename io_bitmap_max so
> it's obvious which one it refers to?

Sure.

