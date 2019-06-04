Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8701A348E6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 15:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfFDNeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 09:34:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfFDNeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4GBeWmWCYkD89Byp2KrQ9ABSiLX5gR7QPL7++L6RRC8=; b=mP0JzEi3hr6+3dPYaLeEWlPzT
        mbeC0GNsy2U9iirCAH0EILYRdTjacotxeKPHhPXGVmhvLnfZ21FKnkWeHG73k3S3KMrQfII3YQqCv
        ieERIq2n94wKb4MZpP8VPm3UmodSmLOQq9TuNXUcV1pCEmYFn6JoqaaIMinczWJxt37zT/KUphcd/
        4hJSsWlFxFFrUasWlKz4XdNGPy5P7aArC3Y/4wmqUk42DtUtckzfSnf7Vxb4Qte5/jqr/lvO+msTF
        rrz/maIPE+nIlf03XYFpvpQaWLp51mlqjwmmDuIExE9EmtWcmMCLYz7bLv0n2sfcJwHTM1xpzk4ZO
        pN1Zlv24Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY9Zz-0007KM-RL; Tue, 04 Jun 2019 13:34:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A70CD20114D94; Tue,  4 Jun 2019 15:34:17 +0200 (CEST)
Date:   Tue, 4 Jun 2019 15:34:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/fpu: Simplify kernel_fpu_begin
Message-ID: <20190604133417.GD3419@hirez.programming.kicks-ass.net>
References: <20190604071524.12835-1-hch@lst.de>
 <20190604071524.12835-3-hch@lst.de>
 <20190604114701.GM3402@hirez.programming.kicks-ass.net>
 <20190604131138.GB22542@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604131138.GB22542@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 03:11:38PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 04, 2019 at 01:47:01PM +0200, Peter Zijlstra wrote:
> > > +	if (current->mm && !test_thread_flag(TIF_NEED_FPU_LOAD)) {
> > 
> > Did that want to be: !(current->flags & PF_KTHREAD), instead?
> > 
> > Because I'm thinking that kernel_fpu_begin() on a kthread that has
> > use_mm() employed shouldn't be doing this..
> 
> Well, this is intended to not change semantics.  If we should fix
> this is should be a separate patch before or after this series.

Sure; it's just that I just noticed it. We've recently ran into a
similar issue elsewhere.
