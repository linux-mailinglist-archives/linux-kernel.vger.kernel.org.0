Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 630686E754
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 16:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfGSO3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 10:29:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729465AbfGSO3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:29:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE41BB061;
        Fri, 19 Jul 2019 14:29:07 +0000 (UTC)
Date:   Fri, 19 Jul 2019 16:29:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v2 2/2] mm, slab: Show last shrink time in us when
 slab/shrink is read
Message-ID: <20190719142906.GU30461@dhcp22.suse.cz>
References: <20190717202413.13237-1-longman@redhat.com>
 <20190717202413.13237-3-longman@redhat.com>
 <20190719061410.GJ30461@dhcp22.suse.cz>
 <a0ea7cd2-d66c-f251-d14f-979e0913c7ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0ea7cd2-d66c-f251-d14f-979e0913c7ef@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-07-19 10:07:20, Waiman Long wrote:
> On 7/19/19 2:14 AM, Michal Hocko wrote:
> > On Wed 17-07-19 16:24:13, Waiman Long wrote:
> >> The show method of /sys/kernel/slab/<slab>/shrink sysfs file currently
> >> returns nothing. This is now modified to show the time of the last
> >> cache shrink operation in us.
> > Isn't this something that tracing can be used for without any kernel
> > modifications?
> 
> That is true, but it will be a bit more cumbersome to get the data.

I have no say for this code but if there is a way to capture timing data
I prefer to rely on the tracing infrastructure. If the current tooling
makes it cumbersome to get then this is a good reason to ask for a less
cumbersome way. On the other hand, if you somehow hardwire it to a user
visible interface then you just establish ABI which might stand in way
for potential/future development.

So take it as my 2c
-- 
Michal Hocko
SUSE Labs
