Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFC167A3C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 15:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfGMNRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 09:17:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:40756 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfGMNRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 09:17:05 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6DDGjIS013036;
        Sat, 13 Jul 2019 08:16:45 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x6DDGhtO013034;
        Sat, 13 Jul 2019 08:16:43 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 13 Jul 2019 08:16:43 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
Message-ID: <20190713131642.GU14074@gate.crashing.org>
References: <20190713032106.8509-1-yamada.masahiro@socionext.com> <20190713124744.GS14074@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713124744.GS14074@gate.crashing.org>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 07:47:44AM -0500, Segher Boessenkool wrote:
> On Sat, Jul 13, 2019 at 12:21:06PM +0900, Masahiro Yamada wrote:
> > The KBUILD_ARFLAGS addition in arch/powerpc/Makefile has never worked
> > in a useful way because it is always overridden by the following code
> > in the top Makefile:
> > 
> >   # use the deterministic mode of AR if available
> >   KBUILD_ARFLAGS := $(call ar-option,D)
> > 
> > The code in the top Makefile was added in 2011, by commit 40df759e2b9e
> > ("kbuild: Fix build with binutils <= 2.19").
> > 
> > The KBUILD_ARFLAGS addition for ppc has always been dead code from the
> > beginning.
> 
> That was added in 43c9127d94d6 to replace my 8995ac870273 from 2007.
> 
> Is it no longer supported to build a 64-bit kernel with a toolchain
> that defaults to 32-bit, or the other way around?  And with non-native
> toolchains (this one didn't run on Linux, even).

It was an --enable-targets=all toolchain, somewhat common for crosses,
if that matters.


Segher
