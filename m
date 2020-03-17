Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE3D189197
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 23:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCQWsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 18:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgCQWsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:48:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5180B20714;
        Tue, 17 Mar 2020 22:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584485300;
        bh=LGaYyzaACZxQUiveGMPC6ogAlcxLxgk2zp4wsFwphuQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e8L6cui+VZBmHflBZ9UGww44K3b07hYtCxqYr3IUV9lMHo1Aqsu3F7lzx3Vz9S17Y
         lDz9r5QucaIzh1tlZ1vJKcYHVCAeWNXZzsBMJRn81fTjXXt4uTlDCGz1iH7RK7xJK4
         ZgQ+lwBSFrMe4gZHNAVLiksF3E8/rAYnjr3vCDWU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 28644352272E; Tue, 17 Mar 2020 15:48:20 -0700 (PDT)
Date:   Tue, 17 Mar 2020 15:48:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH v2 rcu-dev 1/3] rcuperf: Add ability to increase object
 allocation size
Message-ID: <20200317224820.GP3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200316163228.62068-1-joel@joelfernandes.org>
 <20200317210822.GM3199@paulmck-ThinkPad-P72>
 <20200317214502.GA29184@paulmck-ThinkPad-P72>
 <CAEXW_YQxKfcGf3UgEn_8hdWHdMx09RvD90z6zo=kk-iRinYjng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQxKfcGf3UgEn_8hdWHdMx09RvD90z6zo=kk-iRinYjng@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 06:30:51PM -0400, Joel Fernandes wrote:
> On Tue, Mar 17, 2020 at 5:45 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Mar 17, 2020 at 02:08:22PM -0700, Paul E. McKenney wrote:
> > > On Mon, Mar 16, 2020 at 12:32:26PM -0400, Joel Fernandes (Google) wrote:
> > > > This allows us to increase memory pressure dynamically using a new
> > > > rcuperf boot command line parameter called 'rcumult'.
> > > >
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > Applied for testing and review, thank you!
> >
> > But testing did not go far:
> >
> > kernel/rcu/tree.c: In function ‘kfree_rcu_shrink_count’:
> > kernel/rcu/tree.c:3120:16: warning: unused variable ‘flags’ [-Wunused-variable]
> >   unsigned long flags, count = 0;
> 
> I fixed the warning already but did not resend since it was just the
> one unused variable warning. The patches are otherwise good to apply.
> Sorry, and I can resend it soon if you are not reapplying right now.

So remove "flags, " and all is well?

If so, I can just as easily fix that as take a new series.  But next
time, please give a fella a warning.  ;-)

							Thanx, Paul
