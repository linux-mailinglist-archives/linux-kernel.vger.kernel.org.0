Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0D2AE809
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 12:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390067AbfIJK0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 06:26:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:57770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727351AbfIJK0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:26:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF761AF59;
        Tue, 10 Sep 2019 10:26:15 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] mm, slab_common: Make the loop for initializing
 KMALLOC_DMA start from 1
To:     Pengfei Li <lpf.vector@gmail.com>, akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com
References: <20190910012652.3723-1-lpf.vector@gmail.com>
 <20190910012652.3723-5-lpf.vector@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <23cb75f5-4a05-5901-2085-8aeabc78c100@suse.cz>
Date:   Tue, 10 Sep 2019 12:26:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910012652.3723-5-lpf.vector@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/19 3:26 AM, Pengfei Li wrote:
> KMALLOC_DMA will be initialized only if KMALLOC_NORMAL with
> the same index exists.
> 
> And kmalloc_caches[KMALLOC_NORMAL][0] is always NULL.
> 
> Therefore, the loop that initializes KMALLOC_DMA should start
> at 1 instead of 0, which will reduce 1 meaningless attempt.

IMHO the saving of one iteration isn't worth making the code more 
subtle. KMALLOC_SHIFT_LOW would be nice, but that would skip 1 + 2 which 
are special.

Since you're doing these cleanups, have you considered reordering 
kmalloc_info, size_index, kmalloc_index() etc so that sizes 96 and 192 
are ordered naturally between 64, 128 and 256? That should remove 
various special casing such as in create_kmalloc_caches(). I can't 
guarantee it will be possible without breaking e.g. constant folding 
optimizations etc., but seems to me it should be feasible. (There are 
definitely more places to change than those I listed.)

> Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
> ---
>   mm/slab_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index af45b5278fdc..c81fc7dc2946 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1236,7 +1236,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>   	slab_state = UP;
>   
>   #ifdef CONFIG_ZONE_DMA
> -	for (i = 0; i <= KMALLOC_SHIFT_HIGH; i++) {
> +	for (i = 1; i <= KMALLOC_SHIFT_HIGH; i++) {
>   		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
>   
>   		if (s) {
> 

