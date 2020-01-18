Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D681141743
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 12:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgARLhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 06:37:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46634 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgARLhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 06:37:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id z124so12988432pgb.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 03:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dJFpZmbL29Nhk/m0uumLjQe295W+Tqyiu0Y2F3ZrsGE=;
        b=GDWdJquZYzJ4XJLd81poGT62R1JdfDpVM7N50F5H28SfDpaLO+gfT9wj/O7F6qEFgo
         EL4ppOvEn3mVFrxS+C7ZtsO83I+xhOfm76eVVGANa9vzVZ5ySQPQJY6qKQ9GeaaMn4Uk
         sLoTkDGy3wQtjEWRAe6auUi/9286Zb5SBilcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dJFpZmbL29Nhk/m0uumLjQe295W+Tqyiu0Y2F3ZrsGE=;
        b=riSIWMaQMtfMd3hIxk1iJ1/e/m7TJQPA8WoIUuNpu3w0I1gETMtcO5Bw+xQCCONsIy
         eLzdVBRySmOeDa2kASrKurmmEfPEeUFT+S8KWF9TIx0fUrpoKljv4+nOy5Ry3yWYYrc6
         DG7h9CVvZNRyHqYezpwc+idTdvbDZ0zPH0uTHnv/CFWE1Ir/8f1gGEHLGnLkzbBzuoGU
         Ssnzxy0ymsFG0+6sU8ubMZeE4avFuSjv9lb2dnlUEgqlQkrdS/uhp3oURc2hwvqvmSUo
         Ple6DLM4qm+CIWi91diGg9TFVzxeF6G1KF8lgRuB0bK7RNJP58Mfvfnqg5X/A+sCRe50
         1q6g==
X-Gm-Message-State: APjAAAU1zdpoo3p9/pxhRC3OZ8DaiQL8d2DctKDR2cl+VdBSIPbdRd1c
        hppUQM57BlOouXjUfvw5WAqgDg==
X-Google-Smtp-Source: APXvYqzyAgaGpOPjRh7J3jDSXt9buI4zmXy/wdMRydYeKUGftRpELJHQlYHek1AST36dVgajTSV1sA==
X-Received: by 2002:a63:234f:: with SMTP id u15mr49598701pgm.88.1579347433758;
        Sat, 18 Jan 2020 03:37:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a17sm5902264pjv.6.2020.01.18.03.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 03:37:12 -0800 (PST)
Date:   Sat, 18 Jan 2020 03:37:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, stable@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>, avagin@gmail.com,
        Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH v4] ptrace: reintroduce usage of subjective credentials
 in ptrace_has_cap()
Message-ID: <202001180336.F000E9337@keescook>
References: <20200118011908.23582-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118011908.23582-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 02:19:08AM +0100, Christian Brauner wrote:
> Commit 69f594a38967 ("ptrace: do not audit capability check when outputing /proc/pid/stat")
> introduced the ability to opt out of audit messages for accesses to various
> proc files since they are not violations of policy.  While doing so it
> somehow switched the check from ns_capable() to
> has_ns_capability{_noaudit}(). That means it switched from checking the
> subjective credentials of the task to using the objective credentials. This
> is wrong since. ptrace_has_cap() is currently only used in
> ptrace_may_access() And is used to check whether the calling task (subject)
> has the CAP_SYS_PTRACE capability in the provided user namespace to operate
> on the target task (object). According to the cred.h comments this would
> mean the subjective credentials of the calling task need to be used.
> This switches ptrace_has_cap() to use security_capable(). Because we only
> call ptrace_has_cap() in ptrace_may_access() and in there we already have a
> stable reference to the calling task's creds under rcu_read_lock() there's
> no need to go through another series of dereferences and rcu locking done
> in ns_capable{_noaudit}().
> 
> As one example where this might be particularly problematic, Jann pointed
> out that in combination with the upcoming IORING_OP_OPENAT feature, this
> bug might allow unprivileged users to bypass the capability checks while
> asynchronously opening files like /proc/*/mem, because the capability
> checks for this would be performed against kernel credentials.
> 
> To illustrate on the former point about this being exploitable: When
> io_uring creates a new context it records the subjective credentials of the
> caller. Later on, when it starts to do work it creates a kernel thread and
> registers a callback. The callback runs with kernel creds for
> ktask->real_cred and ktask->cred. To prevent this from becoming a
> full-blown 0-day io_uring will call override_cred() and override
> ktask->cred with the subjective credentials of the creator of the io_uring
> instance. With ptrace_has_cap() currently looking at ktask->real_cred this
> override will be ineffective and the caller will be able to open arbitray
> proc files as mentioned above.
> Luckily, this is currently not exploitable but will turn into a 0-day once
> IORING_OP_OPENAT{2} land in v5.6. Fix it now!
> 
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Eric Paris <eparis@redhat.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Kees Cook <keescook@chromium.org>

Looks good! Just to close the loop, yes, my Reviewed-by can stand. :)

-Kees

> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Fixes: 69f594a38967 ("ptrace: do not audit capability check when outputing /proc/pid/stat")
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v1 */
> Link: https://lore.kernel.org/r/20200115171736.16994-1-christian.brauner@ubuntu.com
> 
> /* v2 */
> Link: https://lore.kernel.org/r/20200116224518.30598-1-christian.brauner@ubuntu.com
> - Christian Brauner <christian.brauner@ubuntu.com>:
>   - fix incorrect CAP_OPT_NOAUDIT, CAPT_OPT_NONE order
> 
> /* v3 */
> Link: https://lore.kernel.org/r/20200117105717.29803-1-christian.brauner@ubuntu.com
> - Kees Cook <keescook@chromium.org>:
>   - remove misleading reference to cread guard mutex from commit message
>   - replace if-branches with ternary ?: operator
> 
> /* v4 */
> - Kees Cook <keescook@chromium.org>:
>   - use security_capable() == 0 on return
> - Christian Brauner <christian.brauner@ubuntu.com>:
>   - replace ?: operator with if-branches since we need to check against 0.
>     This makes it more legible.
> ---
>  kernel/ptrace.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index cb9ddcc08119..43d6179508d6 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -264,12 +264,17 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>  	return ret;
>  }
>  
> -static int ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
> +static bool ptrace_has_cap(const struct cred *cred, struct user_namespace *ns,
> +			   unsigned int mode)
>  {
> +	int ret;
> +
>  	if (mode & PTRACE_MODE_NOAUDIT)
> -		return has_ns_capability_noaudit(current, ns, CAP_SYS_PTRACE);
> +		ret = security_capable(cred, ns, CAP_SYS_PTRACE, CAP_OPT_NOAUDIT);
>  	else
> -		return has_ns_capability(current, ns, CAP_SYS_PTRACE);
> +		ret = security_capable(cred, ns, CAP_SYS_PTRACE, CAP_OPT_NONE);
> +
> +	return ret == 0;
>  }
>  
>  /* Returns 0 on success, -errno on denial. */
> @@ -321,7 +326,7 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
>  	    gid_eq(caller_gid, tcred->sgid) &&
>  	    gid_eq(caller_gid, tcred->gid))
>  		goto ok;
> -	if (ptrace_has_cap(tcred->user_ns, mode))
> +	if (ptrace_has_cap(cred, tcred->user_ns, mode))
>  		goto ok;
>  	rcu_read_unlock();
>  	return -EPERM;
> @@ -340,7 +345,7 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
>  	mm = task->mm;
>  	if (mm &&
>  	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
> -	     !ptrace_has_cap(mm->user_ns, mode)))
> +	     !ptrace_has_cap(cred, mm->user_ns, mode)))
>  	    return -EPERM;
>  
>  	return security_ptrace_access_check(task, mode);
> 
> base-commit: b3a987b0264d3ddbb24293ebff10eddfc472f653
> -- 
> 2.25.0
> 

-- 
Kees Cook
