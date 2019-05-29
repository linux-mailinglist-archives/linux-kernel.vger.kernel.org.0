Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97D52E4D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 20:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfE2Szr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 14:55:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41225 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2Szq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:55:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id s24so1307876plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=znPmL9ULodOyU0PyZn6MpAN5tuQwaKzazg+9AyEInzs=;
        b=TgS75tg2RnACM5k+Dq/XHwu8cvK3iWBMwBpBhZ00zh8zt/P/CCim/B+nbQOSe+Fs38
         Ycsh/5dKTPJCIpt98v1Eqc/E8kiGtJtKntCyiRzkPBARg58okkUfYrRaeulpxpnmd0Uh
         t/rr+WCi4oPXm0b3Hi5Uqx1er3NIT+fijO8EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=znPmL9ULodOyU0PyZn6MpAN5tuQwaKzazg+9AyEInzs=;
        b=YBDwpEMRIkZ8nWBiyhKiHgySFTJPz/wqy3YZQj8Pjhmp42uoQuTZUv2+NUvQbdMUfg
         slhqLYNB+0fWy4zAqyhu8/+qOkjDvCUImQnMB2BV80qYzSvxu//zqfIE/Cc+JJHVyrqF
         mqP+c4yL9hgqyTvEbUODLxJW9fEMHv9o85j1YZQwdTBboqBpDca1lnoYJAJXw8WF4TRI
         URqY2BJT81i1iIWXk9YwqVA5vdj6a0tRLLmZBjdT5S8HEdjuX858Xm2b+71AFFcG8ofb
         6YXJe8zAH2BJFKgkKzz5EB5v8hTHjnKtTn1DJtqV+ZA5hfa7GeFBg4dwaB0tBLO32w6d
         /y7A==
X-Gm-Message-State: APjAAAWMWheu9WS8LWE8SGvdjwUi1PbXU4/MKKR2rUBD7ITLUOdJ9Q58
        ftAw0hOtgYd44PAZcCfZTZjrmQ==
X-Google-Smtp-Source: APXvYqyDdxQEyJ2gIdwcKwRhS4KNGWtrcejgOOhoLQHLrBamWDu2+n6EfyIbhUJ4zSrtu5JKVvd1EQ==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37mr34741076plb.150.1559156146261;
        Wed, 29 May 2019 11:55:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u2sm304783pjv.30.2019.05.29.11.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 11:55:45 -0700 (PDT)
Date:   Wed, 29 May 2019 11:55:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
Message-ID: <201905291154.E4A0CB717@keescook>
References: <20190529113157.227380-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529113157.227380-1-jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 01:31:57PM +0200, Jann Horn wrote:
> Restore the read memory barrier in __ptrace_may_access() that was deleted
> a couple years ago. Also add comments on this barrier and the one it pairs
> with to explain why they're there (as far as I understand).
> 
> Fixes: bfedb589252c ("mm: Add a user_ns owner to mm_struct and fix ptrace permission checks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Ah, thanks! Nice find.

Acked-by: Kees Cook <keescook@chromium.org>

(And, yeah, Eric, I say snag it if you've got stuff queued up...)

-Kees

> ---
> (I have no clue whatsoever what the relevant tree for this is, but I
> guess Oleg is the relevant maintainer?)
> 
>  kernel/cred.c   |  9 +++++++++
>  kernel/ptrace.c | 10 ++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 45d77284aed0..07e069d00696 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -450,6 +450,15 @@ int commit_creds(struct cred *new)
>  		if (task->mm)
>  			set_dumpable(task->mm, suid_dumpable);
>  		task->pdeath_signal = 0;
> +		/*
> +		 * If a task drops privileges and becomes nondumpable,
> +		 * the dumpability change must become visible before
> +		 * the credential change; otherwise, a __ptrace_may_access()
> +		 * racing with this change may be able to attach to a task it
> +		 * shouldn't be able to attach to (as if the task had dropped
> +		 * privileges without becoming nondumpable).
> +		 * Pairs with a read barrier in __ptrace_may_access().
> +		 */
>  		smp_wmb();
>  	}
>  
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 5710d07e67cf..e54452c2954b 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -324,6 +324,16 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
>  	return -EPERM;
>  ok:
>  	rcu_read_unlock();
> +	/*
> +	 * If a task drops privileges and becomes nondumpable (through a syscall
> +	 * like setresuid()) while we are trying to access it, we must ensure
> +	 * that the dumpability is read after the credentials; otherwise,
> +	 * we may be able to attach to a task that we shouldn't be able to
> +	 * attach to (as if the task had dropped privileges without becoming
> +	 * nondumpable).
> +	 * Pairs with a write barrier in commit_creds().
> +	 */
> +	smp_rmb();
>  	mm = task->mm;
>  	if (mm &&
>  	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
> -- 
> 2.22.0.rc1.257.g3120a18244-goog
> 

-- 
Kees Cook
