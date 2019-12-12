Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B17DB11D4E4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 19:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfLLSHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 13:07:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730304AbfLLSHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:07:41 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1540E21556;
        Thu, 12 Dec 2019 18:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576174060;
        bh=7JxF7qlG8TCPWnDPzZgbQ3ebBCcdJS+oN0FEpXv0GfQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JXkLX1OluMqqPy0R9SYwYDWxJrmMzd6K8MYmgGBuWxjlG0/D8gpeEYzaoggRWgBkp
         o/k6R3AIzCN20dlJPguNrzjzU65m+o+pI2vKWsCPLVYsLYxqeaRHJrCo/eATvaKF0A
         jzZUg5+Vav2q3Nl9XSzJQSanhy7jS95I5oGtlCMY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A11A63522757; Thu, 12 Dec 2019 10:07:39 -0800 (PST)
Date:   Thu, 12 Dec 2019 10:07:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] rcu: fix spelling mistake "leval" -> "level"
Message-ID: <20191212180739.GZ2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191212173643.91135-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212173643.91135-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 05:36:43PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a pr_info message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Good catch!  Queued, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 4d4637c361b7..0765784012f8 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -57,7 +57,7 @@ static void __init rcu_bootup_announce_oddness(void)
>  	if (qlowmark != DEFAULT_RCU_QLOMARK)
>  		pr_info("\tBoot-time adjustment of callback low-water mark to %ld.\n", qlowmark);
>  	if (qovld != DEFAULT_RCU_QOVLD)
> -		pr_info("\tBoot-time adjustment of callback overload leval to %ld.\n", qovld);
> +		pr_info("\tBoot-time adjustment of callback overload level to %ld.\n", qovld);
>  	if (jiffies_till_first_fqs != ULONG_MAX)
>  		pr_info("\tBoot-time adjustment of first FQS scan delay to %ld jiffies.\n", jiffies_till_first_fqs);
>  	if (jiffies_till_next_fqs != ULONG_MAX)
> -- 
> 2.24.0
> 
