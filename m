Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D7AEF5E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 08:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbfKEHBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 02:01:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:49548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387517AbfKEHBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:01:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88710AD35;
        Tue,  5 Nov 2019 07:01:43 +0000 (UTC)
Date:   Tue, 5 Nov 2019 08:01:41 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, yuqi jin <jinyuqi@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2] lib: optimize cpumask_local_spread()
Message-ID: <20191105070141.GF22672@dhcp22.suse.cz>
References: <1572863268-28585-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572863268-28585-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-11-19 18:27:48, Shaokun Zhang wrote:
> From: yuqi jin <jinyuqi@huawei.com>
> 
> In the multi-processor and NUMA system, I/O device may have many numa
> nodes belonging to multiple cpus. When we get a local numa, it is
> better to find the node closest to the local numa node, instead
> of choosing any online cpu immediately.
> 
> For the current code, it only considers the local NUMA node and it
> doesn't compute the distances between different NUMA nodes for the
> non-local NUMA nodes. Let's optimize it and find the nearest node
> through NUMA distance. The performance will be better if it return
> the nearest node than the random node.

Numbers please

[...]
> +/**
> + * cpumask_local_spread - select the i'th cpu with local numa cpu's first
> + * @i: index number
> + * @node: local numa_node
> + *
> + * This function selects an online CPU according to a numa aware policy;
> + * local cpus are returned first, followed by the nearest non-local ones,
> + * then it wraps around.
> + *
> + * It's not very efficient, but useful for setup.
> + */
> +unsigned int cpumask_local_spread(unsigned int i, int node)
> +{
> +	int node_dist[MAX_NUMNODES] = {0};
> +	bool used[MAX_NUMNODES] = {0};

Ugh. This might be a lot of stack space. Some distro kernels use large
NODE_SHIFT (e.g 10 so this would be 4kB of stack space just for the
node_dist).

> +	int cpu, j, id;
-- 
Michal Hocko
SUSE Labs
