Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40624AE73E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 11:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404952AbfIJJoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 05:44:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44138 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391245AbfIJJoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:44:09 -0400
X-UUID: 7db3989441fd4168b9615b951f209fdb-20190910
X-UUID: 7db3989441fd4168b9615b951f209fdb-20190910
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1966950674; Tue, 10 Sep 2019 17:44:03 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Sep 2019 17:43:58 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Sep 2019 17:43:58 +0800
Message-ID: <1568108638.24886.7.camel@mtksdccf07>
Subject: Re: [PATCH v2 1/2] mm/page_ext: support to record the last stack of
 page
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     David Hildenbrand <david@redhat.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Tue, 10 Sep 2019 17:43:58 +0800
In-Reply-To: <20190910093103.4cmqk4semlhgpmle@box.shutemov.name>
References: <20190909085339.25350-1-walter-zh.wu@mediatek.com>
         <36b5a8e0-2783-4c0e-4fc7-78ea652ba475@redhat.com>
         <1568077669.24886.3.camel@mtksdccf07>
         <20190910093103.4cmqk4semlhgpmle@box.shutemov.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-10 at 12:31 +0300, Kirill A. Shutemov wrote:
> On Tue, Sep 10, 2019 at 09:07:49AM +0800, Walter Wu wrote:
> > On Mon, 2019-09-09 at 12:57 +0200, David Hildenbrand wrote:
> > > On 09.09.19 10:53, Walter Wu wrote:
> > > > KASAN will record last stack of page in order to help programmer
> > > > to see memory corruption caused by page.
> > > > 
> > > > What is difference between page_owner and our patch?
> > > > page_owner records alloc stack of page, but our patch is to record
> > > > last stack(it may be alloc or free stack of page).
> > > > 
> > > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > > ---
> > > >  mm/page_ext.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > > > index 5f5769c7db3b..7ca33dcd9ffa 100644
> > > > --- a/mm/page_ext.c
> > > > +++ b/mm/page_ext.c
> > > > @@ -65,6 +65,9 @@ static struct page_ext_operations *page_ext_ops[] = {
> > > >  #if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
> > > >  	&page_idle_ops,
> > > >  #endif
> > > > +#ifdef CONFIG_KASAN
> > > > +	&page_stack_ops,
> > > > +#endif
> > > >  };
> > > >  
> > > >  static unsigned long total_usage;
> > > > 
> > > 
> > > Are you sure this patch compiles?
> > > 
> > This is patchsets, it need another patch2.
> > We have verified it by running KASAN UT on Qemu.
> 
> Any patchset must be bisectable: do not break anything in the middle of
> patchset.
> 

Thanks your reminder.
I should explain complete message at commit log.
Our patchsets is below:
https://lkml.org/lkml/2019/9/9/104
https://lkml.org/lkml/2019/9/9/123


