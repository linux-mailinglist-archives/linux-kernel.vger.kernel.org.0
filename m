Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B63CBBC7D8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436556AbfIXM1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 08:27:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:52202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390187AbfIXM1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:27:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0D6DB0E2;
        Tue, 24 Sep 2019 12:27:47 +0000 (UTC)
Date:   Tue, 24 Sep 2019 14:27:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] memcg: Only record foreign writebacks with dirty
 pages when memcg is not disabled
Message-ID: <20190924122747.GQ23050@dhcp22.suse.cz>
References: <20190923083030.6442-1-bhe@redhat.com>
 <20190924111138.GA31919@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924111138.GA31919@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-09-19 19:11:51, Baoquan He wrote:
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f3c15bb07cce..84e3fdb1ccb4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4317,6 +4317,9 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
>  
>  	trace_track_foreign_dirty(page, wb);
>  
> +	if (mem_cgroup_disabled())
> +		return;
> +

This doesn't seem correct. We shouldn't even enter the slowpath with
memcg disabled AFAIC. The check should be done at mem_cgroup_track_foreign_dirty
level.
-- 
Michal Hocko
SUSE Labs
