Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72BC44E7FB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 14:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfFUM3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 08:29:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFUM3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JtzNg/W/9Z6R95MFKLpT3RlW96vhlKcRykI0P3sQui0=; b=ZF4pc1R7fl8qHacYV1cu3GmxH
        XPxWGMaPLa9b+5Gjos6wyI+1XXE4oNWt9RtlIy123V7hm0dkm8subteupi4VU5+1SrBGDROPOv7b/
        PsA6S0xmnJ4HsscJjuMXCDISBjcQzDl/hGeICkQKKk/UUQEHfYN4ZmX6vpGsJDsGjI5qfX9fH9UFa
        5n7Nmkx5U1vi31FK/OzKsiUrdh5Q7wu4r4wmwHwRX6s5WCPrB89BcV03x3FfCsn3/9jAXHqsOh88M
        0LhWFQeaZdDutUTqN5H/Kick7DzDx9Sk/MKUpBk/YOGS/TdsygR/y3aBJuFvhZidGQb/pmH+0C7q2
        CRcSE2ccg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heIfZ-0001vZ-SZ; Fri, 21 Jun 2019 12:29:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4365203C694A; Fri, 21 Jun 2019 14:29:27 +0200 (CEST)
Date:   Fri, 21 Jun 2019 14:29:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        frederic@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Message-ID: <20190621122927.GV3402@hirez.programming.kicks-ass.net>
References: <20190619181903.GA14233@linux.ibm.com>
 <20190620121032.GU3436@hirez.programming.kicks-ass.net>
 <20190620160118.GQ26519@linux.ibm.com>
 <20190620211019.GA3436@hirez.programming.kicks-ass.net>
 <20190620221336.GZ26519@linux.ibm.com>
 <20190621105503.GI3436@hirez.programming.kicks-ass.net>
 <20190621121630.GE26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621121630.GE26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 05:16:30AM -0700, Paul E. McKenney wrote:
> A pair of full hangs at boot (TASKS03 and TREE04), no console output
> whatsoever.  Not sure how these changes could cause that, but suspicion
> falls on sched_tick_offload_init().  Though even that is a bit strange
> because if so, why didn't TREE01 and TREE07 also hang?  Again, looking
> into it.

Pesky details ;-)
