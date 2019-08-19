Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9199D9239C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 14:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfHSMil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 08:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfHSMil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:38:41 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C88E02085A;
        Mon, 19 Aug 2019 12:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566218320;
        bh=eQNahmOy+YOa70o8hxUX1/wwoHoUbdXOo6roeegsQow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cpidswUycCY0vFKSKTaIBQdWf+F18sTgCc8BYCJ2tD56TtVawYSEF8+h7Ys9LnowC
         hdl3hCORNQ1tZ9deitnOIl60UY0Uk31Q4jdmszcNVuNvQTK1HpSAiwSE1QSc9HyxTs
         DAyms2dvo5Ql8MxqTUlmiMV1JOaa0PlDR4Rm5fEM=
Date:   Mon, 19 Aug 2019 14:38:38 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH -rcu dev 1/3] rcu/tree: tick_dep_set/clear_cpu should
 accept bits instead of masks
Message-ID: <20190819123837.GC27088@lenoir>
References: <20190816025311.241257-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816025311.241257-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 10:53:09PM -0400, Joel Fernandes (Google) wrote:
> This commit fixes the issue.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0512de9ead20..322b1b57967c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -829,7 +829,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
>  		   !rdp->dynticks_nmi_nesting &&
>  		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
>  		rdp->rcu_forced_tick = true;
> -		tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> +		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);

Did I suggest you to use the _MASK_ value? That was a bit mean.
Sorry for all that lost debugging time :-(
