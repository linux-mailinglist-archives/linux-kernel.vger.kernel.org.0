Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B1FA71A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 19:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfICR3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 13:29:10 -0400
Received: from foss.arm.com ([217.140.110.172]:41538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbfICR3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:29:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52AB3360;
        Tue,  3 Sep 2019 10:29:09 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3302E3F59C;
        Tue,  3 Sep 2019 10:29:08 -0700 (PDT)
Subject: Re: [PATCH] sched: make struct task_struct::state 32-bit
To:     Alexey Dobriyan <adobriyan@gmail.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        aarcange@redhat.com
References: <20190902210558.GA23013@avx2>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d8ad0be1-4ed7-df74-d415-2b1c9a44bac7@arm.com>
Date:   Tue, 3 Sep 2019 18:29:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902210558.GA23013@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2019 22:05, Alexey Dobriyan wrote:
> 32-bit accesses are shorter than 64-bit accesses on x86_64.
> Nothing uses 64-bitness of ->state.
> 
> Space savings are ~2KB on F30 kernel config.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  arch/ia64/kernel/perfmon.c   |    4 ++--
>  block/blk-mq.c               |    2 +-
>  drivers/md/dm.c              |    4 ++--
>  fs/userfaultfd.c             |    2 +-
>  include/linux/sched.h        |    6 +++---
>  include/linux/sched/debug.h  |    2 +-
>  include/linux/sched/signal.h |    2 +-
>  kernel/freezer.c             |    2 +-
>  kernel/kthread.c             |    4 ++--
>  kernel/locking/mutex.c       |    6 +++---
>  kernel/locking/semaphore.c   |    2 +-
>  kernel/rcu/rcutorture.c      |    4 ++--
>  kernel/rcu/tree_stall.h      |    6 +++---
>  kernel/sched/core.c          |    8 ++++----
>  lib/syscall.c                |    2 +-
>  15 files changed, 28 insertions(+), 28 deletions(-)
> 

It looks like you missed a few places. There's a long prev_state in
sched/core.c::finish_task_switch() for instance.

I suppose that's where coccinelle oughta help but I'm really not fluent
in that. Is there a way to make it match p.state accesses with p task_struct?
And if so, can we make it change the type of the variable being read from
/ written to?

How did you come up with this changeset, did you pickaxe for some regexp?

[...]
