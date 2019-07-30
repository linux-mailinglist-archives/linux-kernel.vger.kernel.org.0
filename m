Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B47647AA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 15:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfG3Ntp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 09:49:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:41407 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfG3Nto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:49:44 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6UDmwB5006744;
        Tue, 30 Jul 2019 08:48:58 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x6UDmu7O006742;
        Tue, 30 Jul 2019 08:48:56 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 30 Jul 2019 08:48:56 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        christophe leroy <christophe.leroy@c-s.fr>,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] powerpc: workaround clang codegen bug in dcbz
Message-ID: <20190730134856.GO31406@gate.crashing.org>
References: <20190729202542.205309-1-ndesaulniers@google.com> <20190729203246.GA117371@archlinux-threadripper> <20190729215200.GN31406@gate.crashing.org> <CAK8P3a1GQSyCj1L8fFG4Pah8dr5Lanw=1yuimX1o+53ARzOX+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1GQSyCj1L8fFG4Pah8dr5Lanw=1yuimX1o+53ARzOX+Q@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 09:34:28AM +0200, Arnd Bergmann wrote:
> Upon a second look, I think the issue is that the "Z" is an input argument
> when it should be an output. clang decides that it can make a copy of the
> input and pass that into the inline asm. This is not the most efficient
> way, but it seems entirely correct according to the constraints.

Most dcb* (and all icb*) do not change the memory pointed to.  The
memory is an input here, logically as well, and that is obvious.

> Changing it to an output "=Z" constraint seems to make it work:
> 
> https://godbolt.org/z/FwEqHf
> 
> Clang still doesn't use the optimum form, but it passes the correct pointer.

As I said many times already, LLVM does not seem to treat all asm
operands as lvalues.  That is a bug.  And it is critical for memory
operands for example, as should be obvious if you look at at for a few
seconds (you pass *that* memory, not a copy of it).  The thing you pass
has an identity.  It's an lvalue.  This is true for *all* inline asm
operands, not just output operands and memory operands, but it is most
obvious there.

Or, LLVM might have a bug elsewhere.

Either way, the asm is fine, and it has worked fine in GCC since
forever.  Changing this constraint to be an output constraint would
just be obfuscation (we could change *all* operands to *everything* to
be inout ("+") constraints, and it won't affect correctness, just the
reader's sanity).


Segher
