Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A9BDEC70
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 14:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfJUMmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 08:42:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55838 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfJUMmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s6bPfILtf/MtKzudVEW8etD9Dr+AOkV83tWje6slQZA=; b=n9kwZPMrRM8Hx1isbSoM1vlol
        BlzsP3wa2Ln2jzxT1cWL8TqPw3j4wXPVbklxZscTIaOg02So/jnWlwv9z9fVpHH2ZriM8ViTGVmNR
        C8jcDmhg23zohFfq24ziyEo1RiZeDhce+MSNBAN7h+/WSjZPO+cH4PSoJMLQAoFSQ93EVm3g7h5Jz
        KV1adJnkcCwf5W08oyJ+Bo42N0MA0mVI68btYI+XYDkq9gvU9yYUBgg4YIPJtWFYar2PAvMuPhiWj
        BQBKFoLgdQADpzd4pVUmHT6ue8r4yDbwYqxwP7K0bv4AU4yFFJuLETdlyYYUFp9MT5u6qmvRzLSK2
        fANOhj4lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMX0p-0004V0-Rw; Mon, 21 Oct 2019 12:42:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BAAE301124;
        Mon, 21 Oct 2019 14:41:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55BEF2022BA17; Mon, 21 Oct 2019 14:42:14 +0200 (CEST)
Date:   Mon, 21 Oct 2019 14:42:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog/softlockup: Preserve original timestamp
 when touching watchdog externally
Message-ID: <20191021124214.GD1817@hirez.programming.kicks-ass.net>
References: <20190819104732.20966-1-pmladek@suse.com>
 <20190819104732.20966-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819104732.20966-2-pmladek@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 12:47:30PM +0200, Petr Mladek wrote:
> Some bug report included the same softlockups in flush_tlb_kernel_range()
> in regular intervals. Unfortunately was not clear if there was a progress
> or not.
> 
> The situation can be simulated with a simply busy loop:
> 
> 	while (true)
> 	      cpu_relax();
> 
> The softlockup detector produces:
> 
> [  168.277520] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
> [  196.277604] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
> [  236.277522] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [cat:4865]
> 
> One would expect only one softlockup report or several reports with
> an increased duration.

Let's just say our expectations differ.

> The result is that each softlockup is reported only once unless
> another process get scheduled:
> 
> [  320.248948] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4916]

Which would greatly confuse me; as the above would have me think the
situation got resolved (no more lockups reported) even though it is
still very much stuck there.

IOW, I don't see how this makes anything better. You're removing
information.
