Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80496198835
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 01:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgC3XZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 19:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729360AbgC3XZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:25:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6597D20733;
        Mon, 30 Mar 2020 23:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585610705;
        bh=CW5W2odPF+X6jORiftGFOScxeCEkL8MSvWI5irb+e0o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=S3uI88bTqKZzYLy91vMNO4bJJddG5wvwNkFYadqaAnLjdYEI1HOJpNNh5J3gcaMC/
         fy1/ClnNa5Z/pAnSs+HlhN4Krzrb31JVlXehWbfGMx2Gtay+NQuLppE85lYZHzvlAq
         ydJTWEGKQA5K4jY4Ot9epYlD8hijT2IaSAolkQW8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3A1E43523140; Mon, 30 Mar 2020 16:25:05 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:25:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 08/21] Revert "list: Use WRITE_ONCE() when
 initializing list_head structures"
Message-ID: <20200330232505.GD19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-9-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-9-will@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:30PM +0000, Will Deacon wrote:
> This reverts commit 2f073848c3cc8aff2655ab7c46d8c0de90cf4e50.
> 
> There is no need to use WRITE_ONCE() to initialise a non-RCU 'list_head'.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>

And attention to lockless uses of list_empty() here, correct?

Depending on the outcome of discussions on 3/21, I should have added in
all three cases.

							Thanx, Paul

> ---
>  include/linux/list.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index c7331c259792..b86a3f9465d4 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -32,7 +32,7 @@
>   */
>  static inline void INIT_LIST_HEAD(struct list_head *list)
>  {
> -	WRITE_ONCE(list->next, list);
> +	list->next = list;
>  	list->prev = list;
>  }
>  
> -- 
> 2.20.1
> 
