Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A25CC5DA12
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 03:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfGCBAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 21:00:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49758 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfGCBAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:00:34 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hiR8Q-00008n-Tp; Wed, 03 Jul 2019 00:20:23 +0200
Date:   Wed, 3 Jul 2019 00:20:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Craig Topper <craig.topper@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Bill Wendling <morbo@google.com>,
        Stephen Hines <srhines@google.com>,
        Chandler Carruth <chandlerc@google.com>
Subject: Re: objtool warnings in prerelease clang-9
In-Reply-To: <CAKwvOdn-=u1v8B1ni8QqiOXaimhc_tG6O=8kMb4c2vv62=D42g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907030018170.1802@nanos.tec.linutronix.de>
References: <CAKwvOdnGL_9cJ+ETNce89+z7CTDctjACS8DFsLu=ev4+vkVkUw@mail.gmail.com> <alpine.DEB.2.21.1907022332000.1802@nanos.tec.linutronix.de> <CAKwvOdn-=u1v8B1ni8QqiOXaimhc_tG6O=8kMb4c2vv62=D42g@mail.gmail.com>
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

Nick,

On Tue, 2 Jul 2019, Nick Desaulniers wrote:
> On Tue, Jul 2, 2019 at 2:58 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 2 Jul 2019, Nick Desaulniers wrote:
> 
> > > This causes objtool to not find any issues in
> > > arch/x86/kernel/cpu/mtrr/generic.o.  I don't observe any duplication
> > > in the __jump_table section of the resulting .o file.  It also cuts
> > > down the objtool warnings I observe in a defconfig (listed at the
> > > beginning of the email) from 4 to 2. (platform-quirks.o predates asm
> > > goto,
> >
> > It does not have asm goto inside :)
> 
> I think you're conflating arch/x86/kernel/cpu/mtrr/generic.o with
> arch/x86/kernel/platform-quirks.o.

Nope. I deliberately split the quote after the platform-quirks part so the
reply goes near to it. Seems it wasn't as obvious as I thought :)

Thanks,

	tglx


