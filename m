Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6104D7C50D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 16:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfGaOhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 10:37:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:56350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728304AbfGaOhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:37:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5D3EAC9A;
        Wed, 31 Jul 2019 14:37:14 +0000 (UTC)
Date:   Wed, 31 Jul 2019 16:37:14 +0200
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
Message-ID: <20190731143714.GX9330@dhcp22.suse.cz>
References: <20190731122213.13392-1-david@redhat.com>
 <20190731124356.GL9330@dhcp22.suse.cz>
 <f0894c30-105a-2241-a505-7436bc15b864@redhat.com>
 <20190731132534.GQ9330@dhcp22.suse.cz>
 <58bd9479-051b-a13b-b6d0-c93aac2ed1b3@redhat.com>
 <20190731141411.GU9330@dhcp22.suse.cz>
 <c92a4d6f-b0f2-e080-5157-b90ab61a8c49@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c92a4d6f-b0f2-e080-5157-b90ab61a8c49@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-07-19 16:21:46, David Hildenbrand wrote:
[...]
> > Thinking about it some more, I believe that we can reasonably provide
> > both APIs controlable by a command line parameter for backwards
> > compatibility. It is the hotplug code to control sysfs APIs.  E.g.
> > create one sysfs entry per add_memory_resource for the new semantic.
> 
> Yeah, but the real question is: who needs it. I can only think about
> some DIMM scenarios (some, not all). I would be interested in more use
> cases. Of course, to provide and maintain two APIs we need a good reason.

Well, my 3TB machine that has 7 movable nodes could really go with less
than
$ find /sys/devices/system/memory -name "memory*" | wc -l
1729

when it doesn't really make any sense to offline less than a
hotremovable entity which is the whole node effectivelly. I have seen
reports where a similarly large machine chocked on boot just because of
too many udev events...

In other words allowing smaller granularity is a nice toy but real
usecases usually work with the whole hotplugable entity (e.g. the whole
ACPI container).

> (one sysfs per add_memory_resource() won't cover all DIMMs completely as
> far as I remember - I might be wrong, I remember there could be a
> sequence of add_memory(). Also, some DIMMs might actually overlap with
> memory indicated during boot - complicated stuff)

Which is something we have to live with anyway due to nodes interleaving.
So nothing really new.
-- 
Michal Hocko
SUSE Labs
