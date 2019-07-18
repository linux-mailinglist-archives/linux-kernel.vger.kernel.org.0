Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE856D171
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 17:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfGRP5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 11:57:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:34660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbfGRP5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:57:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 438B1AF6B;
        Thu, 18 Jul 2019 15:57:06 +0000 (UTC)
Date:   Thu, 18 Jul 2019 17:57:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/1] mm/memory_hotplug: Adds option to hot-add memory in
 ZONE_MOVABLE
Message-ID: <20190718155704.GD30461@dhcp22.suse.cz>
References: <20190718024133.3873-1-leonardo@linux.ibm.com>
 <1563430353.3077.1.camel@suse.de>
 <0e67afe465cbbdf6ec9b122f596910cae77bc734.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e67afe465cbbdf6ec9b122f596910cae77bc734.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-07-19 12:50:29, Leonardo Bras wrote:
> On Thu, 2019-07-18 at 08:12 +0200, Oscar Salvador wrote:
> > We do already have "movable_node" boot option, which exactly has that
> > effect.
> > Any hotplugged range will be placed in ZONE_MOVABLE.
> Oh, I was not aware of it.
> 
> > Why do we need yet another option to achieve the same? Was not that
> > enough for your case?
> Well, another use of this config could be doing this boot option a
> default on any given kernel. 
> But in the above case I agree it would be wiser to add the code on
> movable_node_is_enabled() directly, and not where I did put.
> 
> What do you think about it?

No further config options please. We do have means a more flexible way
to achieve movable node onlining so let's use it. Or could you be more
specific about cases which cannot use the command line option and really
need a config option to workaround that?
-- 
Michal Hocko
SUSE Labs
