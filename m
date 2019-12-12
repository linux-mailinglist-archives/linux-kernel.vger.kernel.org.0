Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C6511D8DB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 22:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbfLLVzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 16:55:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34871 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731204AbfLLVzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:55:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so282997pgk.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 13:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h/VdtXdRQlPmJqNAwJpL0SAreQKh5WfidHfGkffdfTY=;
        b=akQTQ8DGz4+sLf+zxm0p7E7OSR4ZVNkCljcLLOLKtWKJJXAmgxCFUjPlwOG5fbSC9N
         mERo4ScyELdDEEkmatrR1iPy+pdwUVhfxjnUUIR+kUGOsjfUBzr5wxbpFNbTqRNtQ09z
         b+wx6vcHLgpVhQN4aXYz0T07BsuRDMg6DU2cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h/VdtXdRQlPmJqNAwJpL0SAreQKh5WfidHfGkffdfTY=;
        b=o6Q7UEQJquuxoW7+6my68OZCvFeV/mkeUH9UQ5fXjTtWt7sSqfkL5X5xdCouYxvEdT
         rBb6YlVMM2dtconn/qx19E7ZmWb/EKjv7qdnnRZtu2AKQ7DOkGC24daxK4XQtkqvHVZK
         fs+xq1OVfhQ34Jdy0RNuogIiGqn1Z0vh68SWLnWfa74sA5PkLbjeLhDRLpPKI+0P0C9l
         RHuvCXyUt/qOMnmi40P/gGk/D/EddDqUHGd1AyInXCnf2QewoEDgvVqKJEGKngzTvZMA
         AtaJ8DeH24bBmvxjtyxZ3wlYxcAmXbvIa/dtZu0NCqvOe/DzLtriPq1vpeSbJkBPdBeA
         eAEQ==
X-Gm-Message-State: APjAAAUfYbwUcAeKLRdxhp9EhTngGY4XL9XcaE/0jW+XAJZCaexIUXEr
        2a4ytjIYl7sHxP4fdJjuNikzG6DVEtA=
X-Google-Smtp-Source: APXvYqwsMX2eicc0dbN7r6W5gmKv0tIxPb2fvRfeVxEEAY6q0Rx/j41gSkqdSqxQQojNi+feY0HBOQ==
X-Received: by 2002:a63:7843:: with SMTP id t64mr13106609pgc.144.1576187736533;
        Thu, 12 Dec 2019 13:55:36 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k88sm7172380pjb.15.2019.12.12.13.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:55:35 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:55:34 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     madhuparnabhowmik04@gmail.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, linux-nfs@vger.kernel.org,
        rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: nfs: dir.c: Fix sparse error
Message-ID: <20191212215534.GE129023@google.com>
References: <20191206151640.10966-1-madhuparnabhowmik04@gmail.com>
 <20191206160238.GE2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206160238.GE2889@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 08:02:38AM -0800, Paul E. McKenney wrote:

Thanks for fixing these issues and I caught up with all the patches.

> 
> o	Create a list that is safe for bidirectional RCU traversal.
> 	This can use list_head, and would need these functions,
> 	give or take the exact names:

On a related topic, I was trying to reason about how one could come up with
bidirectional traversal without ever getting rid of poisoning.

As you noted in another post, if during traversal, the node is deleted and
poisoned, then the traverser can access a poisoned pointer. If the list is
being traversed in reverse (by following prev), then poisioning could hurt
it.

Even with the below modifications, poisoning would still hurt it. No? Were
you suggesting to remove poisoning for such bidirectional RCU list?

Sorry if I missed something.
thanks,

 - Joel


> 	list_add_tail_rcuprev():  This is like list_add_tail_rcu(),
> 	but also has smp_store_release() for ->prev.  (As in there is
> 	also a __list_add_rcuprev() helper that actually contains the
> 	additional smp_store_release().)
> 
> 	list_del_rcuprev():  This can be exactly __list_del_entry(),
> 	but with the assignment to ->prev in __list_del() becoming
> 	WRITE_ONCE().  And it looks like callers to __list_del_entry()
> 	and __list_del() might need some attention!  And these might
> 	result in additional users of *_rcuprev().
> 
> 	list_prev_rcu() as in your first patch, but with READ_ONCE().
> 	Otherwise DEC Alpha can fail.  And more subtle compiler issues
> 	can appear on other architectures.
> 
> 	Note that list_move_tail() will be OK give or take *_ONCE().
> 	It might be better to define a list_move_tail_rcuprev(), given
> 	the large number of users of list_move_tail() -- some of these
> 	users might not like even the possibility of added overhead due
> 	to volatile accesses.  ;-)
> 
> Or am I missing something subtle here?
> 
> 							Thanx, Paul
