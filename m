Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B8B780DF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfG1SOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 14:14:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51907 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfG1SOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 14:14:39 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrngi-0007fX-1T; Sun, 28 Jul 2019 20:14:28 +0200
Date:   Sun, 28 Jul 2019 20:14:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace
 on i386
In-Reply-To: <CAK8P3a0dC5ti8nVMK8-NmmTYeEfKPdLpVf0zrQEnq76fUvh1oA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907282013310.1791@nanos.tec.linutronix.de>
References: <201907221012.41504DCD@keescook> <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de> <201907221135.2C2D262D8@keescook> <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com> <201907221620.F31B9A082@keescook>
 <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com> <201907231437.DB20BEBD3@keescook> <alpine.DEB.2.21.1907240038001.27812@nanos.tec.linutronix.de> <201907231636.AD3ED717D@keescook> <alpine.DEB.2.21.1907240155080.2034@nanos.tec.linutronix.de>
 <20190726180103.GE3188@linux.intel.com> <CALCETrUe50sbMx+Pg+fQdVFVeZ_zTffNWGJUmYy53fcHNrOhrQ@mail.gmail.com> <CAK8P3a3_tki1mi4OjLJdaGLwVA7JE0wE1kczE_q7kEpr5e8sMQ@mail.gmail.com> <alpine.DEB.2.21.1907281225410.1791@nanos.tec.linutronix.de>
 <CAK8P3a0dC5ti8nVMK8-NmmTYeEfKPdLpVf0zrQEnq76fUvh1oA@mail.gmail.com>
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

On Sun, 28 Jul 2019, Arnd Bergmann wrote:

> On Sun, Jul 28, 2019 at 12:30 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Sun, 28 Jul 2019, Arnd Bergmann wrote:
> > > On Sat, Jul 27, 2019 at 7:53 PM Andy Lutomirski <luto@kernel.org> wrote:
> 
> > Which is totally irrelevant because res is NULL and that NULL pointer check
> > should simply return -EFAULT, which is what the syscall fallback returns
> > because the pointer is NULL.
> >
> > But that NULL pointer check is inconsistent anyway:
> >
> >  - 64 bit does not have it and never had
> >
> >  - the vdso is not capable of handling faults properly anyway. If the
> >    pointer is not valid, then it will segfault. So just preventing the
> >    segfault for NULL is silly.
> >
> > I'm going to just remove it.
> 
> Ah, you are right, I misread.
> 
> Anyway, if we want to keep the traditional behavior and get fewer surprises
> for users of seccomp and anything else that might observe clock_gettime
> behavior, below is how I'd do it. (not even build tested, x86-only. I'll
> send a proper patch if this is where we want to take it).

I posted a series which fixes up the mess 2 hours before you sent this mail :)
