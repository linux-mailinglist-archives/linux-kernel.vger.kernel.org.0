Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9282D180933
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 21:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCJUbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 16:31:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37241 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgCJUbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:31:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id p14so5198pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 13:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SXv613ohwLZhXYr9jit6ve5UEm0jQz5ZLBUY3A1Qh/4=;
        b=XK1ouSvIn1SrXrpE2jB7fPZ97wuSynEPpj4HhSXMNSXZWl5ShAjfCYXT5irwpY6R5K
         GhTb4r+GBtdXtwQ7AqZpQT4zG1MOZvavI8l7jKs0+HzwzxDheOxB6TKArYWjMCD7s5Ob
         TsIYA2DD/9E+2ADf9dPVRUDESK4sdz6wOBd0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SXv613ohwLZhXYr9jit6ve5UEm0jQz5ZLBUY3A1Qh/4=;
        b=m/gW3E8LIeagIf9YdyHUCOWCCUiiPRE1ZGuayXM7mU083bCck741Vtqx5FPAorarGf
         7Ou5ItfqpyUjODJPZyV52doMHPUkx8+a2zyPRGgjsw/XKW1t3MUQcxYYd65kfTxI+60t
         oc28CBCFX+4fhnjq6m0xyC8iuj0NJRfkJ8LdAY0qbwtMEx/OxfrcE7yG6Ti72rM0OUGl
         gP8PZw92CPkH2aFzia8GoYgJMoR4WCZkpjvmXYwF8dVC0WWEhJmvSVocaDneLbJgI5Eh
         z2zk5qIOgdYoIaxDzhWWELo/mEEnS/qmejS+2nrj1y4KEoN8e72rspMied3DDzpPQ5pO
         gamQ==
X-Gm-Message-State: ANhLgQ0124wIQX6pHlb3vJth7Micmdrfhhn6y+xekI3xpp2SLQFm+W2N
        vdVwTjEJ3onb7WDioGRfdzenwg==
X-Google-Smtp-Source: ADFU+vui/SI7xY/RL6zB2m7oqlqxvwNncXDyzP64Ny/XUIARUXO4zMninrFbDKhmtcjQIv0QBej9OQ==
X-Received: by 2002:a63:fc18:: with SMTP id j24mr21853810pgi.16.1583872279279;
        Tue, 10 Mar 2020 13:31:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d3sm2205705pfq.126.2020.03.10.13.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 13:31:18 -0700 (PDT)
Date:   Tue, 10 Mar 2020 13:31:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yuyang Du <duyuyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] exec: Move cleanup of posix timers on exec out of
 de_thread
Message-ID: <202003101329.08B332F@keescook>
References: <87v9nlii0b.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170609D44967E044FD1BE40E4E40@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87a74xi4kz.fsf@x220.int.ebiederm.org>
 <AM6PR03MB51705AA3009B4986BB6EF92FE4E50@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87r1y8dqqz.fsf@x220.int.ebiederm.org>
 <AM6PR03MB517053AED7DC89F7C0704B7DE4E50@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <AM6PR03MB51703B44170EAB4626C9B2CAE4E20@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87tv32cxmf.fsf_-_@x220.int.ebiederm.org>
 <87v9ne5y4y.fsf_-_@x220.int.ebiederm.org>
 <87eeu25y14.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eeu25y14.fsf_-_@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 04:36:55PM -0500, Eric W. Biederman wrote:
> 
> These functions have very little to do with de_thread move them out
> of de_thread an into flush_old_exec proper so it can be more clearly
> seen what flush_old_exec is doing.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/exec.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index ff74b9a74d34..215d86f77b63 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1189,11 +1189,6 @@ static int de_thread(struct task_struct *tsk)
>  	/* we have changed execution domain */
>  	tsk->exit_signal = SIGCHLD;
>  
> -#ifdef CONFIG_POSIX_TIMERS
> -	exit_itimers(sig);
> -	flush_itimer_signals();
> -#endif
> -
>  	BUG_ON(!thread_group_leader(tsk));
>  	return 0;
>  
> @@ -1277,6 +1272,11 @@ int flush_old_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		goto out;
>  
> +#ifdef CONFIG_POSIX_TIMERS
> +	exit_itimers(me->signal);
> +	flush_itimer_signals();
> +#endif
> +

I twitch at seeing #ifdefs in .c instead of hidden in the .h declarations
of these two functions, but as this is a copy/paste, I'll live. ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  	/*
>  	 * Make the signal table private.
>  	 */
> -- 
> 2.25.0
> 

-- 
Kees Cook
