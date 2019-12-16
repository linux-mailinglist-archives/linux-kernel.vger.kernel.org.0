Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63EF812121B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 18:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfLPRoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 12:44:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58116 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfLPRoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:44:21 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iguPj-0000v6-TD; Mon, 16 Dec 2019 17:44:12 +0000
Date:   Mon, 16 Dec 2019 18:44:11 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     qiwuchen55@gmail.com, peterz@infradead.org, mingo@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        chenqiwu@xiaomi.com
Subject: Re: [PATCH v2] kernel/exit: do panic earlier to get coredump if
 global init task exit
Message-ID: <20191216174410.xiqurqnqyipbuy4e@wittgenstein>
References: <1576466324-6067-1-git-send-email-qiwuchen55@gmail.com>
 <20191216172841.GA10466@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216172841.GA10466@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 06:28:41PM +0100, Oleg Nesterov wrote:
> On 12/16, qiwuchen55@gmail.com wrote:
> >
> > +	 * If all threads of global init have exited, do panic imeddiately
> > +	 * to get the coredump to find any clue for init task in userspace.
> > +	 */
> > +	group_dead = atomic_dec_and_test(&tsk->signal->live);
> > +	if (unlikely(is_global_init(tsk) && group_dead))
> > +		panic("Attempted to kill init! exitcode=0x%08lx\n", code);
>                                                                     ^^^^
> 
> No, we should not throw out the useful info, please use
> 
> 	signal->group_exit_code ?: code
> 
> as the current code does.
> 
> And I am worried atomic_dec_and_test() is called too early...
> 
> Say, acct_process() can report the exit while some sub-thread sleeps

Hm, I'm not following here. I might just be slow. acct_process() doesn't
seem to report exit status and has been called after group_dead before.

Christian
