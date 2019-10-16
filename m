Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE6CAD871F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 06:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388256AbfJPEFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 00:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbfJPEFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 00:05:34 -0400
Received: from paulmck-ThinkPad-P72 (unknown [76.14.14.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C8CC2086A;
        Wed, 16 Oct 2019 04:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571198733;
        bh=bLVt4JROsq+t6v6tIFjTfp1UJXlkovihrqKUyRDZKlM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=twyQH/wyZTfLUHLG+2mqhHLxXCYEaStxfbEb5gwnzUqzP1ZPipvoYvEBJkSl3Yz+b
         eKbmuoJP+EepB/rjrHqaYDG3B3AFtDP18KJ40S8V19Xn9Anhb6LtcExiP+edYIFgiu
         UaxbjiuWq6LieqpVAViyCy/Yhq6moit4U9JccuI0=
Date:   Tue, 15 Oct 2019 21:05:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: rcu_segcblist.c make undeclared items static
Message-ID: <20191016040531.GD2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191015105524.1676-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015105524.1676-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 11:55:24AM +0100, Ben Dooks wrote:
> The following are not used outside the unit they are
> declared in, so make them static to avoid the following
> sparse warnings:
> 
> kernel/rcu/rcu_segcblist.c:91:6: warning: symbol 'rcu_segcblist_set_len' was not declared. Should it be static?
> kernel/rcu/rcu_segcblist.c:107:6: warning: symbol 'rcu_segcblist_add_len' was not declared. Should it be static?
> kernel/rcu/rcu_segcblist.c:137:6: warning: symbol 'rcu_segcblist_xchg_len' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Good catch, but commit 292d1bb2 ("rcu: Several rcu_segcblist functions
can be static") beat you to it by a month or two.  This commit is still
in -rcu, but will be part of my pull request in a couple of weeks.

See -rcu branch "dev":

	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

							Thanx, Paul

> ---
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: rcu@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/rcu/rcu_segcblist.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 495c58ce1640..cbc87b804db9 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -88,7 +88,7 @@ struct rcu_head *rcu_cblist_dequeue(struct rcu_cblist *rclp)
>  }
>  
>  /* Set the length of an rcu_segcblist structure. */
> -void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
> +static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
>  {
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	atomic_long_set(&rsclp->len, v);
> @@ -104,7 +104,7 @@ void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
>   * This increase is fully ordered with respect to the callers accesses
>   * both before and after.
>   */
> -void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
> +static void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
>  {
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	smp_mb__before_atomic(); /* Up to the caller! */
> @@ -134,7 +134,7 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp)
>   * with the actual number of callbacks on the structure.  This exchange is
>   * fully ordered with respect to the callers accesses both before and after.
>   */
> -long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
> +static long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
>  {
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	return atomic_long_xchg(&rsclp->len, v);
> -- 
> 2.23.0
> 
