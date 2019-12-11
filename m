Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 668F711A333
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 04:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfLKDvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 22:51:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfLKDvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 22:51:23 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B03C620836;
        Wed, 11 Dec 2019 03:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576036282;
        bh=eFzj21qYloauMwUtdCGqTFTX4luWwusPmqSOsOyh+MA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kj8YTiynoPvqVPGtD11yWfGHT3qlut5vNEgfozkqAZo1l9ZP/AfhmRA1YzcHtPd9u
         0WNKCcmHhY+hnJ4op/45/iKK1O7rgERiuAwa1joHTeJT4K6FDUbfoSStHSdg+cgG4d
         H2VytX4+E+ivZoHg3e43NuzMKPUsgFmo9irJQCrQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 58986352276C; Tue, 10 Dec 2019 19:51:22 -0800 (PST)
Date:   Tue, 10 Dec 2019 19:51:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>
Subject: Re: [PATCH tip/core/rcu 01/12] rcu: Remove rcu_swap_protected()
Message-ID: <20191211035122.GC2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
 <20191210040741.2943-1-paulmck@kernel.org>
 <yq1a77zmt4a.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1a77zmt4a.fsf@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 10:35:49PM -0500, Martin K. Petersen wrote:
> 
> Paul,
> 
> > Now that the calls to rcu_swap_protected() have been replaced by
> > rcu_replace_pointer(), this commit removes rcu_swap_protected().
> 
> It appears there are two callers remaining in Linus' master. Otherwise
> looks good to me.

I did queue a fix for one of them, and thank you for calling my
attention to the new one.  This commit should hit -next soon, so
hopefully this will discourage further additions.  ;-)

> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

Thank you!

							Thanx, Paul
