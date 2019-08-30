Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1738A2F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 08:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfH3GBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 02:01:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:57742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbfH3GBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:01:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4AB4B682;
        Fri, 30 Aug 2019 06:01:01 +0000 (UTC)
Date:   Fri, 30 Aug 2019 08:01:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v2 3/6] mm/memory_hotplug: Process all zones when
 removing memory
Message-ID: <20190830060100.GP28313@dhcp22.suse.cz>
References: <20190826101012.10575-1-david@redhat.com>
 <20190826101012.10575-4-david@redhat.com>
 <20190829153936.GJ28313@dhcp22.suse.cz>
 <c01ceaab-4032-49cd-3888-45838cb46e11@redhat.com>
 <20190829162704.GL28313@dhcp22.suse.cz>
 <b5a9f070-b43a-c21d-081b-9926b2007f5c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5a9f070-b43a-c21d-081b-9926b2007f5c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29-08-19 18:59:31, David Hildenbrand wrote:
> On 29.08.19 18:27, Michal Hocko wrote:
[...]
> > No rush, really... It seems this is quite unlikely event as most hotplug
> > usecases simply online memory before removing it later on.
> > 
> 
> I can trigger it reliably right now while working/testing virtio-mem, so
> I finally want to clean up this mess :) (has been on my list for a long
> time). I'll try to hunt for the right commit id's that broke it.

f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to
zones until online")

-- 
Michal Hocko
SUSE Labs
