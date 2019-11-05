Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B548EF9D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 10:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfKEJpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 04:45:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:46040 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730454AbfKEJpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:45:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ECD27AEA1;
        Tue,  5 Nov 2019 09:45:19 +0000 (UTC)
Date:   Tue, 5 Nov 2019 10:45:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: update information for "MEMORY MANAGEMENT"
Message-ID: <20191105094518.GA25980@dhcp22.suse.cz>
References: <20191030202217.3498133-1-songliubraving@fb.com>
 <4e4ff9c9-064c-7515-41ea-9f20b9889e51@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e4ff9c9-064c-7515-41ea-9f20b9889e51@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-11-19 15:53:18, Vlastimil Babka wrote:
[...]
> (And obviously, could we finally get a real git? :)

I would love to see that happen! While I do appreciate existance of
Johannes' mirror that is not something that is suitable for a long term
development IMHO because the tree rebases constantly.

And while we are talking about a better information on the MM
maintainership, should we also be explicit about maintainers of MM parts
which have a primary go to person? At least compaction, allocator, OOM,
memory hotplug, THP, shmem, memory hwpoisoning, early allocators come to
mind.
-- 
Michal Hocko
SUSE Labs
