Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5FF6E11E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 08:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfGSGo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 02:44:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59387 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfGSGo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 02:44:26 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hoMcx-00076v-8g; Fri, 19 Jul 2019 08:44:23 +0200
Date:   Fri, 19 Jul 2019 08:44:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: x86 - clang / objtool status
In-Reply-To: <CAKwvOdkYKweg5A6jwomPUjjkRWq5=oVMVM=Wcg=ho+crOnr3Ew@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907190812040.1785@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de> <CAKwvOdkYKweg5A6jwomPUjjkRWq5=oVMVM=Wcg=ho+crOnr3Ew@mail.gmail.com>
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

On Thu, 18 Jul 2019, Nick Desaulniers wrote:
> On Thu, Jul 18, 2019 at 1:40 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > after picking up Josh's objtool updates I gave clang a test ride again.
> 
> Thanks for testing and the reports; these are valuable and we
> appreciate the help debugging them.
> 
> > 2) debian distro config
> 
> Is this checked into the tree, or where can I find it?

See below.

> >   drivers/gpu/drm/radeon/evergreen_cs.o: warning: objtool: evergreen_cs_parse() falls through to next function evergreen_dma_cs_parse()
> 
> fall through warnings look new to me, but Linaro's KernelCI is
> currently screaming with tons of reports of -Wfallthrough throughout
> the kernel.  I assume they're related?

I don't think so. The compiler does not warn about a missing fallthrough.

> > 3) allmodconfig:
> >
> >   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x56: redundant UACCESS disable
> 
> Do you still have these object files laying around? Josh asked for
> them in a new thread (from the previous thread), not sure if it's ok
> to attach object files to emails to LKML? (html email is not allowed,
> are binary attachments?)

I've uploaded the configs and object files to:

     https://tglx.de/~tglx/clang.tar.bz2

contains:

clang/
clang/debian/
clang/debian/atom.o
clang/debian/platform.o
clang/debian/i915_gem_execbuffer.o
clang/debian/.config
clang/debian/evergreen_cs.o
clang/allmod/
clang/allmod/ubsan.o
clang/allmod/i915_gem_execbuffer.o
clang/allmod/.config
clang/allmod/sata_dwc_460ex.o
clang/allmod/common.o
clang/allmod/signal.o
clang/allmod/ia32_signal.o

i.e. the .config and the offending object files for the debian and
allmodconfig builds.

Thanks,

	tglx


