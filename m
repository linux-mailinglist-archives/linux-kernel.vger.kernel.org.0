Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C87C37EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 16:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389279AbfJAOoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 10:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfJAOoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:44:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620D92133F;
        Tue,  1 Oct 2019 14:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569941038;
        bh=fcxeV8CpM36Bxco2rh7Di1eG6WEXW7AUV+4NnKjeDKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+bLh+tl5qi4eZdqM7p5bUMEk6kXrr1wkXs4OBTZanjXi/QbuvRMRzpH5eo2iBWC5
         pz2nXO2bnZvigrggrKaNUxMq5aRRKuzs/zCBMcvv9/glq3U7H7Rs5/Wz+q8ZashllE
         sz66nyNWNIjpotcJmeqw+6boc4P9p+Hbl+I0jk5Q=
Date:   Tue, 1 Oct 2019 15:43:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        tglx@linutronix.de
Subject: Re: [PATCH v3 1/5] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
Message-ID: <20191001144353.5rn3bkcc6eyfclh7@willie-the-truck>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926214342.34608-1-vincenzo.frascino@arm.com>
 <20190926214342.34608-2-vincenzo.frascino@arm.com>
 <20191001131420.y3fsydlo7pg6ykfs@willie-the-truck>
 <20191001132731.GG41399@arrakis.emea.arm.com>
 <ed7d1465-2d7b-d57c-c1b1-215af1ba7a6f@arm.com>
 <20191001142038.ptwyfbesfrz3kkoz@willie-the-truck>
 <7558914c-fc2d-d05a-ccbe-76ef451670ae@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7558914c-fc2d-d05a-ccbe-76ef451670ae@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 03:37:49PM +0100, Vincenzo Frascino wrote:
> On 10/1/19 3:20 PM, Will Deacon wrote:
> > On Tue, Oct 01, 2019 at 03:20:35PM +0100, Vincenzo Frascino wrote:
> >> On 10/1/19 2:27 PM, Catalin Marinas wrote:
> >>> On Tue, Oct 01, 2019 at 02:14:23PM +0100, Will Deacon wrote:
> >>>> On Thu, Sep 26, 2019 at 10:43:38PM +0100, Vincenzo Frascino wrote:
> >>>>> +config COMPATCC_IS_ARM_GCC
> >>>>> +	def_bool $(success,$(COMPATCC) --version | head -n 1 | grep -q "arm-.*-gcc")
> >>>>
> >>>> I've seen toolchains where the first part of the tuple is "armv7-", so they
> >>>> won't get detected here. However, do we really need to detect this? If
> >>>> somebody passes a duff compiler, then the build will fail in the same way as
> >>>> if they passed it to CROSS_COMPILE=.
> >>>
> >>> Not sure what happens if we pass an aarch64 compiler. Can we end up with
> >>> a 64-bit compat vDSO?
> >>>
> >>
> >> I agree with Catalin here. The problem is not only when you pass and aarch64
> >> toolchain but even an x86 and so on.
> > 
> > I disagree. What happens if you do:
> > 
> > $ make ARCH=arm64 CROSS_COMPILE=x86_64-linux-gnu-
> > 
> > on your x86 box?
> >
> 
> The kernel compilation breaks as follows:
> 
> x86_64-linux-gnu-gcc: error: unrecognized command line option ‘-mlittle-endian’;
> did you mean ‘-fconvert=little-endian’?
> /data1/Projects/LinuxKernel/linux/scripts/Makefile.build:265: recipe for target
> 'scripts/mod/empty.o' failed
> make[2]: *** [scripts/mod/empty.o] Error 1
> /data1/Projects/LinuxKernel/linux/Makefile:1128: recipe for target 'prepare0' failed
> make[1]: *** [prepare0] Error 2
> make[1]: Leaving directory '/data1/Projects/LinuxKernel/linux-out'
> Makefile:179: recipe for target 'sub-make' failed
> make: *** [sub-make] Error 2
> 
> Similar issue in the compat vdso library compilation if I do (without the check):
> 
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> CROSS_COMPILE_COMPAT=x86_64-linux-gnu-
> 
> With this check the compilation completes correctly but the compat vdso does not
> get built (unless my environment is playing me tricks ;) ).

My point was that we don't attempt to sanitise the compiler passed via
CROSS_COMPILE, so I don't think we should do anything special for COMPATCC
either.

Will
