Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E774AE1D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 03:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391009AbfIJBH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 21:07:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40958 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727115AbfIJBH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 21:07:59 -0400
X-UUID: 36793eb043954315b23be36aa610228e-20190910
X-UUID: 36793eb043954315b23be36aa610228e-20190910
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 831663314; Tue, 10 Sep 2019 09:07:51 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Sep 2019 09:07:49 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Sep 2019 09:07:49 +0800
Message-ID: <1568077669.24886.3.camel@mtksdccf07>
Subject: Re: [PATCH v2 1/2] mm/page_ext: support to record the last stack of
 page
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Will Deacon <will@kernel.org>,
        "Andrey Konovalov" <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Tue, 10 Sep 2019 09:07:49 +0800
In-Reply-To: <36b5a8e0-2783-4c0e-4fc7-78ea652ba475@redhat.com>
References: <20190909085339.25350-1-walter-zh.wu@mediatek.com>
         <36b5a8e0-2783-4c0e-4fc7-78ea652ba475@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-09 at 12:57 +0200, David Hildenbrand wrote:
> On 09.09.19 10:53, Walter Wu wrote:
> > KASAN will record last stack of page in order to help programmer
> > to see memory corruption caused by page.
> > 
> > What is difference between page_owner and our patch?
> > page_owner records alloc stack of page, but our patch is to record
> > last stack(it may be alloc or free stack of page).
> > 
> > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > ---
> >  mm/page_ext.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > index 5f5769c7db3b..7ca33dcd9ffa 100644
> > --- a/mm/page_ext.c
> > +++ b/mm/page_ext.c
> > @@ -65,6 +65,9 @@ static struct page_ext_operations *page_ext_ops[] = {
> >  #if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
> >  	&page_idle_ops,
> >  #endif
> > +#ifdef CONFIG_KASAN
> > +	&page_stack_ops,
> > +#endif
> >  };
> >  
> >  static unsigned long total_usage;
> > 
> 
> Are you sure this patch compiles?
> 
This is patchsets, it need another patch2.
We have verified it by running KASAN UT on Qemu.



