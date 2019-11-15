Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D87BFE466
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 18:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfKOR4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 12:56:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40404 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfKOR4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:56:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id e3so5164465plt.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 09:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=f1Oh1RF8Ut5xfZg2ksqYtAu0PSRZLhofY5NfDnVJV1E=;
        b=le2OgXjLuxKOzGanxn690BYFbpSWFpbYsCAtepodK3Nppn99TktillXTJ3pTaoaS0b
         p5G0nIrWIC3UyFh6Q+lQmLk8L3n/FO+3mCYs9DPd+e7q3JeUINwprkOOXD7QDvRrDKYp
         DQWke5NnA3d/K+VJXND/cneNY+NW1Diq6zUfTceC0PhqmWZ9RhJqXPk5fFRm2a+vhnkY
         mftZjzzCvwuJoFAAwdNuD6Ppn/JuL5pF34UUe16ySj4tVAhtH0VhH4Cc6QlGVIFuGSbT
         /NcxCkkvR1Gxz7JHOgTe4FVkUPZkmkUi+BaUun16tPmTWsaele0h0izQ4ujuiKd2rX/V
         il6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=f1Oh1RF8Ut5xfZg2ksqYtAu0PSRZLhofY5NfDnVJV1E=;
        b=WYvcDYYv0Fk2sOUJ/+sA8gUpcJpbZcuuKWA5MJymgLdP0lIqBAb/fttkiAZg+uDMdJ
         LWCfoXqRDBv1msZAtSLdBYlAoCLb/ktEmdB+Vu4qAx4jmwedMnpVAvk6tlRY44oviPmR
         fgdl0CIy9WpTIeZlCvIiTGL+kpecFMQ8BUBPNFxGr+eAcXW8B7O/OGOQfR0hzLHwR1O1
         sdvoHnVwr7xBfSOA8ot+RUNGO1vpzSjNdrX+HlUsNb/zbz/KicOLQn9gCo8n+IBHbECZ
         bERMzpOvtq3fhje/2/6nU2eG9xPHXNmBuouxXGMcjN73iChbO8DxIuVurvT0wOExA/ts
         li2Q==
X-Gm-Message-State: APjAAAXuo6wMcGyKmhtqeoy0wqb6AMtowzLTKhY6jfdEIEaNjcdYg4O4
        rIP8i7UAnnMc9QdrSSJYvXV7EA==
X-Google-Smtp-Source: APXvYqyefeVAz2G2+zRKTSTu2O2jadp+GWGI2fXpqPMSN02L0BFi23Fmcs24YcE9GXazUctq3iNwlg==
X-Received: by 2002:a17:902:b416:: with SMTP id x22mr16514918plr.12.1573840558821;
        Fri, 15 Nov 2019 09:55:58 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id y6sm9357412pfm.12.2019.11.15.09.55.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Nov 2019 09:55:58 -0800 (PST)
Date:   Fri, 15 Nov 2019 09:55:46 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: KSM WARN_ON_ONCE(page_mapped(page)) in remove_stable_node()
In-Reply-To: <ecaf193e-25fb-18fb-d7f7-92531ee92439@virtuozzo.com>
Message-ID: <alpine.LSU.2.11.1911150927220.1531@eggly.anvils>
References: <ecaf193e-25fb-18fb-d7f7-92531ee92439@virtuozzo.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019, Andrey Ryabinin wrote:

> When remove_stable_node() races with __mmput() and squeezes in between ksm_exit() and exit_mmap(),
> the WARN_ON_ONCE(page_mapped(page)) in remove_stable_node() could be triggered.

Thanks for doing the work on that.

> 
> Should we just remove the warning? It seems to be safe to do, all callers are able to handle -EBUSY,
> or there is a better way to fix this?

Please just remove the warning and update the comment.

At first I thought it would still be worth leaving the warning in,
to explain rare EBUSY; but after looking (as you did) at exactly how
remove_stable_node() gets to be called, the places that care about its
failure already expect KSM to be quiesced, and tell the admin EBUSY if
not.  This case is not different, just slightly delayed.  So there's
no need to try to be any cleverer about it.

Though now that you have found the case to be a real one, I do think
it would be an improvement for remove_stable_node_chain() not to give
up at the first -EBUSY, but remove as much as it can before finishing.
But perhaps there's a subtlety that prevents that - I'm not familiar
with the stable node chains.

Hugh

> 
> 
> 
> It's easily reproducible with the following script:
> (ksm_test.c attached)
> 
> 	#!/bin/bash
> 
> 	gcc -lnuma -O2 ksm_test.c -o ksm_test
> 	echo 1 > /sys/kernel/mm/ksm/run
> 	./ksm_test &
> 	sleep 1
> 	echo 2 > /sys/kernel/mm/ksm/run
> 
> and the patch bellow which provokes that race.
> 
> ---
>  include/linux/ksm.h      | 4 +++-
>  include/linux/mm_types.h | 1 +
>  kernel/fork.c            | 4 ++++
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index e48b1e453ff5..18384ea472f8 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -33,8 +33,10 @@ static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>  
>  static inline void ksm_exit(struct mm_struct *mm)
>  {
> -	if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
> +	if (test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
>  		__ksm_exit(mm);
> +		mm->ksm_wait = 1;
> +	}
>  }
>  
>  /*
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 270aa8fd2800..3df8290528c2 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -463,6 +463,7 @@ struct mm_struct {
>  
>  		/* Architecture-specific MM context */
>  		mm_context_t context;
> +		unsigned long ksm_wait;
>  
>  		unsigned long flags; /* Must use atomic bitops to access */
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 5fb7e1fa0b05..be6ef4e046f0 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1074,6 +1074,10 @@ static inline void __mmput(struct mm_struct *mm)
>  	uprobe_clear_state(mm);
>  	exit_aio(mm);
>  	ksm_exit(mm);
> +
> +	if (mm->ksm_wait)
> +		schedule_timeout_uninterruptible(10*HZ);
> +
>  	khugepaged_exit(mm); /* must run before exit_mmap */
>  	exit_mmap(mm);
>  	mm_put_huge_zero_page(mm);
> -- 
> 2.23.0
> 
