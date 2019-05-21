Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02711254F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 18:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfEUQLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 12:11:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:47782 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728067AbfEUQLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:11:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D22D7ADE1;
        Tue, 21 May 2019 16:11:07 +0000 (UTC)
Date:   Tue, 21 May 2019 18:11:05 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: reorder memory-hotplug documentation
Message-ID: <20190521161101.GA2372@linux>
References: <1557822213-19058-1-git-send-email-rppt@linux.ibm.com>
 <43092504-a95f-374d-f3db-b961dd8ac428@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43092504-a95f-374d-f3db-b961dd8ac428@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 12:41:50PM +0200, David Hildenbrand wrote:
> > +Future Work
> > +===========
> > +
> > +  - allowing memory hot-add to ZONE_MOVABLE. maybe we need some switch like
> > +    sysctl or new control file.
> 
> ... that already works if I am not completely missing the point here

It does.

> > +  - support HugeTLB page migration and offlining.
> 
> ... I remember that Oscar was doing something in that area, Oscar?

Yes, in general offlinining on hugetlb pages was already working, but we did not
allow to offline 1GB-hugetlb pages on x86_64.
I removed that limitation with
("commit: 10eeadf3045c mm,memory_hotplug: unlock 1GB-hugetlb on x86_64") , so now
offlining on hugetlb pages should be fully operative.

> I'd vote for removing the future work part, this is pretty outdated.

Instead of removing it, I would rather make it consistent with the present.
E.g:

- Move page handling from memory-hotremove to offline stage
- Enable a way to allocate vmemmap pages from hot-added memory
etc.


-- 
Oscar Salvador
SUSE L3
