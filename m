Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40D4B11E2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 17:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbfILPOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 11:14:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34565 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732710AbfILPOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 11:14:00 -0400
X-UUID: 1573f0ea1df94009b360989531af66db-20190912
X-UUID: 1573f0ea1df94009b360989531af66db-20190912
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 415036316; Thu, 12 Sep 2019 23:13:55 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Sep 2019 23:13:53 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Sep 2019 23:13:52 +0800
Message-ID: <1568301233.19274.17.camel@mtksdccf07>
Subject: Re: [PATCH v3] mm/kasan: dump alloc and free stack for page
 allocator
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Qian Cai <cai@lca.pw>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Arnd Bergmann" <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Thu, 12 Sep 2019 23:13:53 +0800
In-Reply-To: <613f9f23-c7f0-871f-fe13-930c35ef3105@suse.cz>
References: <20190911083921.4158-1-walter-zh.wu@mediatek.com>
         <5E358F4B-552C-4542-9655-E01C7B754F14@lca.pw>
         <c4d2518f-4813-c941-6f47-73897f420517@suse.cz>
         <1568297308.19040.5.camel@mtksdccf07>
         <613f9f23-c7f0-871f-fe13-930c35ef3105@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 16:31 +0200, Vlastimil Babka wrote:
> On 9/12/19 4:08 PM, Walter Wu wrote:
> > 
> >>   extern void __reset_page_owner(struct page *page, unsigned int order);
> >> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> >> index 6c9682ce0254..dc560c7562e8 100644
> >> --- a/lib/Kconfig.kasan
> >> +++ b/lib/Kconfig.kasan
> >> @@ -41,6 +41,8 @@ config KASAN_GENERIC
> >>   	select SLUB_DEBUG if SLUB
> >>   	select CONSTRUCTORS
> >>   	select STACKDEPOT
> >> +	select PAGE_OWNER
> >> +	select PAGE_OWNER_FREE_STACK
> >>   	help
> >>   	  Enables generic KASAN mode.
> >>   	  Supported in both GCC and Clang. With GCC it requires version 4.9.2
> >> @@ -63,6 +65,8 @@ config KASAN_SW_TAGS
> >>   	select SLUB_DEBUG if SLUB
> >>   	select CONSTRUCTORS
> >>   	select STACKDEPOT
> >> +	select PAGE_OWNER
> >> +	select PAGE_OWNER_FREE_STACK
> >>   	help
> > 
> > What is the difference between PAGE_OWNER+PAGE_OWNER_FREE_STACK and
> > DEBUG_PAGEALLOC?
> 
> Same memory usage, but debug_pagealloc means also extra checks and 
> restricting memory access to freed pages to catch UAF.
> 
> > If you directly enable PAGE_OWNER+PAGE_OWNER_FREE_STACK
> > PAGE_OWNER_FREE_STACK,don't you think low-memory device to want to use
> > KASAN?
> 
> OK, so it should be optional? But I think it's enough to distinguish no 
> PAGE_OWNER at all, and PAGE_OWNER+PAGE_OWNER_FREE_STACK together - I 
> don't see much point in PAGE_OWNER only for this kind of debugging.
> 
If it's possible, it should be optional.
My experience is that PAGE_OWNER usually debug memory leakage.

> So how about this? KASAN wouldn't select PAGE_OWNER* but it would be 
> recommended in the help+docs. When PAGE_OWNER and KASAN are selected by 
> user, PAGE_OWNER_FREE_STACK gets also selected, and both will be also 
> runtime enabled without explicit page_owner=on.
> I mostly want to avoid another boot-time option for enabling 
> PAGE_OWNER_FREE_STACK.
> Would that be enough flexibility for low-memory devices vs full-fledged 
> debugging?

We usually see feature option to decide whether it meet the platform.
The boot-time option isn't troubled to us, because enable the feature
owner should know what he should add to do.



