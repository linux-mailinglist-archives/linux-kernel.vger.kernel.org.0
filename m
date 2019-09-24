Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD29DBC717
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 13:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504793AbfIXLpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 07:45:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:60158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504767AbfIXLpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:45:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0DBEB033;
        Tue, 24 Sep 2019 11:45:04 +0000 (UTC)
Date:   Tue, 24 Sep 2019 13:45:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alastair D'Silva <alastair@d-silva.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] memory_hotplug: Add a bounds check to
 check_hotplug_memory_range()
Message-ID: <20190924114503.GK23050@dhcp22.suse.cz>
References: <20190917010752.28395-1-alastair@au1.ibm.com>
 <20190917010752.28395-2-alastair@au1.ibm.com>
 <20190923122513.GO6016@dhcp22.suse.cz>
 <25e0af4cb24a41466032d704b89d25559e7ad968.camel@d-silva.org>
 <20190924090934.GF23050@dhcp22.suse.cz>
 <32531671-77dd-7857-f34f-f73ea45f7e22@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32531671-77dd-7857-f34f-f73ea45f7e22@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-09-19 11:13:31, David Hildenbrand wrote:
> On 24.09.19 11:09, Michal Hocko wrote:
> > On Tue 24-09-19 11:31:05, Alastair D'Silva wrote:
> >> On Mon, 2019-09-23 at 14:25 +0200, Michal Hocko wrote:
[...]
> >>> This will result in a silent failure (unlike misaligned case). Is
> >>> this
> >>> what we want?
> >>
> >> Good point - I guess it comes down to, is there anything we expect an
> >> end user to do about it? I'm not sure there is, in which case the bad
> >> RC, which is reported up every call chain that I can see, should be
> >> sufficient.
> > 
> > It seems like a clear HW/platform bug to me. And that should better be
> > reported loudly to the log to make sure people do complain to their FW
> > friends and have it fixed.
> > 
> 
> I don't agree in virtual environment. On s390x, MAX_PHYSMEM_BITS is
> configurable. For example, if you have paravirtualized memory hotplug
> (e.g., virtio-mem), you could add memory to the system that violates
> this constraint.

What happens if that is the case. Does the machine change the
configuration in runtime or it needs a reboot?

Anyway, seeing this to be the case in the log would help in whatever
action is necessary to deal with the issue, right?
-- 
Michal Hocko
SUSE Labs
