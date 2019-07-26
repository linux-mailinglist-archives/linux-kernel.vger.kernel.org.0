Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF2E7722D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 21:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfGZTaz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 Jul 2019 15:30:55 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:61175 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbfGZTaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:30:55 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17638544-1500050 
        for multiple; Fri, 26 Jul 2019 20:30:43 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Thomas Gleixner <tglx@linutronix.de>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <alpine.DEB.2.21.1907262116530.1791@nanos.tec.linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564086017.git.jpoimboe@redhat.com>
 <alpine.DEB.2.21.1907252355150.1791@nanos.tec.linutronix.de>
 <156416793450.30723.5556760526480191131@skylake-alporthouse-com>
 <alpine.DEB.2.21.1907262116530.1791@nanos.tec.linutronix.de>
Message-ID: <156416944205.21451.12269136304831943624@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: Remove redundant user_access_end() from
 __copy_from_user() error path
Date:   Fri, 26 Jul 2019 20:30:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thomas Gleixner (2019-07-26 20:18:32)
> On Fri, 26 Jul 2019, Chris Wilson wrote:
> > Quoting Thomas Gleixner (2019-07-25 22:55:45)
> > > On Thu, 25 Jul 2019, Josh Poimboeuf wrote:
> > > 
> > > > Objtool reports:
> > > > 
> > > >   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x36: redundant UACCESS disable
> > > > 
> > > > __copy_from_user() already does both STAC and CLAC, so the
> > > > user_access_end() in its error path adds an extra unnecessary CLAC.
> > > > 
> > > > Fixes: 0b2c8f8b6b0c ("i915: fix missing user_access_end() in page fault exception case")
> > > > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/617
> > > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > 
> > > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > 
> > Which tree do you plan to apply it to? I can put in drm-intel, and with
> > the fixes tag it will percolate through to 5.3 and beyond, but if you
> > want to apply it directly to squash the build warnings, feel free.
> 
> It would be nice to get it into 5.3. I can route it linuxwards if you give
> an Acked-by, but I'm happy to hand it to you :)

Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
