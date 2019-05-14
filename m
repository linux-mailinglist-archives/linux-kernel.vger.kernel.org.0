Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80B4F1C7DC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 13:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfENLfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 07:35:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENLfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hdo3J+SKgWMYdkmLex1ScT4QKrEl5Fkd2SvwQB3f/zU=; b=eG6Qnz3DL+iAnoIykPjWycQ24
        XVA3G+osUl6uBIBNgtqHwidCwRHxK4E9/K0v2UHH4+oswQZYC5gpYwRC42f3z68fe9KUI63ivYlXy
        XmPckJkK3cfuX4iq7yxWqsecCrfMSd3yjuDodOmL79Hx1EHi9OqtTG1L8uw9npWO+E74yxREqK8RM
        FXCMz/eSYKCYVFQUiEKaWuaz2EtG+q3ZRXnqFL36QaGx1hrR014pGceOmHYXmNpRTIqvptgjFhnYk
        QwnnicyeLIGkbxUcyA37jw9S5joDPHb27g2VajMJV+lxF1fwlFaZMjmrguQEnZOCGxgsHnT6hwUln
        TWc5opcVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQVie-0000IC-M5; Tue, 14 May 2019 11:35:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89F562029F877; Tue, 14 May 2019 13:35:38 +0200 (CEST)
Date:   Tue, 14 May 2019 13:35:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     minyard@acm.org, linux-rt-users@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190514113538.GL2589@hirez.programming.kicks-ass.net>
References: <20190508205728.25557-1-minyard@acm.org>
 <20190509161925.kul66w54wpjcinuc@linutronix.de>
 <20190514084356.GJ2589@hirez.programming.kicks-ass.net>
 <20190514091219.nesriqe7qplk3476@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514091219.nesriqe7qplk3476@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 11:12:19AM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-05-14 10:43:56 [+0200], Peter Zijlstra wrote:
> > Now.. that will fix it, but I think it is also wrong.
> > 
> > The problem being that it violates FIFO, something that might be more
> > important on -RT than elsewhere.
> 
> Wouldn't -RT be more about waking the task with the highest priority
> instead the one that waited the longest?

Possibly, but that's a far larger patch. Also, even with that
completions do not avoid inversions and thus don't really make nice RT
primitives anyway.
