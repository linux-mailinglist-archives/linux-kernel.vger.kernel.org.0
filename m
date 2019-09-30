Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D3FC222F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbfI3Ngb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 09:36:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbfI3Nga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RCTV04raDkkKxz4YfrxK2di9zmQ5xBd+idZOcERAO2c=; b=mwWxPsDSKJ2eCW+r/wgaUxNTy
        C8UW2Qf27DuQBkhjrUCoc31xyeiErGedJMwNHL9jUw91SOVwxmfzYgQwhgUoeJ72I5km5jdk/p6Hh
        uD9rQvu04Sg5pPW83+EoRvaF4Rr+QPXW11sut0PxOH2yDldqx6v9Pq+mEnzCYvly1Au8taLL4N/EY
        CJq/gbHv7Jbatcv9eXhcO5eDAkzJ0TcCtjiFlBaecjc2p4rYDSegzHw7UqCjCBpR6RsAbDLNkQvzM
        B6FS6dVdSv1TwGjdHcz3CkKH9DDxlHaKB41ENgAma7BudhfpOoY7djtI/OTIUJZCyZRCpF75VLekX
        EonLkXcPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEvqk-0002AQ-LY; Mon, 30 Sep 2019 13:36:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D878301B59;
        Mon, 30 Sep 2019 15:35:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 239DA265261B4; Mon, 30 Sep 2019 15:36:24 +0200 (CEST)
Date:   Mon, 30 Sep 2019 15:36:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V4 07/14] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190930133624.GO4553@hirez.programming.kicks-ass.net>
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
 <20190916134128.18120-8-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916134128.18120-8-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 06:41:21AM -0700, kan.liang@linux.intel.com wrote:
> +static int add_nr_metric_event(struct cpu_hw_events *cpuc,
> +			       struct perf_event *event,
> +			       int *max_count)
> +{
> +	/* There are 4 TopDown metrics events. */
> +	if (is_metric_event(event) && (++cpuc->n_metric_event > 4))
> +		return -EINVAL;
> +
> +	*max_count += cpuc->n_metric_event;

That's busted; it would increment with 1,2,3,4 for a total of 10.

> +
> +	return 0;
> +}
