Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7450F52549
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 09:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfFYHvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 03:51:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfFYHvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VCfTXrUT51VC3fOwD5moxz0xBEdZcUd6I6RBk2NwmkI=; b=gonuAL+aTKeGAvseXB8jqKHYL
        qz9yE/6zh0ol5fVjbgalChRyQipUdaYeHn5w9eRo6uk6VcG2tTliPfUd5fba+D8hOBXKtVN+viIsP
        eZ7eoSQg4leFt1qWYbqPR5TcXRvFvlZx5AN71RC8QlXoiDOShg4/WmBOfoEys+YMy0CXH+I6wuGSB
        mPCGLkypi3WYC87Fdtad7MstGhFrSlGhcPpdhesj3Ep1jUng468bn04XNAZrr9r5gXd8dxhqp8dIF
        dDUIXPlolI+783UKTdXSi75HZ62mW76I629ngj1FCj5ufLozGwyrte3NILCu1oHZRb3SRGySi875Y
        ZYOioN0eQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfgEu-0006b9-Uy; Tue, 25 Jun 2019 07:51:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F1B320A02444; Tue, 25 Jun 2019 09:51:39 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:51:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Message-ID: <20190625075139.GT3436@hirez.programming.kicks-ass.net>
References: <20190621105503.GI3436@hirez.programming.kicks-ass.net>
 <20190621121630.GE26519@linux.ibm.com>
 <20190621122927.GV3402@hirez.programming.kicks-ass.net>
 <20190621133414.GF26519@linux.ibm.com>
 <20190621174104.GA7519@linux.ibm.com>
 <20190621175027.GA23260@linux.ibm.com>
 <20190621234602.GA16286@linux.ibm.com>
 <20190624231222.GA17497@lerouge>
 <20190624234422.GP26519@linux.ibm.com>
 <20190625004300.GB17497@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625004300.GB17497@lerouge>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 02:43:00AM +0200, Frederic Weisbecker wrote:
> Yeah, unfortunately there is no atomic_add_not_zero_return().

There is atomic_fetch_add_unless().
