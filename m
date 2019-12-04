Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42580112D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 15:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfLDOhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 09:37:05 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:40824 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfLDOhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 09:37:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 720543F4CF;
        Wed,  4 Dec 2019 15:37:03 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=nYyXuGow;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sRSZ8Ap_cuBZ; Wed,  4 Dec 2019 15:37:02 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 6356F3F47A;
        Wed,  4 Dec 2019 15:36:58 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 8EFC2360608;
        Wed,  4 Dec 2019 15:36:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1575470218; bh=TGnqQTPAKnacfdO2ZsLhS8SGD7K1wjqKiMBUEZMkVog=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nYyXuGow8yhW6nhPRKfXD1yrFTQfuF/NJtNJZeZI6ZT+BwxjAWGpPuqt5ljBjElIj
         ZixSoo7Z3EDNcj8ytbLiMlZgbLW/dggtICmzzvrwXZWmR6cAbBI/116NAG1712YOXP
         kCZ9E0laek7wL2eW5OKrMfFYYwWgkjhpvgBF87T8=
Subject: Re: [PATCH v2 2/2] drm/ttm: Fix vm page protection handling
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20191203104853.4378-1-thomas_os@shipmail.org>
 <20191203104853.4378-3-thomas_os@shipmail.org>
 <20191204135219.GH25242@dhcp22.suse.cz>
 <b29b166c-e9fe-f829-f533-b39f98b334a9@shipmail.org>
 <20191204143521.GJ25242@dhcp22.suse.cz>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <5c2658b6-b5ec-5747-c360-fada54d759ed@shipmail.org>
Date:   Wed, 4 Dec 2019 15:36:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191204143521.GJ25242@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/19 3:35 PM, Michal Hocko wrote:
> On Wed 04-12-19 15:16:09, Thomas Hellström (VMware) wrote:
>> On 12/4/19 2:52 PM, Michal Hocko wrote:
>>> On Tue 03-12-19 11:48:53, Thomas Hellström (VMware) wrote:
>>>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>>>
>>>> TTM graphics buffer objects may, transparently to user-space,  move
>>>> between IO and system memory. When that happens, all PTEs pointing to the
>>>> old location are zapped before the move and then faulted in again if
>>>> needed. When that happens, the page protection caching mode- and
>>>> encryption bits may change and be different from those of
>>>> struct vm_area_struct::vm_page_prot.
>>>>
>>>> We were using an ugly hack to set the page protection correctly.
>>>> Fix that and instead use vmf_insert_mixed_prot() and / or
>>>> vmf_insert_pfn_prot().
>>>> Also get the default page protection from
>>>> struct vm_area_struct::vm_page_prot rather than using vm_get_page_prot().
>>>> This way we catch modifications done by the vm system for drivers that
>>>> want write-notification.
>>> So essentially this should have any new side effect on functionality it
>>> is just making a hacky/ugly code less so?
>> Functionality is unchanged. The use of a on-stack vma copy was severely
>> frowned upon in an earlier thread, which also points to another similar
>> example using vmf_insert_pfn_prot().
>>
>> https://lore.kernel.org/lkml/20190905103541.4161-2-thomas_os@shipmail.org/
>>
>>> In other words what are the
>>> consequences of having page protection inconsistent from vma's?
>> During the years, it looks like the caching- and encryption flags of
>> vma::vm_page_prot have been largely removed from usage. From what I can
>> tell, there are no more places left that can affect TTM. We discussed
>> __split_huge_pmd_locked() towards the end of that thread, but that doesn't
>> affect TTM even with huge page-table entries.
> Please state all those details/assumptions you are operating on in the
> changelog.

Thanks. I'll update the patchset and add that.

/Thomas



