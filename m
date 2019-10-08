Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 136A7CFF94
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 19:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfJHRMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 13:12:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42568 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfJHRMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=81zxahn4idnt6KAxrGxdcivM0a7ejpPHFI2trXWy0Dg=; b=mfX0Tv/Z5F9+vPsWf2XMGfVPR
        gUUnITVfrmtbLzPSf6nWiR4Gi9i6FGXjlEdGGTOmmQSBOTe4Q3oR19gushH56m5UBlxrgprU6ULVR
        OLmJho4h4FzDkQJbt1fk5d3Z3R18iwg2etlbRdYeVmyb7iYjEOHuZDnnkxKczE/PU+I2aVgMd0d/x
        Uyp7vKgRdh5oToBeWA30YdBopV2hg10lmppGxTpm/KeECCCqiORebFQcciD4Uj2hAW7IM8xolZFwm
        lQAKy6ArwiapJ49TncGKsQ/+y9SDNZqp48yLOIMko1ens2vV0/FTwyfdylh+NYaWrV0FjwHxP4UHI
        WCO1i7Atw==;
Received: from [31.161.223.134] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHt1r-0003wh-Fu; Tue, 08 Oct 2019 17:12:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF3EE9802E0; Tue,  8 Oct 2019 19:11:37 +0200 (CEST)
Date:   Tue, 8 Oct 2019 19:11:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191008171137.GA22902@worktop.programming.kicks-ass.net>
References: <20191007081716.07616230.8@infradead.org>
 <20191007081945.10951536.8@infradead.org>
 <20191008104335.6fcd78c9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008104335.6fcd78c9@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 10:43:35AM -0400, Steven Rostedt wrote:

> BTW, I'd really like to take this patch series through my tree. That
> way I can really hammer it, as well as I have code that will be built
> on top of it.

Works for me; or we can have a topic branch in tip we both can use.
Ingo?

> I'll review the other series in this thread, but I'm assuming they
> don't rely on this series? Or do they?

Indeed, this series stands on it's own. The rest depends on this.
