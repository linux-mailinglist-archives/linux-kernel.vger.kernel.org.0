Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A53542616D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfEVKKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 06:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbfEVKKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:10:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31A5020863;
        Wed, 22 May 2019 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558519802;
        bh=fjSUsl7+ylbVqp71Ri0/DWUzGL9Kyn1X+h1AuUerIOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bhMoO9b4ACIo+GhJUTw/Xd/LmOG8DLNEmBSqsqwW5R4OrwMLJYbywTvXwm3uN52wh
         VlSij/ZHtt2WmLffZY5pIyN9nxxv1CQYUbk+6u+boMJ8rjOyO28eUZDCHx66YsEHi3
         DUzkQ6zG3a4vK0Zjob7LHVL6PqCUkmvyxeVJKxQQ=
Date:   Wed, 22 May 2019 12:09:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Nicolai Stange <nstange@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        zfs-devel@list.zfsonlinux.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/fpu: allow kernel_fpu_{begin,end} to be used by
 non-GPL modules
Message-ID: <20190522100959.GA15390@kroah.com>
References: <20190522044204.24207-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522044204.24207-1-cyphar@cyphar.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 02:42:04PM +1000, Aleksa Sarai wrote:
> Prior to [1], all non-GPL modules were able to make use of SIMD on x86
> by making use of the __kernel_fpu_* API. Given that __kernel_fpu_* were
> both EXPORT_SYMBOL'd and kernel_fpu_* are such trivial wrappers around
> the now-static __kernel_fpu_*, it seems to me that there is no reason to
> have different licensing rules for them.
> 
> In the case of OpenZFS, the lack of SIMD on newer Linux kernels has
> caused significant performance problems (since ZFS uses SIMD for
> calculation of blkptr checksums as well as raidz calculations).
> 
> [1]: commit 12209993e98c ("x86/fpu: Don't export __kernel_fpu_{begin,end}()")
> 
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  arch/x86/kernel/fpu/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 2e5003fef51a..8de5687a470d 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -127,14 +127,14 @@ void kernel_fpu_begin(void)
>  	preempt_disable();
>  	__kernel_fpu_begin();
>  }
> -EXPORT_SYMBOL_GPL(kernel_fpu_begin);
> +EXPORT_SYMBOL(kernel_fpu_begin);
>  
>  void kernel_fpu_end(void)
>  {
>  	__kernel_fpu_end();
>  	preempt_enable();
>  }
> -EXPORT_SYMBOL_GPL(kernel_fpu_end);
> +EXPORT_SYMBOL(kernel_fpu_end);

No, please, we have gone over this before, we do not care at all about
external kernel modules, ESPECIALLY ones that are not GPL compatible.

greg k-h
