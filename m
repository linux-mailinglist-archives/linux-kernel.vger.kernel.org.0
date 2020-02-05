Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACAF1535F3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 18:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgBERJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 12:09:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46517 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBERJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:09:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id k29so1505231pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 09:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pbXnDbHJtM+LDjIhpTVDNZGKnCDN+h/h3x64indO5es=;
        b=X3pW73dHatde6yRFIcSKUyx2bYQUA/wYR8V8AcOrSXqzGFyRRf0SLwQyBj0qJKox/0
         PqkjC/C44V6X9MGwgfAgl1u8yPr91HOfNlqzBFe3rH1goNjrBbXoc1KsLry4rSDYpDZh
         FkMvYGav+CR1Q6L0UmCe1zd3utyDn0bYqlgIQ4E+NqaFgb8w8CKusDhB7tDSvgYoBvTD
         3Z/o3V0KG29fxcVID6cN4FgYtXa8FaKZ5XmQO3sPSJwTb0Zt3QqNqW4/ql6VXJbyPyCY
         2NNuhrAGWz9tXxxEKxiMvqKmNVY6z8Puqu94nWOC7MLvVUaWNOIDlOFcxL3+PLi/Y0z3
         4WPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pbXnDbHJtM+LDjIhpTVDNZGKnCDN+h/h3x64indO5es=;
        b=BqFKlNxUTElaPiCQ8qEgcMHQ10YWAR6NQ4r+OT4hLAeWCrF+clCCgcsLa6qKDrxsNG
         lzmWDzZ/GT4nJqzJF8Wydio8SLXezxhylH+uyxxAWQyloz/4wWW0lGRgfcYAc5G1sPkt
         SDfj4ClihoAl4//7Uc0PQf1zBhfuAM0tZW+eW5tnDL71nSpfW/kKAtn7RXSN75IltTT4
         rOXUytrWPerStF7O3xnTkhIPUME17dzQc5uijKZS8jsjWupOVpW5ISyIEWWAAXDHX+I+
         jHCodMLMVLtlc3pdELVkng8fC2kzQaAPTujjXtQJD8zMKqNZ8QW95B7uwN3s+y21U5/r
         ryAQ==
X-Gm-Message-State: APjAAAUZtTK24ZriL4/zuq6n31iHBpYa1NeUoADilRAHy4K3+bj9otq4
        K/YKRtchMYWO1oeapv5Aeg==
X-Google-Smtp-Source: APXvYqxOqV6N2/grbqu/ZXbSC4tCY5XK5SSj2ztilWg/Fm1cjkDSevEXQM12uQOXu/yVeT9paZ3sNg==
X-Received: by 2002:a63:de54:: with SMTP id y20mr36176194pgi.79.1580922579252;
        Wed, 05 Feb 2020 09:09:39 -0800 (PST)
Received: from madhuparna-HP-Notebook ([2402:3a80:542:9945:9d58:40ca:c55a:7c02])
        by smtp.gmail.com with ESMTPSA id fh24sm335673pjb.24.2020.02.05.09.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 09:09:38 -0800 (PST)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Wed, 5 Feb 2020 22:39:21 +0530
To:     Amol Grover <frextrite@gmail.com>
Cc:     madhuparnabhowmik10@gmail.com, ebiederm@xmission.com,
        oleg@redhat.com, christian.brauner@ubuntu.com, guro@fb.com,
        tj@kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
        joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] signal.c: Fix sparse warnings
Message-ID: <20200205170921.GA2755@madhuparna-HP-Notebook>
References: <20200205162319.28263-1-madhuparnabhowmik10@gmail.com>
 <20200205165138.GB22537@workstation-portable>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205165138.GB22537@workstation-portable>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:21:38PM +0530, Amol Grover wrote:
> On Wed, Feb 05, 2020 at 09:53:19PM +0530, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > This patch fixes the following two sparse warnings caused due to
> > accessing RCU protected pointer tsk->parent without rcu primitives.
> > 
> > kernel/signal.c:1948:65: warning: incorrect type in argument 1 (different address spaces)
> > kernel/signal.c:1948:65:    expected struct task_struct *tsk
> > kernel/signal.c:1948:65:    got struct task_struct [noderef] <asn:4> *parent
> > kernel/signal.c:1949:40: warning: incorrect type in argument 1 (different address spaces)
> > kernel/signal.c:1949:40:    expected void const volatile *p
> > kernel/signal.c:1949:40:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
> > kernel/signal.c:1949:40: warning: incorrect type in argument 1 (different address spaces)
> > kernel/signal.c:1949:40:    expected void const volatile *p
> > kernel/signal.c:1949:40:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
> > 
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > ---
> >  kernel/signal.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 9ad8dea93dbb..3d59e5652d94 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1945,8 +1945,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
> >  	 * correct to rely on this
> >  	 */
> >  	rcu_read_lock();
> > -	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(tsk->parent));
> > -	info.si_uid = from_kuid_munged(task_cred_xxx(tsk->parent, user_ns),
> > +	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(rcu_access_pointer(tsk->parent)));
> > +	info.si_uid = from_kuid_munged(task_cred_xxx(rcu_access_pointer(tsk->parent), user_ns),
> 
> Shouldn't rcu_dereference() OR rcu_dereference_check() be better suited
> here? Since, rcu_access_pointer() omits all lockdep checks.
>
I used rcu_access_pointer() because I thought the pointer is not
dereferenced. But it is dereferenced in task_pid() and task_cred_xxx().

Thank you for pointing out, I will send the updated patch.

Thanks,
Madhuparna

> Thanks
> Amol
> 
> >  				       task_uid(tsk));
> >  	rcu_read_unlock();
> >  
> > -- 
> > 2.17.1
> > 
