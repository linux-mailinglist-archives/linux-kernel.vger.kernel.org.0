Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66509BD3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 22:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442008AbfIXUk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 16:40:27 -0400
Received: from foss.arm.com ([217.140.110.172]:36806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441998AbfIXUk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:40:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2DDA337;
        Tue, 24 Sep 2019 13:40:25 -0700 (PDT)
Received: from [172.23.27.158] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1BA53F67D;
        Tue, 24 Sep 2019 13:40:20 -0700 (PDT)
Subject: Re: Problems with arm64 compat vdso
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        linux-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, tglx@linutronix.de, will@kernel.org,
        natechancellor@gmail.com
References: <991e5bf9-6e15-1ca1-d593-8abe553ebe7c@arm.com>
 <20190924180634.206177-1-ndesaulniers@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <c164b359-75a0-5244-1e9b-7a4db1f52bd3@arm.com>
Date:   Tue, 24 Sep 2019 21:42:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924180634.206177-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

thanks for reporting this.

On 9/24/19 7:06 PM, Nick Desaulniers wrote:
> Hi Vincenzo,
> We also are having issues building the cross vDSO with Clang:
> https://github.com/ClangBuiltLinux/linux/issues/595
> 

The initial implementation of vdso32 does not have support for Clang. I was
planning to add it with a second patch set but it seems requiring more work.

> It seems that `LINUXINCLUDE` in arch/arm64/kernel/vdso32/Makefile is including
> arm64 headers in the arm part of the vdso32 build, which causes Clang to error
> on the arm64 inline asm constraints being used in arm64.
> 
> I think if the issue Will described is fixed, it will be simpler for us to fix
> the rest to get it to build w/ Clang.
> 
> https://github.com/ClangBuiltLinux/linux/issues/595#issuecomment-509874891
> is the basis of such a patch.
> 

I agree with you this issue needs to be solved once and for all, but I feel that
the solution is not straight forward. Next week I will post a fix to the problem
Will raised and then will start investigating a more long term solution.

> Clang ships with all backends on by default, and uses a `-target <triple>` to
> cross compile; so the idea of passing two cross compiler binaries for a compat
> vDSO build doesn't really apply to Clang.
> 

My idea was to derivate the triple for clang from the compat cross compiler name
removing the final dash.

I have in my Makefile something on the lines:

CLANG_TRIPLE ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%-"=%)
...
COMPATCC := $(CC) --target=$(notdir $CLANG_TRIPLE)


-- 
Regards,
Vincenzo
