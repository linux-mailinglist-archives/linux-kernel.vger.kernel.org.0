Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F43C988E8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 03:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfHVBWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 21:22:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51888 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727316AbfHVBWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 21:22:10 -0400
X-UUID: 2740e10b36dc499fa5282ce2d54ec53c-20190822
X-UUID: 2740e10b36dc499fa5282ce2d54ec53c-20190822
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1416285409; Thu, 22 Aug 2019 09:22:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 22 Aug 2019 09:22:02 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 22 Aug 2019 09:21:58 +0800
Message-ID: <1566436922.27117.0.camel@mtksdccf07>
Subject: Re: [PATCH v4] kasan: add memory corruption identification for
 software tag-based mode
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
CC:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Miles Chen <miles.chen@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Thu, 22 Aug 2019 09:22:02 +0800
In-Reply-To: <3318f9d7-a760-3cc8-b700-f06108ae745f@virtuozzo.com>
References: <20190806054340.16305-1-walter-zh.wu@mediatek.com>
         <1566279478.9993.21.camel@mtksdccf07>
         <3318f9d7-a760-3cc8-b700-f06108ae745f@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-21 at 20:52 +0300, Andrey Ryabinin wrote:
> 
> On 8/20/19 8:37 AM, Walter Wu wrote:
> > On Tue, 2019-08-06 at 13:43 +0800, Walter Wu wrote:
> >> This patch adds memory corruption identification at bug report for
> >> software tag-based mode, the report show whether it is "use-after-free"
> >> or "out-of-bound" error instead of "invalid-access" error. This will make
> >> it easier for programmers to see the memory corruption problem.
> >>
> >> We extend the slab to store five old free pointer tag and free backtrace,
> >> we can check if the tagged address is in the slab record and make a
> >> good guess if the object is more like "use-after-free" or "out-of-bound".
> >> therefore every slab memory corruption can be identified whether it's
> >> "use-after-free" or "out-of-bound".
> >>
> >> ====== Changes
> >> Change since v1:
> >> - add feature option CONFIG_KASAN_SW_TAGS_IDENTIFY.
> >> - change QUARANTINE_FRACTION to reduce quarantine size.
> >> - change the qlist order in order to find the newest object in quarantine
> >> - reduce the number of calling kmalloc() from 2 to 1 time.
> >> - remove global variable to use argument to pass it.
> >> - correct the amount of qobject cache->size into the byes of qlist_head.
> >> - only use kasan_cache_shrink() to shink memory.
> >>
> >> Change since v2:
> >> - remove the shinking memory function kasan_cache_shrink()
> >> - modify the description of the CONFIG_KASAN_SW_TAGS_IDENTIFY
> >> - optimize the quarantine_find_object() and qobject_free()
> >> - fix the duplicating function name 3 times in the header.
> >> - modify the function name set_track() to kasan_set_track()
> >>
> >> Change since v3:
> >> - change tag-based quarantine to extend slab to identify memory corruption
> > 
> > Hi,Andrey,
> > 
> > Would you review the patch,please?
> 
> 
> I didn't notice anything fundamentally wrong, but I find there are some
> questionable implementation choices that makes code look weirder than necessary
> and harder to understand. So I ended up with cleaning it up, see the diff bellow.
> I'll send v5 with that diff folded.
> 

Thanks your review and suggestion.

Walter

