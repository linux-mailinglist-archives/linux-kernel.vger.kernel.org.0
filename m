Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D17AFE21
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 15:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfIKNwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 09:52:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57122 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbfIKNwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:52:39 -0400
Received: from [148.69.85.38] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i8330-0005t7-JG; Wed, 11 Sep 2019 13:52:38 +0000
Date:   Wed, 11 Sep 2019 15:52:37 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2] fork: check exit_signal passed in clone3() call
Message-ID: <20190911135236.73l6icwxqff7fkw5@wittgenstein>
References: <20190910175852.GA15572@asgard.redhat.com>
 <20190911064852.9f236d4c201b50e14d717c14@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190911064852.9f236d4c201b50e14d717c14@linux-foundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 06:48:52AM -0700, Andrew Morton wrote:
> On Tue, 10 Sep 2019 18:58:52 +0100 Eugene Syromiatnikov <esyr@redhat.com> wrote:
> 
> > Previously, higher 32 bits of exit_signal fields were lost when
> > copied to the kernel args structure (that uses int as a type for the
> > respective field).  Moreover, as Oleg has noted[1], exit_signal is used
> > unchecked, so it has to be checked for sanity before use; for the legacy
> > syscalls, applying CSIGNAL mask guarantees that it is at least non-negative;
> > however, there's no such thing is done in clone3() code path, and that can
> > break at least thread_group_leader.
> > 
> > Checking user-passed exit_signal against ~CSIGNAL mask solves both
> > of these problems.
> > 
> > [1] https://lkml.org/lkml/2019/9/10/467
> > 
> > * kernel/fork.c (copy_clone_args_from_user): Fail with -EINVAL if
> > args.exit_signal has bits set outside CSIGNAL mask.
> > (_do_fork): Note that exit_signal is expected to be checked for the
> > sanity by the caller.
> > 
> > Fixes: 7f192e3cd316 ("fork: add clone3")
> 
> What are the user-visible runtime effects of this bug?
> 
> Relatedly, should this fix be backported into -stable kernels?  If so, why?

No, as I said in my other mail clone3() is not in any released kernel
yet. clone3() is going to be released in v5.3.

Christian
