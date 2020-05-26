Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D0419990F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 16:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgCaO6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 10:58:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44409 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730592AbgCaO6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:58:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id j4so23223395qkc.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cIZTwSTovCqpZjcH+8VKON/BYcVXt4dyLFHN/7fWLC0=;
        b=kX2+YjEFA7reVl0nZqgetW7HHWs3WBI8tDuovxTjTwwVwqW3601QSEjGEsCGuePVj7
         LeJYnQq9IpkrFubdFv7FGPJwARcYAe9R6jylxk3Pa+7d/tXkyxj20UwItvKvKi6iEgdm
         3Bb9hGRRxwfEbpNgz5aR7L0gIR2HceLIlhu8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cIZTwSTovCqpZjcH+8VKON/BYcVXt4dyLFHN/7fWLC0=;
        b=MIhaCWOPiG9Wk4Trdg5qkMaK6tfglwf6PO8i6B4ML9wCteAP8OYjVr2RBoc+nZrhTs
         DlsQYqSvLXHYu4mcY5oLY6zz8YSHTI6YM2p8LPOW7PGjQU6Gq9979THRzVjYvwJGkg9F
         8INb77KJiKGOj/L/VhQS/nJD0HZHLOPYxpT55piEpMMGQu67I6e1SowZD93fN9r4iD03
         linI4463Jpk1LYsdAzDl55RRueOcUlBUD/AzIZG0u+bguqSKMdj1hrwgjxTkLMwyEtHB
         QluCxQFkO5aV1Xw7VMkiWg+CakHuAYK+6iSaihYOZM0zUpPOcvyyAUNYMkZpXRp/UTqN
         INFw==
X-Gm-Message-State: ANhLgQ2QRFH2ph0R+NVYaCxQyOYu0DU+cacNCTJfEbo/dYz1F2Uvn4Xt
        hfzm2j18Na8e4lQ0zQqNAs+tAtxytwE=
X-Google-Smtp-Source: ADFU+vvPtFUJr9gLEzw5E54meLVFZylfDHn2cwkCKpLYfEDzB9hmFVGY0wKdA27LYbe+/zml0iNEug==
X-Received: by 2002:a37:a4d6:: with SMTP id n205mr5467313qke.352.1585666687349;
        Tue, 31 Mar 2020 07:58:07 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n142sm12693714qkn.11.2020.03.31.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:58:06 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:58:06 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, rcu@vger.kernel.org, willy@infradead.org,
        peterz@infradead.org, neilb@suse.com, vbabka@suse.cz,
        mgorman@suse.de, Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200331145806.GB236678@google.com>
References: <20200331131628.153118-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331131628.153118-1-joel@joelfernandes.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 09:16:28AM -0400, Joel Fernandes (Google) wrote:
> In kfree_rcu() headless implementation (where the caller need not pass
> an rcu_head, but rather directly pass a pointer to an object), we have
> a fall-back where we allocate a rcu_head wrapper for the caller (not the
> common case). This brings the pattern of needing to allocate some memory
> to free some memory.  Currently we use GFP_ATOMIC flag to try harder for
> this allocation, however the GFP_MEMALLOC flag is more tailored to this
> pattern. We need to try harder not only during atomic context, but also
> during non-atomic context anyway. So use the GFP_MEMALLOC flag instead.
> 
> Also remove the __GFP_NOWARN flag simply because although we do have a
> synchronize_rcu() fallback for absolutely worst case, we still would
> like to not enter that path and atleast trigger a warning to the user.
> 
> Cc: linux-mm@kvack.org
> Cc: rcu@vger.kernel.org
> Cc: willy@infradead.org
> Cc: peterz@infradead.org
> Cc: neilb@suse.com
> Cc: vbabka@suse.cz
> Cc: mgorman@suse.de
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> 
> This patch is based on the (not yet upstream) code in:
> git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch rcu/kfree)
> 
> It is a follow-up to the posted series:
> https://lore.kernel.org/lkml/20200330023248.164994-1-joel@joelfernandes.org/
> 
> 
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 4be763355c9fb..965deefffdd58 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3149,7 +3149,7 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
>  
>  	if (!ptr)
>  		ptr = kmalloc(sizeof(unsigned long *) +
> -				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
> +				sizeof(struct rcu_head), GFP_MEMALLOC);

Just to add, the main requirements here are:
1. Allocation should be bounded in time.
2. Allocation should try hard (possibly tapping into reserves)
3. Sleeping is Ok but should not affect the time bound.

Considering this, GFP_MEMALLOC|GFP_NOWAIT seems appropriate. Thoughts?

thanks,

 - Joel


