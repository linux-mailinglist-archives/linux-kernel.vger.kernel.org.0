Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFCFED5985
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 04:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfJNCT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 22:19:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22609 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729474AbfJNCT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 22:19:56 -0400
X-UUID: fcb45f13d48f4e009d0c4926b41054a7-20191014
X-UUID: fcb45f13d48f4e009d0c4926b41054a7-20191014
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 800004060; Mon, 14 Oct 2019 10:19:43 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 14 Oct 2019 10:19:40 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 14 Oct 2019 10:19:41 +0800
Message-ID: <1571019582.26230.8.camel@mtksdccf07>
Subject: Re: [PATCH] kasan: fix the missing underflow in memmove and memcpy
 with CONFIG_KASAN_GENERIC=y
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Qian Cai <cai@lca.pw>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Mon, 14 Oct 2019 10:19:42 +0800
In-Reply-To: <CACT4Y+Zbx-2yR-mN5GioaKUgGH1TpTE2D-OgLbR2Dy09ezyGGQ@mail.gmail.com>
References: <1570532528.4686.102.camel@mtksdccf07>
         <D2B6D82F-AE5F-4A45-AC0C-BE5DA601FDC3@lca.pw>
         <CACT4Y+Zbx-2yR-mN5GioaKUgGH1TpTE2D-OgLbR2Dy09ezyGGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 14:11 +0200, Dmitry Vyukov wrote:
> On Tue, Oct 8, 2019 at 1:42 PM Qian Cai <cai@lca.pw> wrote:
> > > On Oct 8, 2019, at 7:02 AM, Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > I don't know very well in UBSAN, but I try to build ubsan kernel and
> > > test a negative number in memset and kmalloc_memmove_invalid_size(), it
> > > look like no check.
> >
> > It sounds like more important to figure out why the UBSAN is not working in this case rather than duplicating functionality elsewhere.
> 
> Detecting out-of-bounds accesses is the direct KASAN responsibility.
> Even more direct than for KUBSAN. We are not even adding
> functionality, it's just a plain bug in KASAN code, it tricks itself
> into thinking that access size is 0.
> Maybe it's already detected by KUBSAN too?

Thanks for your response.
I survey the KUBSAN, it don't check size is negative in
memset/memcpy/memmove, we try to verify our uni testing too, it don't
report the bug in KUBSAN, so it needs to report this bug by KASAN. The
reason is like what you said. so we still send the patch.

