Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B80A75AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 00:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfGYWv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 18:51:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47898 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfGYWv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:51:57 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqmaQ-0006N0-3n; Fri, 26 Jul 2019 00:51:46 +0200
Date:   Fri, 26 Jul 2019 00:51:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     mingo@redhat.com, bp@alien8.de, peterz@infradead.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com
Subject: Re: [PATCH v4 0/2] Support kexec/kdump for clang built kernel
In-Reply-To: <20190725200625.174838-3-ndesaulniers@google.com>
Message-ID: <alpine.DEB.2.21.1907260038580.1791@nanos.tec.linutronix.de>
References: <20190725200625.174838-1-ndesaulniers@google.com> <20190725200625.174838-3-ndesaulniers@google.com>
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

On Thu, 25 Jul 2019, Nick Desaulniers wrote:

I'm really impressed how you manage to make the cover letter (0/N) a reply
to 1/N instead of 1..N/N being a reply to 0/N.

  In-Reply-To: <20190725200625.174838-1-ndesaulniers@google.com>
  Message-Id: <20190725200625.174838-3-ndesaulniers@google.com>

Is that a new git feature to be $corp top-posting compliant?

> 1. Reuse the implementation of memcpy and memset instead of relying on
> __builtin_memcpy and __builtin_memset as it causes infinite recursion
> in Clang (at any opt level) or GCC at -O2.
> 2. Don't reset KBUILD_CFLAGS, rather filter CONFIG_FUNCTION_TRACER,
> CONFIG_STACKPROTECTOR, and CONFIG_STACKPROTECTOR_STRONG flags via
> `CFLAGS_REMOVE_<file>.o'
> 
> A good test of this series (besides boot testing a kexec kernel):
> * There should be no undefined symbols in arch/x86/purgatory/purgatory.ro:
> $ nm arch/x86/purgatory/purgatory.ro
>   particularly `warn`, `bcmp`, `__stack_chk_fail`, `memcpy` or `memset`.
> * `-pg`, `-fstack-protector`, `-fstack-protector-strong` should not be
>   added to the command line for the c source files under arch/x86/purgatory/
>   when compiling with CONFIG_FUNCTION_TRACER=y, CONFIG_STACKPROTECTOR=y,
>   and CONFIG_STACKPROTECTOR_STRONG=y.
> 
> V4 of: https://lkml.org/lkml/2019/7/23/864

Please don't use lkml.org references. I know it's popular but equally
unreliable at times.

The long term reliable reference is message id based, i.e.:

 lkml.kernel.org/r/$MSGID

or

 lore.kernel.org/lkml/$MSGID

even if the base URLs would cease to exist, the message id will give you a
trivial way to find the relevant thread, but if '2019/7/23/864' stops to
work, good luck in finding the original post. I wasted hours on that just
because a subject line changed enough to confuse the big internet stalking
machines.

Thanks,

	tglx
