Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23468208A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 15:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfEPNym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 09:54:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57527 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbfEPNym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:54:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4ED73082B22;
        Thu, 16 May 2019 13:54:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id CF85D5D6A9;
        Thu, 16 May 2019 13:54:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 16 May 2019 15:54:40 +0200 (CEST)
Date:   Thu, 16 May 2019 15:54:36 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190516135435.GA22564@redhat.com>
References: <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain>
 <20190507153154.GA5750@redhat.com>
 <20190507163520.GA1131@sultan-box.localdomain>
 <20190509155646.GB24526@redhat.com>
 <20190509183353.GA13018@sultan-box.localdomain>
 <20190510151024.GA21421@redhat.com>
 <20190513164555.GA30128@sultan-box.localdomain>
 <20190515145831.GD18892@redhat.com>
 <20190515172728.GA14047@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515172728.GA14047@sultan-box.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 16 May 2019 13:54:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15, Sultan Alsawaf wrote:
>
> On Wed, May 15, 2019 at 04:58:32PM +0200, Oleg Nesterov wrote:
> > Could you explain in detail what exactly did you do and what do you see in dmesg?
> >
> > Just in case, lockdep complains only once, print_circular_bug() does debug_locks_off()
> > so it it has already reported another false positive __lock_acquire() will simply
> > return after that.
> >
> > Oleg.
>
> This is what I did:
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 774ab79d3ec7..009e7d431a88 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3078,6 +3078,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>         int class_idx;
>         u64 chain_key;
>
> +       BUG_ON(!debug_locks || !prove_locking);
>         if (unlikely(!debug_locks))
>                 return 0;
>
> diff --git a/lib/debug_locks.c b/lib/debug_locks.c
> index 124fdf238b3d..4003a18420fb 100644
> --- a/lib/debug_locks.c
> +++ b/lib/debug_locks.c
> @@ -37,6 +37,7 @@ EXPORT_SYMBOL_GPL(debug_locks_silent);
>   */
>  int debug_locks_off(void)
>  {
> +       return 0;
>         if (debug_locks && __debug_locks_off()) {
>                 if (!debug_locks_silent) {
>                         console_verbose();

OK, this means that debug_locks_off() always returns 0, as if debug_locks was already
cleared.

Thus print_deadlock_bug() will do nothing, it does

	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
		return 0;

iow this means that even if lockdep finds a problem, the problem won't be reported.

> [    1.492128] BUG: key 0000000000000000 not in .data!
> [    1.492141] BUG: key 0000000000000000 not in .data!
> [    1.492152] BUG: key 0000000000000000 not in .data!
> [    1.492228] BUG: key 0000000000000000 not in .data!
> [    1.492238] BUG: key 0000000000000000 not in .data!
> [    1.492248] BUG: key 0000000000000000 not in .data!

I guess this is lockdep_init_map() which does printk("BUG:") itself, but due to your
change above it doesn't do WARN(1) and thus there is no call trace.

Oleg.

