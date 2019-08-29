Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D3BA27D9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 22:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfH2UV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 16:21:29 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:50950 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfH2UV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:21:28 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 233B95C1F7F;
        Thu, 29 Aug 2019 22:21:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1567110085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fg2GaVUio75ldsR6EagWHhcxkRR/eMtIgg94UgACpuA=;
        b=HtB7SUmGK/K5TFjhNhc+4bTcQoRjeLOroIk030NC86YCFXQ+4vB4qO4OrPZwIpszip7xEx
        xumoIuQ4y9uB7RjeyOzU+rjc9EQWwJSy7myjs5QK6ZewmBa5CZHZT/GTpmlAiT1DT29zK7
        HMINqyQgaRR1pOJr4p5WFGfDwegd8x8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Aug 2019 22:21:25 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ARM: Emit __gnu_mcount_nc when using Clang 10.0.0 or
 newer
In-Reply-To: <20190829193432.GA10138@archlinux-threadripper>
References: <20190829062635.45609-1-natechancellor@gmail.com>
 <CAKwvOdkXSWE+_JCZsuQdkCSrK5pJSp9n_Cd27asFP0mHBfHg6w@mail.gmail.com>
 <20190829193432.GA10138@archlinux-threadripper>
Message-ID: <885bb20c11f0cb004e5eeda7b0ca6d16@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-29 21:34, Nathan Chancellor wrote:
> On Thu, Aug 29, 2019 at 10:55:28AM -0700, Nick Desaulniers wrote:
>> On Wed, Aug 28, 2019 at 11:27 PM Nathan Chancellor
>> <natechancellor@gmail.com> wrote:
>> >
>> > Currently, multi_v7_defconfig + CONFIG_FUNCTION_TRACER fails to build
>> > with clang:
>> >
>> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `_local_bh_enable':
>> > softirq.c:(.text+0x504): undefined reference to `mcount'
>> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `__local_bh_enable_ip':
>> > softirq.c:(.text+0x58c): undefined reference to `mcount'
>> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `do_softirq':
>> > softirq.c:(.text+0x6c8): undefined reference to `mcount'
>> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_enter':
>> > softirq.c:(.text+0x75c): undefined reference to `mcount'
>> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_exit':
>> > softirq.c:(.text+0x840): undefined reference to `mcount'
>> > arm-linux-gnueabi-ld: kernel/softirq.o:softirq.c:(.text+0xa50): more undefined references to `mcount' follow
>> >
>> > clang can emit a working mcount symbol, __gnu_mcount_nc, when
>> > '-meabi gnu' is passed to it. Until r369147 in LLVM, this was
>> > broken and caused the kernel not to boot because the calling
>> > convention was not correct. Now that it is fixed, add this to
>> > the command line when clang is 10.0.0 or newer so everything
>> > works properly.
>> >
>> > Link: https://github.com/ClangBuiltLinux/linux/issues/35
>> > Link: https://bugs.llvm.org/show_bug.cgi?id=33845
>> > Link: https://github.com/llvm/llvm-project/commit/16fa8b09702378bacfa3d07081afe6b353b99e60
>> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> > ---
>> >  arch/arm/Makefile | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> > index c3624ca6c0bc..7b5a26a866fc 100644
>> > --- a/arch/arm/Makefile
>> > +++ b/arch/arm/Makefile
>> > @@ -112,6 +112,12 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
>> >  CFLAGS_ABI     +=-funwind-tables
>> >  endif
>> >
>> > +ifeq ($(CONFIG_CC_IS_CLANG),y)
>> > +ifeq ($(shell test $(CONFIG_CLANG_VERSION) -ge 100000; echo $$?),0)
>> > +CFLAGS_ABI     +=-meabi gnu
>> > +endif
>> > +endif
>> > +
>>
>> Thanks for the patch!  I think this is one of the final issues w/ 32b
>> ARM configs when building w/ Clang.
>>
>> I'm not super enthused about the version check.  The flag is indeed
>> not recognized by GCC, but I think it would actually be more concise
>> with $(cc-option) and no compiler or version check.
>>
>> Further, I think that the working __gnu_mcount_nc in Clang would
>> better be represented as marking the arch/arm/KConfig option for
>> CONFIG_FUNCTION_TRACER for dependent on a version of Clang greater
>> than or equal to Clang 10, not conditionally adding this flag. (We
>> should always add the flag when supported, IMO.  __gnu_mcount_nc's
>> calling convention being broken is orthogonal to the choice of
>> __gnu_mcount_nc vs mcount, and it's the former's that should be
>> checked, not the latter as in this patch.
> 
> I will test with or without CONFIG_AEABI like Matthias asked and I will
> implement your Kconfig suggestion if it passes all of my tests. The
> reason that I did it this way is because I didn't want a user to end up
> with a non-booting kernel since -meabi gnu works with older versions of
> clang at build time, the issue happens at boot time but the Kconfig
> suggestion + cc-option should fix that.

I agree with Nathan here, I'd rather prefer the build system to fail
building rather than runtime error.

If we decide we want to have it building despite it not building a
functional kernel, we should at least add a #warning...

--
Stefan

> 
> I should have a v2 out this evening.
> 
> Cheers,
> Nathan
