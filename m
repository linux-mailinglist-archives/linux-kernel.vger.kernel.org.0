Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3252180CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 01:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgCKAe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 20:34:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46449 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgCKAe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 20:34:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id w12so210477pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 17:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EUgxSFzxsUY/usxfE7ZrpCJnCGl7oImcT7mAmsT3xVk=;
        b=HRsswEgRKstttsVjHQn36J5/ARhpNxIYX8ivglq3UXHIJGgoqNWCki62T5SzkSme+Q
         r/8Q3IMb3LeYjVTGjyNpdDUIV7+oQ1MzkVUbdrAjyLlXSx9c5N/5zmgFQC++vpypJDtJ
         APMR98Weq+5nbefMDo3N8P2Uefg6ODCre3UVjrKyg8gjYYEe7ZDtdotKLavvHHZ6G2Ob
         /RCmMY+OeX47pmIo7iOKciksUTajd5BfbWhSkEBkffm/oQgG9PaCmyaEaNOHI3S3SJuP
         7o78Y4qE7kU9Z/AUreFfSsPJwL2zSnXkvL1XuUWpVZc6JXp8TmPtW+5jF/4GCJWftvEu
         nDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EUgxSFzxsUY/usxfE7ZrpCJnCGl7oImcT7mAmsT3xVk=;
        b=UscZpYuQy8Z2KmPtegeAFtMgxeDJdZ1Dxg5X/CFmO5DPnZlJtRqmDZMt1FSA+4bdeH
         RYAWfQkeKerT24CS/X7is+59YgB6kqOnYWmjJ0ithPtnqTKsgK+LhBlPlWaaOlAwACgC
         9XCd+96oHZjB+Xvj5K6dLRXRMf1BMKMPxJtTsph3wUdO2nS0TkvdNe/or6ErkqoT4Mvj
         cZCbw3L9bmgaRt5ou0qRdxhpACamkfSAvRNeRNRJGDATigMOixHOLH67MzxQdbwRKQNn
         dbf7aajQys/UDwbaCqfTPlW2lGH4ROwstx1wcelLCzP1i7B8yTB/e5CncTSqjlI12thq
         kpAA==
X-Gm-Message-State: ANhLgQ2eFup8qITvbAu4dtpr+WMcgSDuFMois8kegB4u/c1tWBOTmYKQ
        eHWHLbVdGANwd00jsk6MYPwuig==
X-Google-Smtp-Source: ADFU+vsYrAFY6Y+rHV7p5q+CJQGhf+lYaty4o9vEA8v7dmsGetV+uKoEiSazD0lwfZTa85zypWXK/A==
X-Received: by 2002:a17:90a:8d07:: with SMTP id c7mr610229pjo.94.1583886894884;
        Tue, 10 Mar 2020 17:34:54 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 13sm47107657pgo.13.2020.03.10.17.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 17:34:54 -0700 (PDT)
Date:   Tue, 10 Mar 2020 17:34:53 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP
 systems
In-Reply-To: <20200310171802.128129f6817ef3f77d230ccd@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.2003101724010.197777@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com> <20200310171802.128129f6817ef3f77d230ccd@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020, Andrew Morton wrote:

> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2637,6 +2637,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> >  		unsigned long reclaimed;
> >  		unsigned long scanned;
> >  
> > +		cond_resched();
> > +
> >  		switch (mem_cgroup_protected(target_memcg, memcg)) {
> >  		case MEMCG_PROT_MIN:
> >  			/*
> 
> 
> Obviously better, but this will still spin wheels until this tasks's
> timeslice expires, and we might want to do something to help ensure
> that the victim runs next (or soon)?
> 

We used to have a schedule_timeout_killable(1) to address exactly that 
scenario but it was removed in 4.19:

commit 9bfe5ded054b8e28a94c78580f233d6879a00146
Author: Michal Hocko <mhocko@suse.com>
Date:   Fri Aug 17 15:49:04 2018 -0700

    mm, oom: remove sleep from under oom_lock

This is why we don't see this issue on 4.14 guests but we do on 4.19.  I 
had assumed the issue Tetsuo reported that resulted in that patch was 
still an issue and I preferred to fix the weird UP issue by adding a 
cond_resched() that is likely needed for the iteration in 
shrink_node_memcg() anyway.  Do we care to optimize for UP systems 
encountering memcg oom kills?  Eh, maybe, but I'm not very interested in 
opening up a centithread about this.

> (And why is shrink_node_memcgs compiled in when CONFIG_MEMCG=n?)
> 

This guest does have CONFIG_MEMCG enabled, it's a memcg oom condition.

But unrelated to this patch, I think it's just a weird naming for it.  The 
do-while loop in shrink_node_memcgs() actually uses memcg = NULL for the 
non-memcg case and is responsible for calling into page and slab reclaim.
