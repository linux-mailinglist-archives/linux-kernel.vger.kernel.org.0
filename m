Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3827DC018
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 10:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407487AbfJRIiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 04:38:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405150AbfJRIiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:38:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1C20306A21B;
        Fri, 18 Oct 2019 08:38:23 +0000 (UTC)
Received: from [10.36.118.57] (unknown [10.36.118.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 526C15D713;
        Fri, 18 Oct 2019 08:38:22 +0000 (UTC)
Subject: Re: memory offline infinite loop after soft offline
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Qian Cai <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <1570829564.5937.36.camel@lca.pw>
 <20191014083914.GA317@dhcp22.suse.cz>
 <20191017093410.GA19973@hori.linux.bs1.fc.nec.co.jp>
 <20191017100106.GF24485@dhcp22.suse.cz> <1571335633.5937.69.camel@lca.pw>
 <20191017182759.GN24485@dhcp22.suse.cz>
 <20191018021906.GA24978@hori.linux.bs1.fc.nec.co.jp>
 <33946728-bdeb-494a-5db8-e279acebca47@redhat.com>
 <20191018082459.GE5017@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f065d998-7fa3-ef9a-c2f4-5b9116f5596b@redhat.com>
Date:   Fri, 18 Oct 2019 10:38:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018082459.GE5017@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 18 Oct 2019 08:38:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.19 10:24, Michal Hocko wrote:
> On Fri 18-10-19 10:13:36, David Hildenbrand wrote:
> [...]
>> However, if the compound page spans multiple pageblocks
> 
> Although hugetlb pages spanning pageblocks are possible this shouldn't
> matter in__test_page_isolated_in_pageblock because this function doesn't
> really operate on pageblocks as the name suggests.  It is simply
> traversing all valid RAM ranges (see walk_system_ram_range).

As long as the hugepages don't span memory blocks/sections, you are 
right. I have no experience with gigantic pages in this regard.

-- 

Thanks,

David / dhildenb
