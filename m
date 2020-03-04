Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D755178959
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 05:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCDEFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 23:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCDEFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 23:05:16 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2552D20842;
        Wed,  4 Mar 2020 04:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583294716;
        bh=p68B3/NdMMEqbeyhZmAihrJUVvRMPdRtxZQobAvEOyM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=j3Kw6Ptf84PP0JOZulhFtKrdFN3Dvd+4jR6BYn8Ca/sFmyWJN1NMIXcCFceMBbJVp
         7q1/XrSmLvybJXlJ9Ji3OuS7Cj8OxCPUYUnBp2lPkydnFToZydwHD/X8HiJlV+OS1g
         t+eJhXsmGAMGSmjwtH2aoU2r0wVFkyD+i7C2CUcY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E291835226C4; Tue,  3 Mar 2020 20:05:15 -0800 (PST)
Date:   Tue, 3 Mar 2020 20:05:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, elver@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] lib: disable KCSAN for XArray
Message-ID: <20200304040515.GX2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200304031551.1326-1-cai@lca.pw>
 <20200304033329.GZ29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304033329.GZ29971@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 07:33:29PM -0800, Matthew Wilcox wrote:
> On Tue, Mar 03, 2020 at 10:15:51PM -0500, Qian Cai wrote:
> > Functions like xas_find_marked(), xas_set_mark(), and xas_clear_mark()
> > could happen concurrently result in data races, but those operate only
> > on a single bit that are pretty much harmless. For example,
> 
> Those aren't data races.  The writes are protected by a spinlock and the
> reads by the RCU read lock.  If the tool can't handle RCU protection,
> it's not going to be much use.

Would KCSAN's ASSERT_EXCLUSIVE_BITS() help here?

If not, you lost me on this one.  RCU readers don't exclude lock-based
writers.

RCU readers -do- exclude pre-insertion initialization on the one hand,
and those post-removal accesses that follow a grace period, but only
if that grace period starts after the removal.  In addition, the
accesses due to rcu_dereference(), rcu_assign_pointer(), and similar
are guaranteed to work even if they are concurrent.

Or am I missing something subtle here?

That said, you are permitted to define "data race" for your subsystem
by choosing KCSAN settings, up to and including keeping KCSAN out
entirely.

							Thanx, Paul
