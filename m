Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1EC3D7855
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbfJOOXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 10:23:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:50528 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732050AbfJOOXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:23:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D9BBB2EA;
        Tue, 15 Oct 2019 14:23:47 +0000 (UTC)
Date:   Tue, 15 Oct 2019 16:23:44 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>
Subject: Re: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized
 memmaps in memory_failure()
Message-ID: <20191015142340.GA5686@linux>
References: <20191009142435.3975-1-david@redhat.com>
 <20191009142435.3975-3-david@redhat.com>
 <20191009144323.GH6681@dhcp22.suse.cz>
 <5a626821-77e9-e26b-c2ee-219670283bf0@redhat.com>
 <20191010073526.GC18412@dhcp22.suse.cz>
 <18383432-c74a-9ce5-a3c6-1e57d54cb629@redhat.com>
 <52e81b85-c460-5b99-a297-e065caab3a16@redhat.com>
 <20191011060249.GA30500@hori.linux.bs1.fc.nec.co.jp>
 <3706d642-6c29-41b8-a676-1b5541af3169@redhat.com>
 <20191014133617.GJ317@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014133617.GJ317@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 03:36:17PM +0200, Michal Hocko wrote:
> I do agree. The two should be really using the same code. My
> understanding was that MADV_HWPOISON was there to test the actual MCE
> behavior (and the man page seems to agree with that).
> 
> Oscar is working on a rewrite. Not sure he has considered this as well.

Yeah, I came across hwpoison-inject module when doing my re-write,
and I felt like this is begging for a clean up.

Since unpoison_memory needs some adjustments after my re-write, I will go ahead
and clean that up, otherwise it will be inconsistent.

I expect to be ready fo send the v2 by the end of this week.

Thanks
-- 
Oscar Salvador
SUSE L3
