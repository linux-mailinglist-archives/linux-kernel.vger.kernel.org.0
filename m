Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0668964700
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 15:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfGJNbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 09:31:44 -0400
Received: from mengyan1223.wang ([89.208.246.23]:38742 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfGJNbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:31:43 -0400
Received: from xry111-laptop.lan (unknown [124.115.222.149])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id 6FA9465B50;
        Wed, 10 Jul 2019 09:31:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1562765502;
        bh=+kX+n3hyhZoLMZ3AyyBvfYkQJJMtdOnst/LvSxzqXpA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mqTkj8cjCJmnvx6exJv6Jpz9ro4dHyALrUSIGQySKxAAK7oXDazA9KzbOLauSQMMB
         0W2qeRP2dxg1GG66cITqO2o+0b1cOJFAvl3CFRhQipG08u9LUa0B1OnV5wAOeVPs3+
         MF4UV95XoZiUua8QoDJ/NjMogP9j4p8QwloD15BADBa5akXtZQRI9ONv5p+t0/+bJs
         M1Hy+GMkYv8bwtrWNBD3a8Kgbnq8m5/jUWhCIuoV/ICvmWx0ut4oK/s+hpC4LKlzNI
         RRe7LFprMh0bRG3g7bNhxZLAJDlKOshI9UowljkV8z7/QZ0WSoesbEcRkqLvQYgpIB
         sR5d0pIKH1Yzg==
Message-ID: <4f0e830430f46c5f6b90656ec5d3b969d79fe6db.camel@mengyan1223.wang>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     Jiri Kosina <jikos@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Date:   Wed, 10 Jul 2019 21:31:35 +0800
In-Reply-To: <nycvar.YFH.7.76.1907101527380.5899@cbobk.fhfr.pm>
References: <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
         <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
         <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de>
         <201907091727.91CC6C72D8@keescook>
         <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang>
         <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang>
         <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de>
         <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm>
         <20190710132144.GM3402@hirez.programming.kicks-ass.net>
         <nycvar.YFH.7.76.1907101523550.5899@cbobk.fhfr.pm>
         <nycvar.YFH.7.76.1907101527380.5899@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-10 15:28 +0200, Jiri Kosina wrote:
> On Wed, 10 Jul 2019, Jiri Kosina wrote:

> > > > > BUG: unable to handle page fault for address: ffffffff9edc1598
> > > > > #PF: supervisor write access in kernel mode
> > > > > #PF: error_code(0x0003) - permissions violation

> > Hm, and it seems to explode on dereferencing the static_key* in %rsi
> 
> 								  ^^^ %rdi of
> course
> 
> >   21:   48 8b 37                mov    (%rdi),%rsi
> >   24:   83 e6 03                and    $0x3,%esi
> >   27:   48 09 c6                or     %rax,%rsi
> >   2a:*  48 89 37                mov    %rsi,(%rdi)              <-- trapping
> > instruction
> > 
> > which looks odd, as it derefenced it successfully just 3 instructions ago.

It seems the MMU (I guess ?) allows to read it, but disallows to write it:
"supervisor write access in kernel mode".
-- 
Xi Ruoyao <xry111@mengyan1223.wang>
School of Aerospace Science and Technology, Xidian University

