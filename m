Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F54F99ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 20:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKLTk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 14:40:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35616 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfKLTk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:40:57 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUc22-00035Z-4S; Tue, 12 Nov 2019 20:40:54 +0100
Date:   Tue, 12 Nov 2019 20:40:52 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V2 15/16] x86/iopl: Remove legacy IOPL option
In-Reply-To: <CALCETrWsr=KXyg_dc+97StqFHPRkvW_db_b4QvnH+ib9YJ761w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911122040020.1833@nanos.tec.linutronix.de>
References: <20191111220314.519933535@linutronix.de> <20191111223052.990437835@linutronix.de> <CALCETrWsr=KXyg_dc+97StqFHPRkvW_db_b4QvnH+ib9YJ761w@mail.gmail.com>
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
> >
> > From: Thomas Gleixner <tglx@linutronix.de>
> >
> > The IOPL emulation via the I/O bitmap is sufficient. Remove the legacy
> > cruft dealing with the (e)flags based IOPL mechanism.
> 
> Acked-by: Andy Lutomirski <luto@kernel.org>
> 
> But I think you could simplify a little bit and have a single config
> option that controls the iopl() and iopl() syscalls.

You mean turning off both iopl() and ioperm() in one go. Yes, that'd be
possible. Let me look.

Thanks,

	tglx

