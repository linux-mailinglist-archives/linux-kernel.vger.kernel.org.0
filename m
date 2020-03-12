Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A396183A77
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 21:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCLUQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 16:16:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50631 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgCLUQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:16:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id a5so7550619wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 13:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yLZW/qZRAwj/qZJYLmvntwJ6WgyWrrnV7NOpGpMsiCs=;
        b=jbV8E88NLQfbdkS5DY1hzLENcONNrR0k9Pwhzs7tkxp9eZ6d2bsxc1adv190rwQWtL
         XNfi9B7ftJW8lfcB1nIDV+clmE73IhaEOsFt1IwGvOy3xGpsb4CPSpoa8wRl9EC7c7pS
         TLFRPEyILOXy75AgkcWaqEPDQ7tGlwRd0lo4Jz+fr/tw+4X38k8gCgG3sJcxrVP7EcR6
         SBzvPmSk1YwGBkxH5YjBi3+9i4jSwPzSxJODV1B8iOKV1swggOAkTj+EOEGpbhdQmj+E
         tG4iBZG6y04VpKJ5r8bfQniryKnj/aD6sGuISv6KCKjPBOVEhsGP/Gt/7ww8Hcwc+Q9n
         2ETQ==
X-Gm-Message-State: ANhLgQ0+LhEg5CUvGQ5Nw15/DHRcgHwQCosG5xDJ0vZVxnz9y7PBYXFZ
        Hmhskg1Ixv4wUt0pk+ENthtlZmNT
X-Google-Smtp-Source: ADFU+vtu0EFJe8mhzRbybBzoeEImlTuTlN0krmWnh7UWi4FFLFI3RkTCF8/xnt5kVpC7WefZTxBQQg==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr6345011wmd.23.1584044186750;
        Thu, 12 Mar 2020 13:16:26 -0700 (PDT)
Received: from localhost (ip-37-188-253-35.eurotel.cz. [37.188.253.35])
        by smtp.gmail.com with ESMTPSA id i10sm70877339wrn.53.2020.03.12.13.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 13:16:25 -0700 (PDT)
Date:   Thu, 12 Mar 2020 21:16:24 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
Message-ID: <20200312201624.GD23944@dhcp22.suse.cz>
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com>
 <20200310221019.GE8447@dhcp22.suse.cz>
 <alpine.DEB.2.21.2003101556270.177273@chino.kir.corp.google.com>
 <20200311082736.GA23944@dhcp22.suse.cz>
 <alpine.DEB.2.21.2003111238570.171292@chino.kir.corp.google.com>
 <20200312083241.GT23944@dhcp22.suse.cz>
 <alpine.DEB.2.21.2003121115480.158939@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003121115480.158939@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-03-20 11:20:33, David Rientjes wrote:
> On Thu, 12 Mar 2020, Michal Hocko wrote:
> 
> > > I think the changelog clearly states that we need to guarantee that a 
> > > reclaimer will yield the processor back to allow a victim to exit.  This 
> > > is where we make the guarantee.  If it helps for the specific reason it 
> > > triggered in my testing, we could add:
> > > 
> > > "For example, mem_cgroup_protected() can prohibit reclaim and thus any 
> > > yielding in page reclaim would not address the issue."
> > 
> > I would suggest something like the following:
> > "
> > The reclaim path (including the OOM) relies on explicit scheduling
> > points to hand over execution to tasks which could help with the reclaim
> > process.
> 
> Are there other examples where yielding in the reclaim path would "help 
> with the reclaim process" other than oom victims?  This sentence seems 
> vague.

In the context of UP and !PREEMPT this also includes IO flushers,
filesystems rely on workers and there are things I am very likely not
aware of. If you think this is vaague then feel free to reformulate.
All I really do care about is what the next paragraph is explaining.

> > Currently it is mostly shrink_page_list which yields CPU for
> > each reclaimed page. This might be insuficient though in some
> > configurations. E.g. when a memcg OOM path is triggered in a hierarchy
> > which doesn't have any reclaimable memory because of memory reclaim
> > protection (MEMCG_PROT_MIN) then there is possible to trigger a soft
> > lockup during an out of memory situation on non preemptible kernels
> > <PUT YOUR SOFT LOCKUP SPLAT HERE>
> > 
> > Fix this by adding a cond_resched up in the reclaim path and make sure
> > there is a yield point regardless of reclaimability of the target
> > hierarchy.
> > "
> > 

-- 
Michal Hocko
SUSE Labs
