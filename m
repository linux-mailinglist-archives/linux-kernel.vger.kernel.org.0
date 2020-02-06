Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 737EF1545AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 15:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgBFODu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 09:03:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38332 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l3dSs9JJWDrZzkDc9n6Hxfa0vrCSBaESt/sYufaXU0c=; b=BHH4yM50LhLkmL/Hg+7EncUPvP
        C6sZuWPCYUCf+fVyhjNTPykwmZc+D8OSqJezFNjSkS0U8pcCzlh8n7065y5ZCLyRzO3lXO2OaXWKb
        YHOPR9trqnBETcrS1PrkrKWNdDNug29tkdeoK7dOzCpAd/Ve1e4m8Pn2VMukOR5FlWCWXbbo56oe+
        1lYDElEd9JwnEFr05EJBf+FZ86hE4zocfiFl4d5jJ2XVn5e9dKPMLchvHygl1boQfNtv7ejJ9r44W
        7bnYVkxWrd6+hLWW0GVtUveiQnMVZ72oxWCZZb/ow1jVB28yRfu5sjJaciZuMP2VLBplbznVHinV3
        8fU2p8mA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izhki-0003L1-1Z; Thu, 06 Feb 2020 14:03:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C0653007F2;
        Thu,  6 Feb 2020 15:01:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77A482B76D3B4; Thu,  6 Feb 2020 15:03:29 +0100 (CET)
Date:   Thu, 6 Feb 2020 15:03:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] psi: Fix OOB write when writing 0 bytes to psi files
Message-ID: <20200206140329.GX14879@hirez.programming.kicks-ass.net>
References: <20200203212216.7076-1-surenb@google.com>
 <20200204185523.GC9027@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204185523.GC9027@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 01:55:23PM -0500, Johannes Weiner wrote:
> On Mon, Feb 03, 2020 at 01:22:16PM -0800, Suren Baghdasaryan wrote:
> > Issuing write() with count parameter set to 0 on any file under
> > /proc/pressure/ will cause an OOB write because of the access to
> > buf[buf_size-1] when NUL-termination is performed. Fix this by checking
> > for buf_size to be non-zero.
> > 
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!
