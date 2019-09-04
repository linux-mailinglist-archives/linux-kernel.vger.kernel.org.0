Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4AEA8898
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfIDOQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 10:16:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25007 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727417AbfIDOQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:16:44 -0400
X-UUID: ec6f2baf4842498f92829352c925dd9a-20190904
X-UUID: ec6f2baf4842498f92829352c925dd9a-20190904
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2114202653; Wed, 04 Sep 2019 22:16:40 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Sep 2019 22:16:38 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Sep 2019 22:16:30 +0800
Message-ID: <1567606591.32522.21.camel@mtksdccf07>
Subject: Re: [PATCH 1/2] mm/kasan: dump alloc/free stack for page allocator
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Konovalov <andreyknvl@google.com>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Wed, 4 Sep 2019 22:16:31 +0800
In-Reply-To: <CAAeHK+wyvLF8=DdEczHLzNXuP+oC0CEhoPmp_LHSKVNyAiRGLQ@mail.gmail.com>
References: <20190904065133.20268-1-walter-zh.wu@mediatek.com>
         <CAAeHK+wyvLF8=DdEczHLzNXuP+oC0CEhoPmp_LHSKVNyAiRGLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-04 at 15:44 +0200, Andrey Konovalov wrote:
> On Wed, Sep 4, 2019 at 8:51 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > +config KASAN_DUMP_PAGE
> > +       bool "Dump the page last stack information"
> > +       depends on KASAN && PAGE_OWNER
> > +       help
> > +         By default, KASAN doesn't record alloc/free stack for page allocator.
> > +         It is difficult to fix up page use-after-free issue.
> > +         This feature depends on page owner to record the last stack of page.
> > +         It is very helpful for solving the page use-after-free or out-of-bound.
> 
> I'm not sure if we need a separate config for this. Is there any
> reason to not have this enabled by default?

PAGE_OWNER need some memory usage, it is not allowed to enable by
default in low RAM device. so I create new feature option and the person
who wants to use it to enable it.

Thanks.
Walter

