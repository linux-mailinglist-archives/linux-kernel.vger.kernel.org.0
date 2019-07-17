Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D4E6B77F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 09:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfGQHri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 03:47:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34946 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfGQHri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 03:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=137oFZdIMwQeknQ338SRCTrIfINUInCNQV8/ADqzoZQ=; b=gQEbcXoCLBv5bror+grY2I1qL
        OpkcQCC8KyTxHYUIde8PkDqM7Svzc+XcFme1M192nKJDvk9KOfRVWFGYXaTmpSC8x3fkYiIkHELMs
        J6okvQSea68X9nAdF0YRfve1pTpsTz6fiNLdXtfYYvsV7HOTSkvHwyZ084toVr2LJXjxAq114YOtn
        OGdwEEAiyAY2z3+oRkTlhyJVMJmX2xqteiZU586Rq2+TujCBQh8xR16ZRyXsP79EQA9yuFWKzyqno
        eymQbOfVY2I7Ur2Rt6qWjzFFEITgkqG3I/1rbX7uEyrcLRqycRgD/t72qFZMFyZAg6zu2EVd9oeYY
        rTXrK2UnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hneef-0008PA-Qo; Wed, 17 Jul 2019 07:47:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 877B12059DEA3; Wed, 17 Jul 2019 09:47:12 +0200 (CEST)
Date:   Wed, 17 Jul 2019 09:47:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux_lkml_grp@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Subject: Re: [PATCH v3 0/6] Tracing vs CR2
Message-ID: <20190717074712.GV3419@hirez.programming.kicks-ass.net>
References: <20190711114054.406765395@infradead.org>
 <4c71e14d-3a32-c3bb-8e3b-6e5100853192@oracle.com>
 <97cdd0af-95cc-2583-dc19-129b20809110@oracle.com>
 <CALCETrVisJsLk10WY6hgkqAJ7UsJCr4hHcdtrcUkMaPNOGNYLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVisJsLk10WY6hgkqAJ7UsJCr4hHcdtrcUkMaPNOGNYLg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 06:02:33PM -0700, Andy Lutomirski wrote:

> On a different thread, Peter and I decided that the last patch in this
> series (the one that removes the _DEBUG stuff) is wrong.  Can you see
> if these are reproducible with that patch removed?

Wrong is maybe the wrong word :-), premature maybe, we definitely want to
get there, but the #DB crud needs a wee bit of work first.
