Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85B31E0A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 19:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbfJVRGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 13:06:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:60626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732371AbfJVRG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:06:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51FB8B88E;
        Tue, 22 Oct 2019 17:06:28 +0000 (UTC)
Date:   Tue, 22 Oct 2019 19:06:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, guro@fb.com,
        shakeelb@google.com, chris@chrisdown.name,
        yang.shi@linux.alibaba.com, tj@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix comments based on per-node memcg
Message-ID: <20191022170627.GV9379@dhcp22.suse.cz>
References: <20191022150618.GA15519@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022150618.GA15519@haolee.github.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 15:06:18, Hao Lee wrote:
> These comments should be updated as memcg limit enforcement has been moved
> from zones to nodes.
> 
> Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index ae703ea3ef48..12c29f74c02a 100644
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
> @@ -399,8 +399,7 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
>   * @memcg: memcg of the wanted lruvec
>   *
>   * Returns the lru list vector holding pages for a given @node or a given
> - * @memcg and @zone. This can be the node lruvec, if the memory controller
> - * is disabled.
> + * @memcg. This can be the node lruvec, if the memory controller is disabled.
>   */
>  static inline struct lruvec *mem_cgroup_lruvec(struct pglist_data *pgdat,
>  				struct mem_cgroup *memcg)
> -- 
> 2.14.5

-- 
Michal Hocko
SUSE Labs
