Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D477BB93B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 18:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbfIWQOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 12:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388475AbfIWQOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:14:07 -0400
Received: from paulmck-ThinkPad-P72 (unknown [170.225.9.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAF6B2089F;
        Mon, 23 Sep 2019 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569255246;
        bh=5Bu5JajfHxIPKIuW/hfxIoOLm6DlnN9YhqTiX1zuKVE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nmyhlCMd6nmYnU9S+Wm1tuJMEFsBCwhtoWCkaHbsxyisQl3NH5d5jJ2p09XMOuu/L
         3C/cEaE9zcxygK3u36p9X7g/M/IIHmfPRx16KLyPiJobCVbdv6dAOWubEerW/xr4qC
         U4kvimSUXafphtd/VeuoxEpbtJyhTuAdlAhHOV/s=
Date:   Mon, 23 Sep 2019 09:14:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Fix uninitialized variable in nocb_gp_wait()
Message-ID: <20190923161403.GB7828@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20190923142634.GC31251@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923142634.GC31251@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 05:26:34PM +0300, Dan Carpenter wrote:
> We never set this to false.  This probably doesn't affect most people's
> runtime because GCC will automatically initialize it to false at certain
> common optimization levels.  But that behavior is related to a bug in
> GCC and obviously should not be relied on.
> 
> Fixes: 5d6742b37727 ("rcu/nocb: Use rcu_segcblist for no-CBs CPUs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch!  Queued for v5.5, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 2defc7fe74c3..fa08d55f7040 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1946,7 +1946,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  	int __maybe_unused cpu = my_rdp->cpu;
>  	unsigned long cur_gp_seq;
>  	unsigned long flags;
> -	bool gotcbs;
> +	bool gotcbs = false;
>  	unsigned long j = jiffies;
>  	bool needwait_gp = false; // This prevents actual uninitialized use.
>  	bool needwake;
> -- 
> 2.20.1
> 
