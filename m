Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3392FB9C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 14:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfE3Me7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 08:34:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfE3Me6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:34:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C61D5308A968;
        Thu, 30 May 2019 12:34:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7778319748;
        Thu, 30 May 2019 12:34:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 30 May 2019 14:34:56 +0200 (CEST)
Date:   Thu, 30 May 2019 14:34:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
Message-ID: <20190530123452.GF22536@redhat.com>
References: <20190529113157.227380-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529113157.227380-1-jannh@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 30 May 2019 12:34:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29, Jann Horn wrote:
>
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

Hmm. Now that I tried to actually read this patch I do not understand this wmb().

commit_creds() does rcu_assign_pointer(real_cred) which implies smp_store_release(),
the dumpability change must be visible before ->real_cred is updated without any
additional barriers?

Oleg.

