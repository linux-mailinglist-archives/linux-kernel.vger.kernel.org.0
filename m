Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B75E277FE5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 16:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfG1OmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 10:42:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51762 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfG1OmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 10:42:19 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrkNJ-000562-Sn; Sun, 28 Jul 2019 16:42:14 +0200
Date:   Sun, 28 Jul 2019 16:42:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
Subject: Re: [patch 1/5] lib/vdso/32: Remove inconsistent NULL pointer
 checks
In-Reply-To: <CALCETrXbwPNt-SiudX+xup1vmkjksJpy-GJAT2K-g_dFw6d6vA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907281640380.1791@nanos.tec.linutronix.de>
References: <20190728131251.622415456@linutronix.de> <20190728131648.587523358@linutronix.de> <CALCETrXbwPNt-SiudX+xup1vmkjksJpy-GJAT2K-g_dFw6d6vA@mail.gmail.com>
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

On Sun, 28 Jul 2019, Andy Lutomirski wrote:

> On Sun, Jul 28, 2019 at 6:20 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > The 32bit variants of vdso_clock_gettime()/getres() have a NULL pointer
> > check for the timespec pointer. That's inconsistent vs. 64bit.
> >
> > But the vdso implementation will never be consistent versus the syscall
> > because the only case which it can handle is NULL. Any other invalid
> > pointer will cause a segfault. So special casing NULL is not really useful.
> >
> > Remove it along with the superflouos syscall fallback invocation as that
> > will return -EFAULT anyway. That also gets rid of the dubious typecast
> > which only works because the pointer is NULL.
> 
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
> 
> FWIW, the equivalent change to gettimeofday would be an ABI break,
> since we historically have that check, and it even makes sense there.

Of course, because either of the two pointers can be NULL.

Thanks,

	tglx

