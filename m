Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2A13B6BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 02:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAOBTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 20:19:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbgAOBTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 20:19:31 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E390E214AF;
        Wed, 15 Jan 2020 01:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579051171;
        bh=ktOauvrUOBF6V2YXVtNEGXvaG7vGM34H3Rv5P2vEd6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=btxWWaF3YEeRL18RbRYNFF3qURcbo/cUEjyh5J+ixuPzVEe4INLT5zWFeyvXRRfcL
         6QVD4L4w6FSWOk2QicOq7omFqD1ATKLsfDx4fi48df27aT4DHmZNr2n5odfUcKO70l
         SNMvRBYsbqo75lEcZ57g5Y4g/Ery3mRTvDkWrv64=
Date:   Tue, 14 Jan 2020 17:19:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/hotplug: silence a lockdep splat with printk()
Message-Id: <20200114171930.9a0dbd9ae82174abf19b3df5@linux-foundation.org>
In-Reply-To: <DEF43337-68A2-4FDF-9B8C-795E017831DE@lca.pw>
References: <20200114210215.GQ19428@dhcp22.suse.cz>
        <D5CC7C52-1F08-401E-BDCA-DF617909BB9D@lca.pw>
        <20200114155339.ad5eee63b9ff38b617ee6168@linux-foundation.org>
        <DEF43337-68A2-4FDF-9B8C-795E017831DE@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 20:02:31 -0500 Qian Cai <cai@lca.pw> wrote:

> 
> 
> >> @@ -8290,8 +8290,10 @@ bool has_unmovable_pages(struct zone *zo
> >> 	return false;
> >> unmovable:
> >> 	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> >> -	if (flags & REPORT_FAILURE)
> >> -		dump_page(pfn_to_page(pfn + iter), reason);
> >> +	if (flags & REPORT_FAILURE) {
> >> +		page = pfn_to_page(pfn + iter);
> > 
> > This statement appears to be unnecessary.
> 
> dump_page() in set_migratetype_isolate() needs that “page”.

local var `page' is never used after this statement.


