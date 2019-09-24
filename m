Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C2BBC88F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 15:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfIXNFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 09:05:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbfIXNFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 09:05:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C55B618CB8E9;
        Tue, 24 Sep 2019 13:05:01 +0000 (UTC)
Received: from localhost (ovpn-12-49.pek2.redhat.com [10.72.12.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21DFD19C6A;
        Tue, 24 Sep 2019 13:05:00 +0000 (UTC)
Date:   Tue, 24 Sep 2019 21:04:58 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] memcg: Only record foreign writebacks with dirty
 pages when memcg is not disabled
Message-ID: <20190924130458.GB31919@MiWiFi-R3L-srv>
References: <20190923083030.6442-1-bhe@redhat.com>
 <20190924111138.GA31919@MiWiFi-R3L-srv>
 <20190924122747.GQ23050@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924122747.GQ23050@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Tue, 24 Sep 2019 13:05:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/19 at 02:27pm, Michal Hocko wrote:
> On Tue 24-09-19 19:11:51, Baoquan He wrote:
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index f3c15bb07cce..84e3fdb1ccb4 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -4317,6 +4317,9 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
> >  
> >  	trace_track_foreign_dirty(page, wb);
> >  
> > +	if (mem_cgroup_disabled())
> > +		return;
> > +
> 
> This doesn't seem correct. We shouldn't even enter the slowpath with
> memcg disabled AFAIC. The check should be done at mem_cgroup_track_foreign_dirty
> level.

You mean the way in v1 patch, right? It's also fine to me.

I am worried about the case that memcg is enabled, the checking by
calling mem_cgroup_disabled() will lower efficiency. And it entering
into mem_cgroup_track_foreign_dirty_slowpath() should be a rare event.

Thanks
Baoquan
