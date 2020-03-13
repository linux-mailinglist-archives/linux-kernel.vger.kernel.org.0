Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B621846D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 13:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgCMM1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 08:27:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCMM1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xY8EzI7X1E8hN1FOxDAVneZEH2bSUqBcmp3TlzBpd60=; b=Q6caX3YMsIwxNzme3u2/ZGuMq3
        RJLpXujvtnUDTkaSroJgFk2QVA8lUuJWDmTO3s3yxRKcjWsKPaxE+WBb6Yg/FAJGwOV828RgEPMrh
        6Ma85LFcQ0BsMRUhRTIifaq8JkNn30517a64DY2JFdw6EKO7qyI942X27rkNeC6TuYPqNa7fHBI0O
        5j148hQn4meM2VQnlhZR7PocT+H8aIVrc/x0vFKWIfWO4Rzkp+fsqDRDxXUPiUYld+6b1uBNDpGy1
        P5VI24mJknWoatprhr/3xzqamQrWJjvG0h0mpPE+8Ql0SNShnkxQgU6tav0OlI/4V4Kd6VtFE01mQ
        M4bixk/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCjPV-0004Oh-3N; Fri, 13 Mar 2020 12:27:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34A8B3011E0;
        Fri, 13 Mar 2020 13:27:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC6F02BE01201; Fri, 13 Mar 2020 13:27:25 +0100 (CET)
Date:   Fri, 13 Mar 2020 13:27:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf/core: Fix reversed NULL check in
 perf_event_groups_less()
Message-ID: <20200313122725.GZ12561@hirez.programming.kicks-ass.net>
References: <20200312105637.GA8960@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312105637.GA8960@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 01:56:37PM +0300, Dan Carpenter wrote:
> This NULL check is reversed so it leads to a Smatch warning and
> presumably a NULL dereference.
> 
>     kernel/events/core.c:1598 perf_event_groups_less()
>     error: we previously assumed 'right->cgrp->css.cgroup' could be null
> 	(see line 1590)
> 
> Fixes: 95ed6c707f26 ("perf/cgroup: Order events in RB tree by cgroup id")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6a47c3e54fe9..607c04ec7cfa 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1587,7 +1587,7 @@ perf_event_groups_less(struct perf_event *left, struct perf_event *right)
>  			 */
>  			return true;
>  		}
> -		if (!right->cgrp || right->cgrp->css.cgroup) {
> +		if (!right->cgrp || !right->cgrp->css.cgroup) {
>  			/*
>  			 * Right has no cgroup but left does, no cgroups come
>  			 * first.

Thanks!
