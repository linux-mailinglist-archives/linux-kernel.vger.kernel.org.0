Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7F6950C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 00:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfHSW1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 18:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbfHSW1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:27:45 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95CBF22CE8;
        Mon, 19 Aug 2019 22:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566253664;
        bh=amjQuu+FazRVtx1TJBC7GqpU3maEAdLeUfc01ZumRPo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o6MCUhy7QJ3Bbjhe9x4pf0tlbsmdfKV1eSzvmkAEpz6VLHPhG6Muh4rMiUyp1GPcp
         9WMO1J75H8UuEqSj/wDoi+57MWtZjxUUBaEJIcTMg996WHcAQ6VNKoqheVSSjoGGJ4
         VRlwyob/PbcNFAn1RbvBVA+MLdCMeNbTaCBrcApI=
Date:   Mon, 19 Aug 2019 15:27:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v2 2/3] mm: memcontrol: flush percpu slab vmstats on
 kmem offlining
Message-Id: <20190819152744.4ab8478cfb8697856408425b@linux-foundation.org>
In-Reply-To: <20190819202338.363363-3-guro@fb.com>
References: <20190819202338.363363-1-guro@fb.com>
        <20190819202338.363363-3-guro@fb.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 13:23:37 -0700 Roman Gushchin <guro@fb.com> wrote:

> I've noticed that the "slab" value in memory.stat is sometimes 0,
> even if some children memory cgroups have a non-zero "slab" value.
> The following investigation showed that this is the result
> of the kmem_cache reparenting in combination with the per-cpu
> batching of slab vmstats.
> 
> At the offlining some vmstat value may leave in the percpu cache,
> not being propagated upwards by the cgroup hierarchy. It means
> that stats on ancestor levels are lower than actual. Later when
> slab pages are released, the precise number of pages is substracted
> on the parent level, making the value negative. We don't show negative
> values, 0 is printed instead.
> 
> To fix this issue, let's flush percpu slab memcg and lruvec stats
> on memcg offlining. This guarantees that numbers on all ancestor
> levels are accurate and match the actual number of outstanding
> slab pages.
> 
> Fixes: fb2f2b0adb98 ("mm: memcg/slab: reparent memcg kmem_caches on cgroup removal")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>

[1/3] and [3/3] have cc:stable.  [2/3] does not.  However [3/3] does
not correctly apply without [2/3] having being applied.

