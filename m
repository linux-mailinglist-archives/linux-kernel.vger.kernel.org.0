Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B555CE377B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 18:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436699AbfJXQKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 12:10:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58844 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2436636AbfJXQKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571933425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e36bYgYxzu96VpgkIyu2LKZbHdlezcwFd45XXmtDKSI=;
        b=DvTRy4gkWuC8ctfrEHAKv/ZHn6K+4FWcH2mgs/6cYA+MxiOBH8wHI55peeFvmPMoacoTtm
        BHW3EigsnNjXd3xSnUy++wZOmSa6WcmKtuWhF0UrbQrUWBMkSoxoiU6k50C4lqNgkdbLsA
        FehICbKhJdtEGqpr5KwWbl7L8nIzKXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-2bYyW6FmPjS3LyUzS1ee5w-1; Thu, 24 Oct 2019 12:10:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DC691005528;
        Thu, 24 Oct 2019 16:10:10 +0000 (UTC)
Received: from [10.36.116.202] (ovpn-116-202.ams2.redhat.com [10.36.116.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B900117F85;
        Thu, 24 Oct 2019 16:10:09 +0000 (UTC)
Subject: Re: [PATCH v2] mm: gup: fix comment of __get_user_pages()
To:     Liu Xiang <liuxiang_1999@126.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, jhubbard@nvidia.com
References: <1571929472-3091-1-git-send-email-liuxiang_1999@126.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0839edc8-c876-1713-c753-f12e70e5a653@redhat.com>
Date:   Thu, 24 Oct 2019 18:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1571929472-3091-1-git-send-email-liuxiang_1999@126.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 2bYyW6FmPjS3LyUzS1ee5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.10.19 17:04, Liu Xiang wrote:
> Fix comment of __get_user_pages() and make it more clear.
>=20
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Liu Xiang <liuxiang_1999@126.com>
> ---
>=20
> Changes in v2:
>   as suggested by John, rewrite the comment about return value.
>=20
>   mm/gup.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/mm/gup.c b/mm/gup.c
> index 8f236a3..bc6a254 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -734,11 +734,17 @@ static int check_vma_flags(struct vm_area_struct *v=
ma, unsigned long gup_flags)
>    *=09=09Or NULL if the caller does not require them.
>    * @nonblocking: whether waiting for disk IO or mmap_sem contention
>    *
> - * Returns number of pages pinned. This may be fewer than the number
> - * requested. If nr_pages is 0 or negative, returns 0. If no pages
> - * were pinned, returns -errno. Each page returned must be released
> - * with a put_page() call when it is finished with. vmas will only
> - * remain valid while mmap_sem is held.
> + * Returns either number of pages pinned (which may be less than the
> + * number requested), or an error. Details about the return value:
> + *
> + * -- If nr_pages is 0, returns 0.
> + * -- If nr_pages is >0, but no pages were pinned, returns -errno.
> + * -- If nr_pages is >0, and some pages were pinned, returns the number =
of
> + *    pages pinned. Again, this may be less than nr_pages.
> + *
> + * The caller is responsible for releasing returned @pages, via put_page=
().
> + *
> + * @vmas are valid only as long as mmap_sem is held.
>    *
>    * Must be called with mmap_sem held.  It may be released.  See below.
>    *
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb

