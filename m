Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7F967EF4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 14:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfGNMR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jul 2019 08:17:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39880 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbfGNMR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 08:17:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so14218144wrt.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 05:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cgVbuOUK5IMb2mJob8Vu/i3xaHtmEbyWrqBO0QT7Vjk=;
        b=Mx8nG9+a22gVxyMb7SZmw7vgw+HQJBRI5ZISTOezzTrWlcNuyrgbXc6mOKUReNJRIy
         CSUF1YVm5uOsU55Qi8QxsE6gkoZ/pO+aOhKkMiUwNaRBIdZklMUuDmelSPbH60rwv10W
         PFD3/mT6fwxrDW0vKkkn9evEgTQKetfzSj/T4eGB8LX9iyn5MzjgTiHwSFsbZODjfN6Z
         TCJCAyIz0GyMLwjA9o+OESsGLxf26d04rYxsq8PgxTUDv84HRFEKki06vZv2OlsCRDSR
         fdLX+fJ2hFELH8EPmVDc6yLyiGs2oKwA2tr+O9iRy+Xfa2UNV3wbGCTmXKKnSqlH77yB
         hrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cgVbuOUK5IMb2mJob8Vu/i3xaHtmEbyWrqBO0QT7Vjk=;
        b=sCtC0x3pCwkvwfqLrFlmQjBr4DKeMcRW8aqYJV6Qi0c+1Ox29hSW7dz1oFTmcL0dbV
         iQSQuhJyvNJcSyojdZwZc2O8DRfoY3KHieLf29lhpK/mTm8VB3tHtKBujLn+R4kIOkla
         m07hzrGcU0le7DEHe7vRLFwMSg146tF3MUt9H4pdK4MLLXc1Lke5ybWXlXiVfSRShERZ
         czAzgwQtDecTPCG4Ce4rYcmfxtsTryE63XLsfu+e7mCsQ5E0AtFke1b15DbBVyl6h1Ji
         a9rcOfgqs7ENfW4Uum7gmxsqX63Y5pVK0YKoBU3pkdsO1rkViGE/aqV1nq6c5nrcngdM
         /hkQ==
X-Gm-Message-State: APjAAAUXXOcZ7gTq5qI1JJ2FRml29Sz1CJ/wtXOQ41Wg/gncqNFVp/OY
        m6rVq8C6/1uUySFl8eM444Y=
X-Google-Smtp-Source: APXvYqwfXjWyk5yDIfDYAnmx5Ltu/cOupXAttx/p6URfj3CXD0K9tlc2bbaoJH6IKF7mfpd1y8YY9w==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr23399272wro.112.1563106646996;
        Sun, 14 Jul 2019 05:17:26 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id l8sm25318829wrg.40.2019.07.14.05.17.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 05:17:26 -0700 (PDT)
Date:   Sun, 14 Jul 2019 14:17:25 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Anatoly Pugachev <matorola@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clone: fix CLONE_PIDFD support
Message-ID: <20190714121724.mwg2t3di6goha7yq@brauner.io>
References: <20190714120206.GC6773@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190714120206.GC6773@altlinux.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 03:02:06PM +0300, Dmitry V. Levin wrote:
> The introduction of clone3 syscall accidentally broke CLONE_PIDFD
> support in traditional clone syscall on compat x86 and those
> architectures that use do_fork to implement clone syscall.
> 
> This bug was found by strace test suite.
> 
> Link: https://strace.io/logs/strace/2019-07-12
> Fixes: 7f192e3cd316 ("fork: add clone3")
> Bisected-and-tested-by: Anatoly Pugachev <matorola@gmail.com>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Good catch! Thank you Dmitry.

One change request below.

> ---
>  arch/x86/ia32/sys_ia32.c | 1 +
>  kernel/fork.c            | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
> index 64a6c952091e..98754baf411a 100644
> --- a/arch/x86/ia32/sys_ia32.c
> +++ b/arch/x86/ia32/sys_ia32.c
> @@ -239,6 +239,7 @@ COMPAT_SYSCALL_DEFINE5(x86_clone, unsigned long, clone_flags,
>  {
>  	struct kernel_clone_args args = {
>  		.flags		= (clone_flags & ~CSIGNAL),
> +		.pidfd		= parent_tidptr,
>  		.child_tid	= child_tidptr,
>  		.parent_tid	= parent_tidptr,
>  		.exit_signal	= (clone_flags & CSIGNAL),
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 8f3e2d97d771..2c3cbad807b6 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2417,6 +2417,7 @@ long do_fork(unsigned long clone_flags,
>  {
>  	struct kernel_clone_args args = {
>  		.flags		= (clone_flags & ~CSIGNAL),
> +		.pidfd		= parent_tidptr,
>  		.child_tid	= child_tidptr,
>  		.parent_tid	= parent_tidptr,
>  		.exit_signal	= (clone_flags & CSIGNAL),
> -- 

Both of these legacy clone helpers need to make CLONE_PIDFD and
CLONE_PARENT_SETTID incompatible, i.e. could you please add a helper to
kernel/fork.c:

bool legacy_clone_args_valid(const struct kernel_clone_args *kargs)
{
	/* clone(CLONE_PIDFD) uses parent_tidptr to return a pidfd */
	if ((kargs->flags & CLONE_PIDFD) && (kargs->flags & CLONE_PARENT_SETTID))
		return false;
}

and export it and use it in ia32 too?

Then resend and I'll put it into my tree that already has a few other
fixes about to be sent.

Christian
