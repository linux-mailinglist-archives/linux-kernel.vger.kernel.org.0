Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6872EAE98A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 13:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfIJLx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 07:53:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:42046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfIJLx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:53:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82DF2B061;
        Tue, 10 Sep 2019 11:53:26 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] mm/kasan: dump alloc/free stack for page allocator
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        walter-zh.wu@mediatek.com, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
References: <20190909082412.24356-1-walter-zh.wu@mediatek.com>
 <d53d88df-d9a4-c126-32a8-4baeb0645a2c@suse.cz>
 <a7863965-90ab-5dae-65e7-8f68f4b4beb5@virtuozzo.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4faedb4d-f16c-1917-9eaa-b0f9c169fa50@suse.cz>
Date:   Tue, 10 Sep 2019 13:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a7863965-90ab-5dae-65e7-8f68f4b4beb5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/19 12:50 PM, Andrey Ryabinin wrote:
> 
> 
> For slab objects we memorize both alloc and free stacks. You'll never know in advance what information will be usefull
> to fix an issue, so it usually better to provide more information. I don't think we should do anything different for pages.

Exactly, thanks.

> Given that we already have the page_owner responsible for providing alloc/free stacks for pages, all that we should in KASAN do is to
> enable the feature by default. Free stack saving should be decoupled from debug_pagealloc into separate option so that it can be enabled
> by KASAN and/or debug_pagealloc.

Right. Walter, can you do it that way, or should I?

Thanks,
Vlastimil
