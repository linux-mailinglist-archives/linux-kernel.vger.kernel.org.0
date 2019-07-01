Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F725A555
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 21:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfF1TsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 15:48:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43536 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF1TsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:48:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id cl9so3797148plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ChUBsFBboxFApcwFzipwESnSheECBArimENf95+mlCA=;
        b=GyMkM3xXsRMmPGKX8Vnxcr/EmxSkiug4l0EL/232vcgqVdymn1s+EbaJ9pzrNErpIg
         KmLfx6IePQaOTTV1ssVPFg6VgCUh0YDh2X34cbJaqARjQOOkzfmDUEFNiW06oVIJjLno
         ThTVxw4hvNEkBlqG9vbvyVU5qCbRz7EskzHU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ChUBsFBboxFApcwFzipwESnSheECBArimENf95+mlCA=;
        b=cnfqOstu6I7BNxCaQGMCkI2w39n6EFTAFmcfbwi1ac7TCoSgjh8ADxt2zM8i8hlRBm
         gAbiYivCBqXK4UJsAL0lnI1XLK1JDGpibF8U8+Xt7zCwz0UmjdJjda7kmA5QC6DikmSd
         e7lG/oHp4O8ISFFNX0JLTwux/fyzOeVCg9QJUObPEph7HLewPjXvIwWKGoEperX+r51k
         V/dcNkVpfkivWSNxC8RQ/ZTufQYEUESW7cFHoKcUipohU3eiAh5oHRuhhWIGH3SmUvZ9
         pR1KsnOdZeqzs6JNoEWTK+vhmCzzuGrfXh+yw/iSAkB9nBXxWIhxbMiWq6LO3VjRWId/
         Mzkg==
X-Gm-Message-State: APjAAAX0u7vF6u2Kg6uNisWQEywm3HmoxuzoCywoEmf3tkrfMUsGrrvI
        j+fykGdC/+argVVbViI+wZxudQ==
X-Google-Smtp-Source: APXvYqxtv8TvNyn4zJpKrD6/mQH7c5fJYCsEEAuMAFHUWiXMb2hDoGhrYZltpHjmwQWPslPiSMyGpQ==
X-Received: by 2002:a17:902:9896:: with SMTP id s22mr2769927plp.4.1561751289344;
        Fri, 28 Jun 2019 12:48:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m11sm2593670pjv.21.2019.06.28.12.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 12:48:06 -0700 (PDT)
Date:   Fri, 28 Jun 2019 12:48:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        willy@infradead.org, peterz@infradead.org, will.deacon@arm.com,
        paulmck@linux.vnet.ibm.com, elena.reshetova@intel.com,
        kernel-team@android.com, kernel-hardening@lists.openwall.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] Convert struct pid count to refcount_t
Message-ID: <201906281248.7D03C318A1@keescook>
References: <20190628193442.94745-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628193442.94745-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 03:34:42PM -0400, Joel Fernandes (Google) wrote:
> struct pid's count is an atomic_t field used as a refcount. Use
> refcount_t for it which is basically atomic_t but does additional
> checking to prevent use-after-free bugs.
> 
> For memory ordering, the only change is with the following:
>  -	if ((atomic_read(&pid->count) == 1) ||
>  -	     atomic_dec_and_test(&pid->count)) {
>  +	if (refcount_dec_and_test(&pid->count)) {
>  		kmem_cache_free(ns->pid_cachep, pid);
> 
> Here the change is from:
> Fully ordered --> RELEASE + ACQUIRE (as per refcount-vs-atomic.rst)
> This ACQUIRE should take care of making sure the free happens after the
> refcount_dec_and_test().
> 
> The above hunk also removes atomic_read() since it is not needed for the
> code to work and it is unclear how beneficial it is. The removal lets
> refcount_dec_and_test() check for cases where get_pid() happened before
> the object was freed.
> 
> Cc: mathieu.desnoyers@efficios.com
> Cc: willy@infradead.org
> Cc: peterz@infradead.org
> Cc: will.deacon@arm.com
> Cc: paulmck@linux.vnet.ibm.com
> Cc: elena.reshetova@intel.com
> Cc: keescook@chromium.org
> Cc: kernel-team@android.com
> Cc: kernel-hardening@lists.openwall.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> ---
> Only change from v1->v2 is to get rid of the atomic_read().
> 
>  include/linux/pid.h | 5 +++--
>  kernel/pid.c        | 7 +++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 14a9a39da9c7..8cb86d377ff5 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_PID_H
>  
>  #include <linux/rculist.h>
> +#include <linux/refcount.h>
>  
>  enum pid_type
>  {
> @@ -56,7 +57,7 @@ struct upid {
>  
>  struct pid
>  {
> -	atomic_t count;
> +	refcount_t count;
>  	unsigned int level;
>  	/* lists of tasks that use this pid */
>  	struct hlist_head tasks[PIDTYPE_MAX];
> @@ -69,7 +70,7 @@ extern struct pid init_struct_pid;
>  static inline struct pid *get_pid(struct pid *pid)
>  {
>  	if (pid)
> -		atomic_inc(&pid->count);
> +		refcount_inc(&pid->count);
>  	return pid;
>  }
>  
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 20881598bdfa..89c4849fab5d 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -37,7 +37,7 @@
>  #include <linux/init_task.h>
>  #include <linux/syscalls.h>
>  #include <linux/proc_ns.h>
> -#include <linux/proc_fs.h>
> +#include <linux/refcount.h>
>  #include <linux/sched/task.h>
>  #include <linux/idr.h>
>  
> @@ -106,8 +106,7 @@ void put_pid(struct pid *pid)
>  		return;
>  
>  	ns = pid->numbers[pid->level].ns;
> -	if ((atomic_read(&pid->count) == 1) ||
> -	     atomic_dec_and_test(&pid->count)) {
> +	if (refcount_dec_and_test(&pid->count)) {
>  		kmem_cache_free(ns->pid_cachep, pid);
>  		put_pid_ns(ns);
>  	}
> @@ -210,7 +209,7 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>  	}
>  
>  	get_pid_ns(ns);
> -	atomic_set(&pid->count, 1);
> +	refcount_set(&pid->count, 1);
>  	for (type = 0; type < PIDTYPE_MAX; ++type)
>  		INIT_HLIST_HEAD(&pid->tasks[type]);
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog

-- 
Kees Cook
