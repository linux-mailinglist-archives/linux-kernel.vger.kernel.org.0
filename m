Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 524D879180
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 18:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbfG2Qyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 12:54:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48710 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfG2Qyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ih+8jGaNPkIieBi7y6bE+jbDtJCtU3TtT+BWz5ZYUcs=; b=YHqMNYELuuLbpvCffz34gvm64
        xLn8QrmVCqumw256N1Tbr3Q1IxHdrbm604ifmdOlJZzH9c3ZcHf6PAB5RJEiXGlELnKv72M6zPKqZ
        tZ3e2wrxlTnz1e1lVWerHYxaJDZUHWP5tEl58G/uss02SCnKj+1j9sGwV6iw69y9KPTpSpwfVamts
        SueXsslp9WaFwo2kT6/hrq7d/VTKD2VdJZ86gS+h2H0wzewhCkl9IOIOwYEP/OWKW2hNRrAN4nkM7
        4YYJW3c7lgO2y6x8F2aFpNuv7lVtQD3XeU1OdJUeiaClyJ/MAaS+g4ZmQRGK0UOiRcQEEIRG6TXx3
        nIVSfpPWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs8ux-0004Ib-Pq; Mon, 29 Jul 2019 16:54:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DFF320AFFEAD; Mon, 29 Jul 2019 18:54:34 +0200 (CEST)
Date:   Mon, 29 Jul 2019 18:54:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] sched/deadline: Use return value of SCHED_WARN_ON()
 in bw accounting
Message-ID: <20190729165434.GO31398@hirez.programming.kicks-ass.net>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-6-dietmar.eggemann@arm.com>
 <20190726121819.32be6fb1@sweethome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726121819.32be6fb1@sweethome>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 12:18:19PM +0200, luca abeni wrote:
> Hi Dietmar,
> 
> On Fri, 26 Jul 2019 09:27:56 +0100
> Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> 
> > To make the decision whether to set rq or running bw to 0 in underflow
> > case use the return value of SCHED_WARN_ON() rather than an extra if
> > condition.
> 
> I think I tried this at some point, but if I remember well this
> solution does not work correctly when SCHED_DEBUG is not enabled.

Well, it 'works' in so far that it compiles. But it might not be what
one expects. That is, for !SCHED_DEBUG the return value is an
unconditional false.

In this case I think that's fine, the WARN _should_ not be happending.
