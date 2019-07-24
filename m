Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B3973118
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 16:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfGXOGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 10:06:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47971 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfGXOGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:06:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45txwr1qBbz9sML;
        Thu, 25 Jul 2019 00:06:52 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christian Brauner <christian@brauner.io>
Cc:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Wire up clone3 syscall
In-Reply-To: <20190722133701.g3w5g4crogqb7oi5@brauner.io>
References: <20190722132231.10169-1-mpe@ellerman.id.au> <20190722133701.g3w5g4crogqb7oi5@brauner.io>
Date:   Thu, 25 Jul 2019 00:06:50 +1000
Message-ID: <87imrr5xxh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:
> On Mon, Jul 22, 2019 at 11:22:31PM +1000, Michael Ellerman wrote:
>> Wire up the new clone3 syscall added in commit 7f192e3cd316 ("fork:
>> add clone3").
>> 
>> This requires a ppc_clone3 wrapper, in order to save the non-volatile
>> GPRs before calling into the generic syscall code. Otherwise we hit
>> the BUG_ON in CHECK_FULL_REGS in copy_thread().
>> 
>> Lightly tested using Christian's test code on a Power8 LE VM.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Thank you, Michael!
>
> One comment below, otherwise:
>
> Acked-by: Christian Brauner <christian@brauner.io>

Thanks.

...
>> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
>> index f2c3bda2d39f..6886ecb590d5 100644
>> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
>> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
>> @@ -516,3 +516,4 @@
>>  432	common	fsmount				sys_fsmount
>>  433	common	fspick				sys_fspick
>>  434	common	pidfd_open			sys_pidfd_open
>> +435	common	clone3				ppc_clone3
>
> Note that in v5.3-rc1 there's now a comment that 435 is reserved in
> there. So this will likely cause a merge conflict. You might want to
> base your change off of v5.3-rc1 instead to avoid that. :)

Thanks for the heads-up.

My fixes branch is already based off pre-rc1, and in general Linus can
handle a trivial merge conflict like that.

But given I had to send a v2 to fix the 32-bit build (doh!), I'll move
my fixes up past rc1 once Linus has merged what's in there now, and then
do this patch based on top of rc1, so there'll be no conflict.

cheers
