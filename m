Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 582C6142CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 15:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgATOOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 09:14:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60893 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbgATOOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579529641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=hO6n5NzJdPtqLw8Nl0EBPTz7Df5HPZ6HbyJsYMSOIEg=;
        b=eS0DBYdfWoyjkAkdAYtZgXa7Eld1deKrKi42/thxSKN6L7wVNUB+IUB1OBpAnX3YRdWCbe
        cHGK2I+paXkymcztsyob6mu2shmAnXsmpcmcUUtvbKbH7m9QN9XdQL0I8bAKP9SgJqyIMA
        qSKlWfbDFyEFTqEy2gFNskmZ6s7nZBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-eutsiOH2NUu5vBA2Id-gzw-1; Mon, 20 Jan 2020 09:13:57 -0500
X-MC-Unique: eutsiOH2NUu5vBA2Id-gzw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B49018010C4;
        Mon, 20 Jan 2020 14:13:56 +0000 (UTC)
Received: from [10.36.118.34] (unknown [10.36.118.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CC6610027A3;
        Mon, 20 Jan 2020 14:13:55 +0000 (UTC)
Subject: Re: [PATCH -mm v2] mm/page_isolation: fix potential warning from user
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200120131909.813-1-cai@lca.pw>
 <8c56268d-9b8a-f62e-eca9-7707852a2aaf@redhat.com>
 <ba3215a2-d616-c636-e70d-99bb8f504292@redhat.com>
 <96675869-3815-4E98-8492-1D84F5B42AED@lca.pw>
 <74aebdfe-e727-acd6-e664-6e63948a68ae@redhat.com>
 <F8997A77-7F52-4C0C-8045-F39C57B4CC74@lca.pw>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <aa5f235e-6449-1531-1355-6974f3d38740@redhat.com>
Date:   Mon, 20 Jan 2020 15:13:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <F8997A77-7F52-4C0C-8045-F39C57B4CC74@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.20 15:11, Qian Cai wrote:
>=20
>=20
>> On Jan 20, 2020, at 9:01 AM, David Hildenbrand <david@redhat.com> wrot=
e:
>>
>> On 20.01.20 14:56, Qian Cai wrote:
>>>
>>>
>>>> On Jan 20, 2020, at 8:38 AM, David Hildenbrand <david@redhat.com> wr=
ote:
>>>>
>>>> On 20.01.20 14:30, David Hildenbrand wrote:
>>>>> On 20.01.20 14:19, Qian Cai wrote:
>>>>>> It makes sense to call the WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE=
_MOVABLE)
>>>>>> from start_isolate_page_range(), but should avoid triggering it fr=
om
>>>>>> userspace, i.e, from is_mem_section_removable() because it could b=
e a
>>>>>> DoS if warn_on_panic is set.
>>>>>>
>>>>>> While at it, simplify the code a bit by removing an unnecessary ju=
mp
>>>>>> label and a local variable, so set_migratetype_isolate() could rea=
lly
>>>>>> return a bool.
>>>>>>
>>>>>> Suggested-by: Michal Hocko <mhocko@kernel.org>
>>>>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>>>>> ---
>>>>>>
>>>>>> v2: Improve the commit log.
>>>>>>   Warn for all start_isolate_page_range() users not just offlining=
.
>>>>>>
>>>>>> mm/page_alloc.c     | 11 ++++-------
>>>>>> mm/page_isolation.c | 30 +++++++++++++++++-------------
>>>>>> 2 files changed, 21 insertions(+), 20 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>> index 621716a25639..3c4eb750a199 100644
>>>>>> --- a/mm/page_alloc.c
>>>>>> +++ b/mm/page_alloc.c
>>>>>> @@ -8231,7 +8231,7 @@ struct page *has_unmovable_pages(struct zone=
 *zone, struct page *page,
>>>>>> 		if (is_migrate_cma(migratetype))
>>>>>> 			return NULL;
>>>>>>
>>>>>> -		goto unmovable;
>>>>>> +		return page;
>>>>>> 	}
>>>>>>
>>>>>> 	for (; iter < pageblock_nr_pages; iter++) {
>>>>>> @@ -8241,7 +8241,7 @@ struct page *has_unmovable_pages(struct zone=
 *zone, struct page *page,
>>>>>> 		page =3D pfn_to_page(pfn + iter);
>>>>>>
>>>>>> 		if (PageReserved(page))
>>>>>> -			goto unmovable;
>>>>>> +			return page;
>>>>>>
>>>>>> 		/*
>>>>>> 		 * If the zone is movable and we have ruled out all reserved
>>>>>> @@ -8261,7 +8261,7 @@ struct page *has_unmovable_pages(struct zone=
 *zone, struct page *page,
>>>>>> 			unsigned int skip_pages;
>>>>>>
>>>>>> 			if (!hugepage_migration_supported(page_hstate(head)))
>>>>>> -				goto unmovable;
>>>>>> +				return page;
>>>>>>
>>>>>> 			skip_pages =3D compound_nr(head) - (page - head);
>>>>>> 			iter +=3D skip_pages - 1;
>>>>>> @@ -8303,12 +8303,9 @@ struct page *has_unmovable_pages(struct zon=
e *zone, struct page *page,
>>>>>> 		 * is set to both of a memory hole page and a _used_ kernel
>>>>>> 		 * page at boot.
>>>>>> 		 */
>>>>>> -		goto unmovable;
>>>>>> +		return page;
>>>>>> 	}
>>>>>> 	return NULL;
>>>>>> -unmovable:
>>>>>> -	WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
>>>>>> -	return pfn_to_page(pfn + iter);
>>>>>> }
>>>>>>
>>>>>> #ifdef CONFIG_CONTIG_ALLOC
>>>>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>>>>> index e70586523ca3..31f5516f5d54 100644
>>>>>> --- a/mm/page_isolation.c
>>>>>> +++ b/mm/page_isolation.c
>>>>>> @@ -15,12 +15,12 @@
>>>>>> #define CREATE_TRACE_POINTS
>>>>>> #include <trace/events/page_isolation.h>
>>>>>>
>>>>>> -static int set_migratetype_isolate(struct page *page, int migrate=
type, int isol_flags)
>>>>>> +static bool set_migratetype_isolate(struct page *page, int migrat=
etype,
>>>>>> +				    int isol_flags)
>>>>>
>>>>> Why this change?
>>>>>
>>>>>> {
>>>>>> -	struct page *unmovable =3D NULL;
>>>>>> +	struct page *unmovable =3D ERR_PTR(-EBUSY);
>>>>>
>>>>> Also, why this change?
>>>>>
>>>>>> 	struct zone *zone;
>>>>>> 	unsigned long flags;
>>>>>> -	int ret =3D -EBUSY;
>>>>>>
>>>>>> 	zone =3D page_zone(page);
>>>>>>
>>>>>> @@ -49,21 +49,25 @@ static int set_migratetype_isolate(struct page=
 *page, int migratetype, int isol_
>>>>>> 									NULL);
>>>>>>
>>>>>> 		__mod_zone_freepage_state(zone, -nr_pages, mt);
>>>>>> -		ret =3D 0;
>>>>>> 	}
>>>>>>
>>>>>> out:
>>>>>> 	spin_unlock_irqrestore(&zone->lock, flags);
>>>>>> -	if (!ret)
>>>>>> +
>>>>>> +	if (!unmovable) {
>>>>>> 		drain_all_pages(zone);
>>>>>> -	else if ((isol_flags & REPORT_FAILURE) && unmovable)
>>>>>> -		/*
>>>>>> -		 * printk() with zone->lock held will guarantee to trigger a
>>>>>> -		 * lockdep splat, so defer it here.
>>>>>> -		 */
>>>>>> -		dump_page(unmovable, "unmovable page");
>>>>>> -
>>>>>> -	return ret;
>>>>>> +	} else {
>>>>>> +		WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
>>>>>> +
>>>>>> +		if ((isol_flags & REPORT_FAILURE) && !IS_ERR(unmovable))
>>>>>> +			/*
>>>>>
>>>>> Why this change? (!IS_ERR)
>>>>>
>>>>>
>>>>> Some things here look unrelated - or I am missing something :)
>>>>>
>>>>
>>>> FWIW, I'd prefer this change without any such cleanups (e.g., I don'=
t
>>>> like returning a bool from this function and the IS_ERR handling, ma=
kes
>>>> the function harder to read than before)
>>>
>>> What is Michal or Andrew=E2=80=99s opinion? BTW, a bonus point to ret=
urn a bool
>>> is that it helps the code robustness in general, as UBSAN will be abl=
e to
>>> catch any abuse.
>>>
>>
>> A return type of bool on a function that does not test a property
>> ("has_...", "is"...") is IMHO confusing.
>=20
> That is fine. It could be renamed to set_migratetype_is_isolate() or
> is_set_migratetype_isolate() which seems pretty minor because we
> have no consistency in the naming of this in linux kernel at all, i.e.,
> many existing bool function names without those test of properties.=20

It does not query a property, so "is_set_migratetype_isolate()" is plain
wrong.

Anyhow, Michal does not seem to care.

--=20
Thanks,

David / dhildenb

