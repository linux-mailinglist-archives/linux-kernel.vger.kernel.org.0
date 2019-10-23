Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4615FE1BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 15:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405221AbfJWNNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 09:13:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:34248 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732284AbfJWNNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:13:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0658B1BD;
        Wed, 23 Oct 2019 13:13:03 +0000 (UTC)
Date:   Wed, 23 Oct 2019 14:13:01 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 1/2] mm, vmstat: hide /proc/pagetypeinfo from normal
 users
Message-ID: <20191023131301.GB28938@suse.de>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
 <20191023102737.32274-2-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191023102737.32274-2-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:27:36PM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> /proc/pagetypeinfo is a debugging tool to examine internal page
> allocator state wrt to fragmentation. It is not very useful for
> any other use so normal users really do not need to read this file.
> 
> Waiman Long has noticed that reading this file can have negative side
> effects because zone->lock is necessary for gathering data and that
> a) interferes with the page allocator and its users and b) can lead to
> hard lockups on large machines which have very long free_list.
> 
> Reduce both issues by simply not exporting the file to regular users.
> 
> Reported-by: Waiman Long <longman@redhat.com>
> Cc: stable
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
