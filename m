Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51BC34E683
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 12:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFUKzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 06:55:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfFUKzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 06:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LuPwWLJynX8GvwQriBR71Fk/5CC/VXtUT8F+b2eXJ5I=; b=KzY1kuznZOAKgKZre++F2FZMa
        TEcY1KyYkD3ynoFQxZDwGFtA1KZCFTSC8/om8CAp1PRl9U/T+JLOXq/e/pk4X2adDsgcdz/QhcYNW
        rBCrL4otARaBYzjjjscuxgFU+8eJE0fJuzBKuTfoacxy/D0ms6HypwvnueOsU72jv/dsZ8xMcbIj6
        M0BsR4g2krhrTVpDX7BosBDQ+ZRHq6p4oD6vlfMnQN4Rz/u+uDKDbMIqKpJTT3XEvLiNwoIwgfXiS
        Lqktw5qf2wuVrUx7Agi1F3cxVaWwbyLUmiK9bObZV1vXHrZsC5aApI+LNoJRPIz3UJXhaVv34maqN
        XU6IfsE1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heHCD-0008OR-6Z; Fri, 21 Jun 2019 10:55:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 260BE20098E65; Fri, 21 Jun 2019 12:55:03 +0200 (CEST)
Date:   Fri, 21 Jun 2019 12:55:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        frederic@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Message-ID: <20190621105503.GI3436@hirez.programming.kicks-ass.net>
References: <20190619181903.GA14233@linux.ibm.com>
 <20190620121032.GU3436@hirez.programming.kicks-ass.net>
 <20190620160118.GQ26519@linux.ibm.com>
 <20190620211019.GA3436@hirez.programming.kicks-ass.net>
 <20190620221336.GZ26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620221336.GZ26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 03:13:36PM -0700, Paul E. McKenney wrote:
> So how about the following patch, which passes very light rcutorture
> testing but should otherwise be regarded as being under suspicion?

Looks good to me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Or, if you want me to apply it, I can do that too ;-)
