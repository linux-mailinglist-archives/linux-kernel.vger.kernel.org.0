Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92D2184874
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 14:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgCMNts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 09:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgCMNts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:49:48 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE868206B7;
        Fri, 13 Mar 2020 13:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584107387;
        bh=At/75gfQwkhyDMreQNSP6ToQofJ4Q7qQJMTCfs6C/io=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GfU+L0K/k90Bm8na1YSrZ4vf9Wp9FDH+ezeOGE2p//LpG5E5IissloSZX08X1JsFp
         j/oEVSb8hnv0fk7S07leNxNxy9YQt0bE8AzwjCdxCnqcvRh7JhLNFrK0rE/GF7Dxsx
         byha3pKVZMSUuZKof6dyCxd4T0OZUKJFd/6XCmOw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7FD4E3522719; Fri, 13 Mar 2020 06:49:47 -0700 (PDT)
Date:   Fri, 13 Mar 2020 06:49:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] rcu-tasks: fix a modpost warning for
 rcu_tasks_rude_wait_gp
Message-ID: <20200313134947.GP3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200313113810.3840-1-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313113810.3840-1-hqjagain@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 07:38:10PM +0800, Qiujun Huang wrote:
> Found by gcc:
> WARNING: modpost: "rcu_tasks_rude_wait_gp" [vmlinux] is a static
> EXPORT_SYMBOL_GPL
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>

Good eyes, thank you!

However, the fix is instead to remove the EXPORT_SYMBOL_GPL().  I will
squash the removal of this line into a04838a348a9 ("rcu-tasks: Add an
RCU-tasks rude variant"), crediting you with catching this bug.

Again, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index cd071b5d4274..04d3c583a9fc 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -447,7 +447,7 @@ static void rcu_tasks_be_rude(struct work_struct *work)
>  }
>  
>  // Wait for one rude RCU-tasks grace period.
> -static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> +void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>  {
>  	schedule_on_each_cpu(rcu_tasks_be_rude);
>  }
> -- 
> 2.17.1
> 
