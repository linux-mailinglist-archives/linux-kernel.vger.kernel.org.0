Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8FBE103DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 16:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfKTPHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 10:07:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28534 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728030AbfKTPHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574262464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RS+VS6+VndfQJGXWe/7Ur59ibSDGXzjQ1GUOas4J9/8=;
        b=D78nf+ZmPGolr7zt9N2zYNx1q65dyCArgdB0KUA0vPq6B44umbxWS/ZuXz7l+bUuEuAWfa
        4iUliInJjDmb0eoUtMq9LnU43P4PDMad4oFfbTSMza4/rGi9t0TJDGSxSSQueCmZAFTs+D
        D33lbwk+I3i14okoUGrU9qXpD3thzII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-HQxnyN-UOZGfTcFCx1clEA-1; Wed, 20 Nov 2019 10:07:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C5CC1093977;
        Wed, 20 Nov 2019 15:07:40 +0000 (UTC)
Received: from [10.36.118.126] (unknown [10.36.118.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08EF86E704;
        Wed, 20 Nov 2019 15:07:38 +0000 (UTC)
Subject: Re: [PATCH 2/2] mm/memory-failure.c: not necessary to recalculate
 hpage
To:     Wei Yang <richardw.yang@linux.intel.com>,
        n-horiguchi@ah.jp.nec.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20191118082003.26240-1-richardw.yang@linux.intel.com>
 <20191118082003.26240-2-richardw.yang@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <fdba31c8-d0c0-83a8-62d1-c04c1e894218@redhat.com>
Date:   Wed, 20 Nov 2019 16:07:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191118082003.26240-2-richardw.yang@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: HQxnyN-UOZGfTcFCx1clEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.19 09:20, Wei Yang wrote:
> hpage is not changed.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>   mm/memory-failure.c | 1 -
>   1 file changed, 1 deletion(-)
>=20
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 392ac277b17d..9784f4339ae7 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1319,7 +1319,6 @@ int memory_failure(unsigned long pfn, int flags)
>   =09=09}
>   =09=09unlock_page(p);
>   =09=09VM_BUG_ON_PAGE(!page_count(p), p);
> -=09=09hpage =3D compound_head(p);
>   =09}
>  =20
>   =09/*
>=20

I am *absolutely* no transparent huge page expert (sorry :) ), but won't=20
the split_huge_page(p) eventually split the compound page, such that=20
compound_head(p) will return something else after that call?

--=20

Thanks,

David / dhildenb

