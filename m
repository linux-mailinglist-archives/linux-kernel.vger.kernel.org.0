Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9B6E1EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 16:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406404AbfJWO4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 10:56:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32742 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390185AbfJWO4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571842603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dFr4auTB5WCyyB+oGj7EM0Xur1GVbDsBycmZZyHEWFI=;
        b=BwfD6rNmNvETo/OaSPeV6cXtCW3j15gHtTC42V4Hhq9pGJg1+yD8uoth3KBo88lUo7Ry6l
        b1NoFeTJ9Kuum7KH3Sbf8niO6+XIWJc/M38jVxYLnwelqRWWBGO4rURXoxY5A8o8cCR0vS
        pqrIi/Q9lbo0R1Q3YMLQhCf8d0BNSFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-7rKysA6pPnepJMF_sEPftA-1; Wed, 23 Oct 2019 10:56:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53E7D1800D6B;
        Wed, 23 Oct 2019 14:56:38 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F8A3194BE;
        Wed, 23 Oct 2019 14:56:31 +0000 (UTC)
Subject: Re: [RFC PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
 <20191023102737.32274-3-mhocko@kernel.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a3510617-fd23-9f90-3c40-700bcb0f353c@redhat.com>
Date:   Wed, 23 Oct 2019 10:56:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191023102737.32274-3-mhocko@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 7rKysA6pPnepJMF_sEPftA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/19 6:27 AM, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
>
> pagetypeinfo_showfree_print is called by zone->lock held in irq mode.
> This is not really nice because it blocks both any interrupts on that
> cpu and the page allocator. On large machines this might even trigger
> the hard lockup detector.
>
> Considering the pagetypeinfo is a debugging tool we do not really need
> exact numbers here. The primary reason to look at the outuput is to see
> how pageblocks are spread among different migratetypes therefore putting
> a bound on the number of pages on the free_list sounds like a reasonable
> tradeoff.
>
> The new output will simply tell
> [...]
> Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >1000=
00  41019  31560  23996  10054   3229    983    648
>
> instead of
> Node    6, zone   Normal, type      Movable 399568 294127 221558 102119  =
41019  31560  23996  10054   3229    983    648
>
> The limit has been chosen arbitrary and it is a subject of a future
> change should there be a need for that.
>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmstat.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 4e885ecd44d1..762034fc3b83 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1386,8 +1386,25 @@ static void pagetypeinfo_showfree_print(struct seq=
_file *m,
> =20
>  =09=09=09area =3D &(zone->free_area[order]);
> =20
> -=09=09=09list_for_each(curr, &area->free_list[mtype])
> +=09=09=09list_for_each(curr, &area->free_list[mtype]) {
>  =09=09=09=09freecount++;
> +=09=09=09=09/*
> +=09=09=09=09 * Cap the free_list iteration because it might
> +=09=09=09=09 * be really large and we are under a spinlock
> +=09=09=09=09 * so a long time spent here could trigger a
> +=09=09=09=09 * hard lockup detector. Anyway this is a
> +=09=09=09=09 * debugging tool so knowing there is a handful
> +=09=09=09=09 * of pages in this order should be more than
> +=09=09=09=09 * sufficient
> +=09=09=09=09 */
> +=09=09=09=09if (freecount > 100000) {
> +=09=09=09=09=09seq_printf(m, ">%6lu ", freecount);
> +=09=09=09=09=09spin_unlock_irq(&zone->lock);
> +=09=09=09=09=09cond_resched();
> +=09=09=09=09=09spin_lock_irq(&zone->lock);
> +=09=09=09=09=09continue;
list_for_each() is a for loop. The continue statement will just iterate
the rests with the possibility that curr will be stale. Should we use
goto to jump after the seq_print() below?
> +=09=09=09=09}
> +=09=09=09}
>  =09=09=09seq_printf(m, "%6lu ", freecount);
>  =09=09}
>  =09=09seq_putc(m, '\n');

Cheers,
Longman

