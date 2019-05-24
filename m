Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5A9029120
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 08:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388934AbfEXGlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 02:41:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55242 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388735AbfEXGlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:41:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so8078828wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 23:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qf3X+hbIZgwfzHXy1m/OMvmqj8NQkz8T8T5hmzXyNRY=;
        b=EsJHEOgIz5F0c9k2zqMsvxfglHKI6q1Bj8XT+LxmDagDurt0dvkYBBM79a6YD5Oxau
         yvtMaRLym743m8GZH3NN7LhijXncuLKXdmI9LM+XmKtzr09I1TaYKFwgjzBhDJOq1JPW
         0NwbM96tQLgazOU+oDXfcN+MhFV89HTtQrM8tDkhjXlsfRiqT61AB1BF5GvpUJ6ldrtC
         Ue6erU7E8dy5g86jzPlwMSbvE2u7jhBpmci9FURUdL/WlmrIOJxtIVhLbeXMPYYAlBo4
         1xbAH3aGaLKUlQntRalvB51g2CkYeCFD/A4WHVgG2bDw1UpzmQvkwXd6NBm0Vfy9qb18
         593A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qf3X+hbIZgwfzHXy1m/OMvmqj8NQkz8T8T5hmzXyNRY=;
        b=U7QMyRWoEBrkA1hRItn56cVx6QIW9+i6vJrrFu0WziYPnTb2IM2MvAv2q1sNw4vSvd
         L2gxfh1Gn1L1niWv11aTMERAdkZQKushyEr5u3ThkRnIZX65FP78y9tlZ4aUeg/0b3DS
         iyHSz9QVMpwCV9O3y1tO7IWAQH+XHet3JXGlN9xpWwNX0qScbxbxKAzvuXU/SakP45n+
         2RWWEnj32NL7ANZE7Jnh2eFC0HXI50N75BiAzuSgK/fYgSDFZTzoIWZaHEKwdwvxSE7j
         Q7UurR5Oww/fM9zTQ7YV30Xv9Jo4HnWdxwdzbgyxdduZo11BH9+KYK+wcA8fwtKc3eLs
         wZyA==
X-Gm-Message-State: APjAAAUx4ohKcaR0hOPwIJ8zh8hqWrM8XypUmJU9qXpwOD7SvGZm03J/
        qjtb278VdTJv9WY3nWjRiDc=
X-Google-Smtp-Source: APXvYqx86cSR0trsn9pND3YgX292yJypc2fu0c693IlXzOqRFGjGI8G7/1xAvKrP6wZd7aDEmsU82w==
X-Received: by 2002:a1c:a002:: with SMTP id j2mr14456456wme.131.1558680090055;
        Thu, 23 May 2019 23:41:30 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s62sm3159826wmf.24.2019.05.23.23.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 23:41:29 -0700 (PDT)
Date:   Fri, 24 May 2019 08:41:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, tglx@linutronix.de
Subject: Re: [PATCH] locking/lockdep: Don't complain about wrong name for no
 validate class
Message-ID: <20190524064127.GA71071@gmail.com>
References: <20190517212234.32611-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517212234.32611-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> It is possible to ignore the validation for a certain log be using
> 	lockdep_set_novalidate_class()

s/log/lock
s/be/by

?

> on it. Each invocation will assign a new name to the class it created
> for created __lockdep_no_validate__. That means that once
> lockdep_set_novalidate_class() has been used on two locks then
> class->name won't match lock->name for the first lock triggering the
> warning.
> 
> Ignoring changed non-matching ->name pointer for the
> __lockdep_no_validate__ class.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/locking/lockdep.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index d06190fa50822..38be69d344f7f 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -731,7 +731,8 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
>  			 * Huh! same key, different name? Did someone trample
>  			 * on some memory? We're most confused.
>  			 */
> -			WARN_ON_ONCE(class->name != lock->name);
> +			WARN_ON_ONCE(class->name != lock->name &&
> +				     lock->key != &__lockdep_no_validate__);

Looks good otherwise - applied.

Thanks,

	Ingo
