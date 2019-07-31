Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F047C1E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 14:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbfGaMoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 08:44:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:49526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728929AbfGaMoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:44:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC03AAFA4;
        Wed, 31 Jul 2019 12:44:01 +0000 (UTC)
Date:   Wed, 31 Jul 2019 14:43:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] drivers/base/memory.c: Don't store end_section_nr in
 memory blocks
Message-ID: <20190731124356.GL9330@dhcp22.suse.cz>
References: <20190731122213.13392-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731122213.13392-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-07-19 14:22:13, David Hildenbrand wrote:
> Each memory block spans the same amount of sections/pages/bytes. The size
> is determined before the first memory block is created. No need to store
> what we can easily calculate - and the calculations even look simpler now.

While this cleanup helps a bit, I am not sure this is really worth
bothering. I guess we can agree when I say that the memblock interface
is suboptimal (to put it mildly).  Shouldn't we strive for making it
a real hotplug API in the future? What do I mean by that? Why should
be any memblock fixed in size? Shouldn't we have use hotplugable units
instead (aka pfn range that userspace can work with sensibly)? Do we
know of any existing userspace that would depend on the current single
section res. 2GB sized memblocks?

All that being said, I do not oppose to the patch but can we start
thinking about the underlying memblock limitations rather than micro
cleanups?
-- 
Michal Hocko
SUSE Labs
