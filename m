Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A721A199AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 18:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbgCaQBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 12:01:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35373 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730845AbgCaQBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:01:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id k13so23565910qki.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KUXmLIQ+aLx+dsd2X6HDAS3m5DJ2KKoj8xObBaVjK4k=;
        b=iTuWUT6v6SPVuXPY9PvsAXbyhjYvsl0LYe57OruuLwH4ntWsnzYQJa0fyxayYlq8hB
         sbrLQW99kG1zDFcfBUsesq/nKvY3XcbTSh74JL27Fas3ze+KrwEBFFKob958qMMnSgkC
         jYoxFLqxXoBLeYzwZ2UMAsxNjVMZ+k4Ak8d8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KUXmLIQ+aLx+dsd2X6HDAS3m5DJ2KKoj8xObBaVjK4k=;
        b=VwlpK+wK/k1aIwwn4iHUe/5APGjNirMg85SJNvh1gT6wkAdgwM1kj5dFWF/6LWcdz3
         NTkdRknTCXGIUe8yrsxOldmcP8sIVEYuFLbXVMuyQQe2JmarC/X79DeMcwBXtW8NyI7v
         oJu1SBbFrOVhmjH3fa12worsfn6pAIu3ShtxISY51zKZMGw3jtZglIFDcdFmlv11V65P
         9fBNCszB5YMPfCpOLTtnYp6hZtxC8nfsrwR9ikKH+xnsVpr5tc6yLBPBk1V7FuMdo0ZS
         iQA1m4KDJsBey6XD1Jp4VlAlpzP7hdwUloPHvC7uSGs8RBIr1JeTCCQ2Sw8Ny6Y7rYiH
         9xPQ==
X-Gm-Message-State: AGi0PuY1p6C7vJs79WCzdZgvswdsa/mAn+V2U54053brWfrXRCiqBAe5
        XHYaKyaNRvsWmneoMZhaVcRPpg==
X-Google-Smtp-Source: APiQypJlQCeOHLVheNSd8NA+Re55P3E8j2hVLv1JFketxo3lxvPNs0ci4X6V6rEh2Rw+3VC64pNnJQ==
X-Received: by 2002:a37:a88e:: with SMTP id r136mr269788qke.12.1585670478283;
        Tue, 31 Mar 2020 09:01:18 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b145sm12861514qkg.52.2020.03.31.09.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 09:01:17 -0700 (PDT)
Date:   Tue, 31 Mar 2020 12:01:17 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200331160117.GA170994@google.com>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331145806.GB236678@google.com>
 <20200331153450.GM30449@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331153450.GM30449@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 05:34:50PM +0200, Michal Hocko wrote:
> On Tue 31-03-20 10:58:06, Joel Fernandes wrote:
> [...]
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 4be763355c9fb..965deefffdd58 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3149,7 +3149,7 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
> > >  
> > >  	if (!ptr)
> > >  		ptr = kmalloc(sizeof(unsigned long *) +
> > > -				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
> > > +				sizeof(struct rcu_head), GFP_MEMALLOC);
> > 
> > Just to add, the main requirements here are:
> > 1. Allocation should be bounded in time.
> > 2. Allocation should try hard (possibly tapping into reserves)
> > 3. Sleeping is Ok but should not affect the time bound.
> 
> 
> __GFP_ATOMIC | __GFP_HIGH is the way to get an additional access to
> memory reserves regarless of the sleeping status.
> 
> Using __GFP_MEMALLOC is quite dangerous because it can deplete _all_ the
> memory. What does prevent the above code path to do that?

Can you suggest what prevents other users of GFP_MEMALLOC from doing that
also? That's the whole point of having a reserve, in normal usage no one will
use it, but some times you need to use it. Keep in mind this is not a common
case in this code here, this is triggered only if earlier allocation attempts
failed. Only *then* we try with GFP_MEMALLOC with promises to free additional
memory soon.

> If a partial access to reserves is sufficient then why the existing
> modifiers (mentioned above are not sufficient?

The point with using GFP_MEMALLOC is it is useful for situations where you
are about to free memory and needed some memory temporarily, to free that. It
depletes it a bit temporarily to free even more. Is that not the point of
PF_MEMALLOC?
* %__GFP_MEMALLOC allows access to all memory. This should only be used when
 * the caller guarantees the allocation will allow more memory to be freed
 * very shortly e.g. process exiting or swapping. Users either should
 * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).

I was just recommending usage of this flag here because it fits the
requirement of allocating some memory to free some memory. I am also Ok with
GFP_ATOMIC with the GFP_NOWARN removed, if you are Ok with that.

thanks,

 - Joel

