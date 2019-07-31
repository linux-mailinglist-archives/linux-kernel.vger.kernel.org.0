Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59AC07C499
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 16:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfGaOON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 10:14:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:49676 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727318AbfGaOOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:14:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B7F4DAB9B;
        Wed, 31 Jul 2019 14:14:11 +0000 (UTC)
Date:   Wed, 31 Jul 2019 16:14:11 +0200
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
Message-ID: <20190731141411.GU9330@dhcp22.suse.cz>
References: <20190731122213.13392-1-david@redhat.com>
 <20190731124356.GL9330@dhcp22.suse.cz>
 <f0894c30-105a-2241-a505-7436bc15b864@redhat.com>
 <20190731132534.GQ9330@dhcp22.suse.cz>
 <58bd9479-051b-a13b-b6d0-c93aac2ed1b3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58bd9479-051b-a13b-b6d0-c93aac2ed1b3@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-07-19 15:42:53, David Hildenbrand wrote:
> On 31.07.19 15:25, Michal Hocko wrote:
[...]
> > I know we have documented this as an ABI and it is really _sad_ that
> > this ABI didn't get through normal scrutiny any user visible interface
> > should go through but these are sins of the past...
> 
> A quick google search indicates that
> 
> Kata containers queries the block size:
> https://github.com/kata-containers/runtime/issues/796
> 
> Powerpc userspace queries it:
> https://groups.google.com/forum/#!msg/powerpc-utils-devel/dKjZCqpTxus/AwkstV2ABwAJ
> 
> I can imagine that ppc dynamic memory onlines only pieces of added
> memory - DIMMs AFAIK (haven't looked at the details).
> 
> There might be more users.

Thanks! I suspect most of them are just using the information because
they do not have anything better.

Thinking about it some more, I believe that we can reasonably provide
both APIs controlable by a command line parameter for backwards
compatibility. It is the hotplug code to control sysfs APIs.  E.g.
create one sysfs entry per add_memory_resource for the new semantic.

It is some time since I've checked the ACPI side of the matter but that
code shouldn't really depend on a particular size of the memblock
either when trigerring udev events. I might be wrong here of course.
-- 
Michal Hocko
SUSE Labs
