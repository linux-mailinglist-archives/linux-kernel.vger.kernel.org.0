Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA1267C87
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 02:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfGMXy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 19:54:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:59585 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728733AbfGMXyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 19:54:55 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6DNsWTI006207;
        Sat, 13 Jul 2019 18:54:32 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x6DNsUHe006206;
        Sat, 13 Jul 2019 18:54:30 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 13 Jul 2019 18:54:30 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
Message-ID: <20190713235430.GZ14074@gate.crashing.org>
References: <20190713032106.8509-1-yamada.masahiro@socionext.com> <20190713124744.GS14074@gate.crashing.org> <20190713131642.GU14074@gate.crashing.org> <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 07:45:15AM +0900, Masahiro Yamada wrote:
> On Sat, Jul 13, 2019 at 10:17 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > On Sat, Jul 13, 2019 at 07:47:44AM -0500, Segher Boessenkool wrote:
> > > On Sat, Jul 13, 2019 at 12:21:06PM +0900, Masahiro Yamada wrote:
> > > > The KBUILD_ARFLAGS addition in arch/powerpc/Makefile has never worked
> > > > in a useful way because it is always overridden by the following code
> > > > in the top Makefile:
> > > >
> > > >   # use the deterministic mode of AR if available
> > > >   KBUILD_ARFLAGS := $(call ar-option,D)
> > > >
> > > > The code in the top Makefile was added in 2011, by commit 40df759e2b9e
> > > > ("kbuild: Fix build with binutils <= 2.19").
> > > >
> > > > The KBUILD_ARFLAGS addition for ppc has always been dead code from the
> > > > beginning.
> > >
> > > That was added in 43c9127d94d6 to replace my 8995ac870273 from 2007.
> > >
> > > Is it no longer supported to build a 64-bit kernel with a toolchain
> > > that defaults to 32-bit, or the other way around?  And with non-native
> > > toolchains (this one didn't run on Linux, even).
> >
> > It was an --enable-targets=all toolchain, somewhat common for crosses,
> > if that matters.
> 
> I always use the same toolchain
> for compile-testing PPC32/64.
> 
> I have never been hit by the issue you mention.
> Somebody would have reported it if it were still a problem.

But did you use --enable-targets=all?

The problem was empty archives IIRC.  Not a problem anymore with thin
archives, maybe?

> Moreover, commit 43c9127d94d6
> translated the environment variable "GNUTARGET"
> into the command option "--target="
> 
> My powerpc-linux-ar does not know it:
> 
> powerpc-linux-ar: -t: No such file or directory

Yes, that is why I used the environment variable, all binutils work
with that.  There was no --target option in GNU ar before 2.22.


Segher
