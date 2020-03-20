Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BABAB18D5C8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 18:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgCTR26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 13:28:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:40238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbgCTR25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:28:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E1AF1AC84;
        Fri, 20 Mar 2020 17:28:55 +0000 (UTC)
Subject: Re: [PATCH] mm/compaction.c: Clean code by removing unnecessary
 assignment
To:     mateusznosek0@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org
References: <20200318174509.15021-1-mateusznosek0@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ac3ccec1-4583-91ee-0385-5c162c789804@suse.cz>
Date:   Fri, 20 Mar 2020 18:28:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318174509.15021-1-mateusznosek0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/20 6:45 PM, mateusznosek0@gmail.com wrote:
> From: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> Previously 0 was assigned to variable 'last_migrated_pfn'. But the
> variable is not read after that, so the assignment can be removed.
> 
> Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/compaction.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 827d8a2b3164..4576d6c5afb5 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2183,7 +2183,6 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>  			ret = COMPACT_CONTENDED;
>  			putback_movable_pages(&cc->migratepages);
>  			cc->nr_migratepages = 0;
> -			last_migrated_pfn = 0;
>  			goto out;
>  		case ISOLATE_NONE:
>  			if (update_cached) {
> 

