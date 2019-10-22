Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D446E051B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 15:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbfJVNbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 09:31:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:43230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbfJVNbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:31:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53E02B13E;
        Tue, 22 Oct 2019 13:31:49 +0000 (UTC)
Date:   Tue, 22 Oct 2019 15:31:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 00/16] The new slab memory controller
Message-ID: <20191022133148.GP9379@dhcp22.suse.cz>
References: <20191018002820.307763-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018002820.307763-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-10-19 17:28:04, Roman Gushchin wrote:
> This patchset provides a new implementation of the slab memory controller,
> which aims to reach a much better slab utilization by sharing slab pages
> between multiple memory cgroups. Below is the short description of the new
> design (more details in commit messages).
> 
> Accounting is performed per-object instead of per-page. Slab-related
> vmstat counters are converted to bytes. Charging is performed on page-basis,
> with rounding up and remembering leftovers.
> 
> Memcg ownership data is stored in a per-slab-page vector: for each slab page
> a vector of corresponding size is allocated. To keep slab memory reparenting
> working, instead of saving a pointer to the memory cgroup directly an
> intermediate object is used. It's simply a pointer to a memcg (which can be
> easily changed to the parent) with a built-in reference counter. This scheme
> allows to reparent all allocated objects without walking them over and changing
> memcg pointer to the parent.
> 
> Instead of creating an individual set of kmem_caches for each memory cgroup,
> two global sets are used: the root set for non-accounted and root-cgroup
> allocations and the second set for all other allocations. This allows to
> simplify the lifetime management of individual kmem_caches: they are destroyed
> with root counterparts. It allows to remove a good amount of code and make
> things generally simpler.

What is the performance impact? Also what is the effect on the memory
reclaim side and the isolation. I would expect that mixing objects from
different cgroups would have a negative/unpredictable impact on the
memcg slab shrinking.
-- 
Michal Hocko
SUSE Labs
