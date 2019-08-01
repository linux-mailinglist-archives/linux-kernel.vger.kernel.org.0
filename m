Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3C07D679
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 09:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfHAHkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 03:40:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:59984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbfHAHkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:40:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55B34B11C;
        Thu,  1 Aug 2019 07:40:09 +0000 (UTC)
Date:   Thu, 1 Aug 2019 09:39:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Rashmica Gupta <rashmica.g@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        pasha.tatashin@soleen.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Allocate memmap from hotadded memory
Message-ID: <20190801073957.GH11627@dhcp22.suse.cz>
References: <9143f64391d11aa0f1988e78be9de7ff56e4b30b.camel@gmail.com>
 <20190702074806.GA26836@linux>
 <CAC6rBskRyh5Tj9L-6T4dTgA18H0Y8GsMdC-X5_0Jh1SVfLLYtg@mail.gmail.com>
 <20190731120859.GJ9330@dhcp22.suse.cz>
 <4ddee0dd719abd50350f997b8089fa26f6004c0c.camel@gmail.com>
 <20190801071709.GE11627@dhcp22.suse.cz>
 <9bcbd574-7e23-5cfe-f633-646a085f935a@redhat.com>
 <20190801072430.GF11627@dhcp22.suse.cz>
 <e654aa97-6ab1-4069-60e6-fc099539729e@redhat.com>
 <5e6137c9-5269-5756-beaa-d116652be8b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e6137c9-5269-5756-beaa-d116652be8b9@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-08-19 09:31:09, David Hildenbrand wrote:
> On 01.08.19 09:26, David Hildenbrand wrote:
[...]
> > I am not sure about the implications of having
> > pfn_valid()/pfn_present()/pfn_online() return true but accessing it
> > results in crashes. (suspend, kdump, whatever other technology touches
> > online memory)
> 
> (oneidea: we could of course go ahead and mark the pages PG_offline
> before unmapping the pfn range to work around these issues)

PG_reserved and an elevated reference count should be enough to drive
any pfn walker out. Pfn walkers shouldn't touch any page unless they
know and recognize their type.
-- 
Michal Hocko
SUSE Labs
