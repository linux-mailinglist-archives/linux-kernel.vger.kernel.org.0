Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEAB29A9A8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 10:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbfHWIHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 04:07:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35838 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731543AbfHWIHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HklP2O9Kga3Zf1O48/hnO6Dj5tVsMpIzpCAbR7UGcaQ=; b=v/ir+K7NcWiBEHyoGh8LziBYc
        X+sWsZZQw1eeD3ALOG3fb6oBMBxIP/KgL8f4beyO24Il9nsIl7tWESo/xHaPYF8kfvFAlGrF4V2E7
        cc6TJ/e/3EZwlP05Rrph10QHTihJiL2/M+ybiXR0FAbYNqsuM/p21IWG4Byx1Kq3EdeZCh+KEDlx2
        g7Z+iSP9YLFa7XurKqSs2lvwk/o7mKnaCvA2yyP1ECYnx1DXJWBGOkagL4hplGTYhJEt+1rB90Efg
        wyhAl/WSdqCQGSgV+u2fXmBRcz3Lyt7S9YaaRQsuKYhv/EDCybtSlk4jCrybQg/82o8a3bRXYHYQt
        PZOq21Yzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i14bE-00074E-KO; Fri, 23 Aug 2019 08:07:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 896F7307145;
        Fri, 23 Aug 2019 10:06:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAD83202D580B; Fri, 23 Aug 2019 10:07:06 +0200 (CEST)
Date:   Fri, 23 Aug 2019 10:07:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Hunt <johunt@akamai.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, bpuranda@akamai.com
Subject: Re: [PATCH] perf/x86/intel: restrict period on Nehalem
Message-ID: <20190823080706.GA2369@hirez.programming.kicks-ass.net>
References: <1566256411-18820-1-git-send-email-johunt@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566256411-18820-1-git-send-email-johunt@akamai.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 07:13:31PM -0400, Josh Hunt wrote:
> We see our Nehalem machines reporting 'perfevents: irq loop stuck!' in
> some cases when using perf:
> 
> perfevents: irq loop stuck!

> I found that a period limit of 32 was the lowest I could set it to without
> the problem reoccurring. The idea for the patch and approach to find the
> target value were suggested by Ingo and Thomas.
> 
> Signed-off-by: Josh Hunt <johunt@akamai.com>
> Reported-by: Bhupesh Purandare <bpuranda@akamai.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Ingo Molnar <mingo@redhat.com>
> Link: https://lore.kernel.org/lkml/20150501070226.GB18957@gmail.com/
> Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.1908122133310.7324@nanos.tec.linutronix.de/

Thanks!
