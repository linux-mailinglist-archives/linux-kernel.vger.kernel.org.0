Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD4F2AEB24
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 15:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfIJNJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 09:09:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38389 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfIJNJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 09:09:39 -0400
Received: from [148.69.85.38] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i7ftp-0003kI-Du; Tue, 10 Sep 2019 13:09:37 +0000
Date:   Tue, 10 Sep 2019 15:09:36 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] fork: fail on non-zero higher 32 bits of args.exit_signal
Message-ID: <20190910130935.jxqxbt7wop3ostob@wittgenstein>
References: <20190910115711.GA3755@asgard.redhat.com>
 <20190910124440.GA25647@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190910124440.GA25647@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 02:44:41PM +0200, Oleg Nesterov wrote:
> On 09/10, Eugene Syromiatnikov wrote:
> >
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2562,6 +2562,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> >  	if (copy_from_user(&args, uargs, size))
> >  		return -EFAULT;
> >  
> > +	if (unlikely(((unsigned int)args.exit_signal) != args.exit_signal))
> > +		return -EINVAL;
> 
> Hmm. Unless I am totally confused you found a serious bug...
> 
> Without CLONE_THREAD/CLONE_PARENT copy_process() blindly does
> 
> 	p->exit_signal = args->exit_signal;
> 
> the valid_signal(sig) check in do_notify_parent() mostly saves us, but we
> must not allow child->exit_signal < 0, if nothing else this breaks
> thread_group_leader().
> 
> And afaics this patch doesn't fix this? I think we need the valid_signal()
> check...

Thanks for sending this patch so quickly after our conversation
yesterday, Eugene!
We definitely want valid_signal() to verify the signal is ok.

Eugene, can you please update the patch to use valid signal and keep it
as a separate patch from the cleanup and selftest patches?

Christian
