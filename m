Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE9815BB65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 10:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgBMJQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 04:16:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40866 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgBMJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4vhmf3DfYgCxxMcfNakVANw6c8V541MWMOKqcLRnwZ4=; b=ku/BpLGKwsgfbGC6UpccsJkusm
        ohh433d8dfXGfwe16+tgYPg8Bfs61/UNrURkxYS7FjkBPNij3Wn3RTdmj4bIrXTWyuKkhUhS5of1Y
        e1nsY7NFhV4UFXAkDgWrZWsnNfgt+1QiOxVuS6aWjEljsaFE2XdaySBm/ErnGeOkQWXOUqCHB0DNr
        dSIj1/lXMIyyOOxfUS8NIbzdx4vNDe2tEBc+nJiV4Hd48pwGs2LEVEvU+sUxotJ7PiaAsU1bxw9kY
        TacLjLVvSIgJqcov7PVb66TaEHWfGB1x3byc4bDZRzZNcV3yLpeiVM/omvElhYtBhMaabCAdPeNFO
        VMcDT38g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2AcA-0006XK-6X; Thu, 13 Feb 2020 09:16:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 278B930066E;
        Thu, 13 Feb 2020 10:15:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2FCC2B2E4991; Thu, 13 Feb 2020 10:16:51 +0100 (CET)
Date:   Thu, 13 Feb 2020 10:16:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de,
        Stefan Asserhall load and store 
        <stefan.asserhall@xilinx.com>, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, paulmck@kernel.org
Subject: Re: [PATCH 7/7] microblaze: Do atomic operations by using exclusive
 ops
Message-ID: <20200213091651.GA14946@hirez.programming.kicks-ass.net>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <ba3047649af07dadecf1a52e7d815db8f068eb24.1581522136.git.michal.simek@xilinx.com>
 <20200212155500.GB14973@hirez.programming.kicks-ass.net>
 <4b46b33e-14ad-7097-f0db-2915ac772f15@xilinx.com>
 <20200213085849.GL14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213085849.GL14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:58:49AM +0100, Peter Zijlstra wrote:

> The thing is, your bog standard LL/SC _SHOULD_ fail the SC if someone
> else does a regular store to the same variable. See the example in
> Documentation/atomic_t.txt.
> 
> That is, a competing SW/SWI should result in the interconnect responding
> with something other than EXOKAY, the SWX should fail and MSR[C] <- 1.

The thing is; we have code that relies on this behaviour. There are a
few crusty SMP archs that sorta-kinda limp along (mostly by disabling
some of the code and praying the rest doesn't trigger too often), but we
really should not allow more broken SMP archs.
