Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF5D49B901
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 01:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfHWXoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 19:44:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36780 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfHWXoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 19:44:22 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i1JEB-0002eX-EZ; Sat, 24 Aug 2019 01:44:19 +0200
Date:   Sat, 24 Aug 2019 01:44:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Mayr <me@sam.st>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] uprobes/x86: fix detection of 32-bit user mode
In-Reply-To: <alpine.DEB.2.21.1908232343470.1939@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1908240142000.1939@nanos.tec.linutronix.de>
References: <20190728152617.7308-1-me@sam.st> <alpine.DEB.2.21.1908232343470.1939@nanos.tec.linutronix.de>
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

On Sat, 24 Aug 2019, Thomas Gleixner wrote:
> On Sun, 28 Jul 2019, Sebastian Mayr wrote:
> 
> > -static inline int sizeof_long(void)
> > +static inline int sizeof_long(struct pt_regs *regs)
> >  {
> > -	return in_ia32_syscall() ? 4 : 8;
> 
>   This wants a comment.
> 
> > +	return user_64bit_mode(regs) ? 8 : 4;

The more simpler one liner is to check

    test_thread_flag(TIF_IA32)

which is only true for IA32 and independent of syscalls, exceptions ...

Thanks,

	tglx
