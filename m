Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22417140E34
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 16:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgAQPrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 10:47:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53026 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgAQPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:47:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so7916555wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 07:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Bj0wpfeG4WUbynTokfuhSk08I/UsNl1uvGCOq3jYT0=;
        b=tzZRYC8OABVTP1W0y3Dim9rK+94HNd9Sw/aRkd6WTEwx4ae9Upw7FtE9ki9m6YQeUS
         UKpyXwudhvbhiKC1t2Q7ctyLIrPGs292gUUrQDXPxkK3HrHzUVGoSqsM7ArHlT9GNHGe
         B7+VQmhNzXqwY00sw5CSDfHdD0ns5JkavVh/GwMGoFu12rNpF+2Q2bns0sBPy9fpPN2X
         AvniLcTQ7gw1v8LEVwIKi8LqtIheFLwonAe8Um8/5Wp/rxPp0TcMarqheGDjlD/bFy4N
         jSFsbPEtmpm6ThEXqXactlCZiG+TNS6rc9i7e1QMe7Du62WESREdXb6BW7GvIWqx9WWt
         4slg==
X-Gm-Message-State: APjAAAWCk+F1RkePcrPhRzvQfB3y40B86uXPLdU2uPOiWcYOvkhYy3uf
        cuqqYUt9p4uq1SztuX1a+L4=
X-Google-Smtp-Source: APXvYqxvFy2I3vgmVlD3PjVc6nrcUsOWbf3nQbihKUYrVjXoA2ms3aHznTtU5u1TdPGXx8upDvD4lg==
X-Received: by 2002:a1c:f218:: with SMTP id s24mr5462989wmc.128.1579276019240;
        Fri, 17 Jan 2020 07:46:59 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id s128sm10370683wme.39.2020.01.17.07.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 07:46:58 -0800 (PST)
Date:   Fri, 17 Jan 2020 16:46:57 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200117154657.GL19428@dhcp22.suse.cz>
References: <20200117143905.GZ19428@dhcp22.suse.cz>
 <3B7490FB-E915-4DC7-8739-01EDC023E22E@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B7490FB-E915-4DC7-8739-01EDC023E22E@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 10:05:12, Qian Cai wrote:
> 
> 
> > On Jan 17, 2020, at 9:39 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > Thanks a lot. Having it in a separate patch would be great.
> 
> I was thinking about removing that WARN together in this v5 patch,
> so there is less churn to touch the same function again. However, I
> am fine either way, so just shout out if you feel strongly towards a
> separate patch.

I hope you meant moving rather than removing ;). The warning is useful
because we shouldn't see unmovable pages in the movable zone. And a
separate patch makes more sense because the justification is slightly
different. We do not want to have a way for userspace to trigger the
warning from userspace - even though it shouldn't be possible, but
still. Only the offlining path should complain.

-- 
Michal Hocko
SUSE Labs
