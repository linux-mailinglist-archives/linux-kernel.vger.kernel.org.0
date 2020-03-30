Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09FB1197AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 13:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgC3L35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 07:29:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38912 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbgC3L35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DeWliaRGTXo6DycY5C8MQuSMr5H8DptXxvKxOSvq2j0=; b=HArCBpUWonH3glfMs0CaXsfUR+
        VcxkpEYMvTMXh3gCsMw5gR/BMzFRKyOmzlgYr6rERcM+VW45cwamaLO5ndeDGlBpXxOW+jGXT4s/f
        BcGyk4+PBGTNjBAUv73NXnNryvA76Sl46uWRukfkBbYZB5FDUlCfofedj8Cld/G4h1u0dbPN5aJ/H
        aNut+ZZHkLvvvzaUM0kCnCWs+qBwN0kbiyiVgmP4fGc0+Rj7AFfWmRQ3TRKHxX6sNLi3l/b0zUW42
        XNFreBxLcd+NNQRGNgBQIvlGJ9p5l68PVP7DddMOTjZQfICjTasJv/G7U6vvykiBCZUDmPrSQ+QIa
        a/G+ZuPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIsba-0004Rs-By; Mon, 30 Mar 2020 11:29:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 545B93010C1;
        Mon, 30 Mar 2020 13:29:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44CA029D04D6A; Mon, 30 Mar 2020 13:29:20 +0200 (CEST)
Date:   Mon, 30 Mar 2020 13:29:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     julia.lawall@lip6.fr, boqun.feng@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/10] sched/fair: Replace 1 and 0 by boolean value
Message-ID: <20200330112920.GK20696@hirez.programming.kicks-ass.net>
References: <0/10>
 <20200327212358.5752-1-jbi.octave@gmail.com>
 <20200327212358.5752-8-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327212358.5752-8-jbi.octave@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 09:23:54PM +0000, Jules Irenge wrote:
> Coccinelle reports a warning at voluntary_active_balance
> 
> WARNING: return of 0/1 in function voluntary_active_balance with return type bool

Please, can someone take that senseless script away? This is whitespace
wankery.
