Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA9EE98D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 10:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfJ3JII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 05:08:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:44636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:08:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F081CB6EF;
        Wed, 30 Oct 2019 09:08:05 +0000 (UTC)
Date:   Wed, 30 Oct 2019 10:08:04 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pan Zhang <zhangpan26@huawei.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        hannes@cmpxchg.org, guro@fb.com, shakeelb@google.com,
        chris@chrisdown.name, yang.shi@linux.alibaba.com, tj@kernel.org,
        tglx@linutronix.de, hushiyuan@huawei.com, wuxu.wu@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix a typo of memcg annotation.
Message-ID: <20191030090804.GS31513@dhcp22.suse.cz>
References: <1572400917-28079-1-git-send-email-zhangpan26@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572400917-28079-1-git-send-email-zhangpan26@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-10-19 10:01:57, Pan Zhang wrote:
> There is a annotation forgot to follow the patchset of `Move LRU page reclaim from zones to nodes`.
> I corrected it to avoid misunderstanding.
> 
> Signed-off-by: Pan Zhang <zhangpan26@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index ae703ea..e211689 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -112,7 +112,7 @@ struct memcg_shrinker_map {
>  };
>  
>  /*
> - * per-zone information in memory controller.
> + * per-node information in memory controller.
>   */
>  struct mem_cgroup_per_node {
>  	struct lruvec		lruvec;
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
