Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9CD1F95D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 19:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfEORau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 13:30:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49314 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfEORat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y0H7KCJgDLLoNPgDXA06COEEWIlwjcNmqU20oeqEVdM=; b=ICW+Ax1Hnls1D1ma43OjC5/22
        cyieKb+MpGX6+WTDjd7th2EhOYEBpYmB89o960nPHxEcCgSHew+YrPdliQ6e3O+v7BxhtEC+L2rch
        YLhUYeprRZChm3rX/U0tewaacWC10VE02CAB34K3yZuTGcyZn8M+CE8iUqG/BgTraK5ZkgXzd8+Em
        QZvbV5rVLZhpF7SLe8d4LRJV0vSXR+0NcTt3Sg0tujDpe2TQMu18CXfN/aada14hsB6yCEnp2aSBq
        5hXYKTsAqMPeh/EZvUsdbFu/2DbcmgDS8DAWjQJGFvVzbA8MFpDTiJR7kBcSa/XyeR9Dw14e8BHAc
        siF9yhZgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQxjq-0001mI-FF; Wed, 15 May 2019 17:30:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4DB720297D49; Wed, 15 May 2019 19:30:43 +0200 (CEST)
Date:   Wed, 15 May 2019 19:30:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] Add wait_var_event_interruptible()
Message-ID: <20190515173043.GA2589@hirez.programming.kicks-ass.net>
References: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
 <155793758837.31671.13765813674309502991.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155793758837.31671.13765813674309502991.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 05:26:28PM +0100, David Howells wrote:
> Add wait_var_event_interruptible() to allow interruptible waits for events.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
> 
>  include/linux/wait_bit.h |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
> index 2b0072fa5e92..7dec36aecbd9 100644
> --- a/include/linux/wait_bit.h
> +++ b/include/linux/wait_bit.h
> @@ -305,6 +305,19 @@ do {									\
>  	__ret;								\
>  })
>  
> +#define __wait_var_event_interruptible(var, condition)			\
> +	___wait_var_event(var, condition, TASK_INTERRUPTIBLE, 0, 0,	\
> +			  schedule())
> +
> +#define wait_var_event_interruptible(var, condition)			\
> +({									\
> +	int __ret = 0;							\
> +	might_sleep();							\
> +	if (!(condition))						\
> +		__ret = __wait_var_event_interruptible(var, condition);	\
> +	__ret;								\
> +})
> +
>  /**
>   * clear_and_wake_up_bit - clear a bit and wake up anyone waiting on that bit
>   *
> 
