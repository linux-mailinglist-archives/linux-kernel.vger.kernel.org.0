Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E2E132D1F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 18:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgAGRet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 12:34:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgAGRet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:34:49 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22ED6208C4;
        Tue,  7 Jan 2020 17:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578418488;
        bh=mYOnDccLJOpjVPcS+X/VPzoBs3Qeivek+7YeFnBVqz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QAPDps5pzi7g1eWJYBnFAZEV92ChvLING+8qKDeAsM9pQfj2b4uN51+L+hLamPNdu
         NrfaW2BB9rjFYdBSfNgudGwq5LRmL7KAQZk/FHVvV644/uxWAMk3OkI1FkxUvZuCyL
         B8Vw0b1PVRHNtBJi1XSi+LxNqIjODrNIQnOIo2q8=
Date:   Tue, 7 Jan 2020 17:34:43 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v2] locking/qspinlock: Fix inaccessible URL of MCS lock
 paper
Message-ID: <20200107173443.GB32009@willie-the-truck>
References: <20200107151619.20802-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107151619.20802-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:16:19AM -0500, Waiman Long wrote:
> It turns out that the URL of the MCS lock paper listed in the source
> code is no longer accessible. I did got question about where the paper
> was. This patch updates the URL to BZ 206115 which contains a copy of
> the paper from
> 
>   https://www.cs.rochester.edu/u/scott/papers/1991_TOCS_synch.pdf
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/qspinlock.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 2473f10c6956..ce75b2270b58 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -31,10 +31,9 @@
>  /*
>   * The basic principle of a queue-based spinlock can best be understood
>   * by studying a classic queue-based spinlock implementation called the
> - * MCS lock. The paper below provides a good description for this kind
> - * of lock.
> + * MCS lock. A copy of the original MCS lock papaer is available at

s/papaer/paper/

I think I reviewed the previous patch as you sent this version, but please
could you reword as suggested here [1]?

Cheers,

Will

[1] https://lore.kernel.org/lkml/20200107172343.GA32009@willie-the-truck/T/#m0f9eaf53e509b87d0f6378e35514c9b120d8edc2
