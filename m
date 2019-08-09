Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE287C60
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 16:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406818AbfHIOMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 10:12:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60215 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726157AbfHIOMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:12:07 -0400
X-UUID: 725620696fd34fab965989687eb53529-20190809
X-UUID: 725620696fd34fab965989687eb53529-20190809
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 735304464; Fri, 09 Aug 2019 22:11:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 9 Aug 2019 22:11:58 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 9 Aug 2019 22:11:58 +0800
Message-ID: <1565359918.12824.20.camel@mtkswgap22>
Subject: Re: [RFC PATCH v2] mm: slub: print kernel addresses in slub debug
 messages
From:   Miles Chen <miles.chen@mediatek.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Kees Cook <keescook@chromium.org>
Date:   Fri, 9 Aug 2019 22:11:58 +0800
In-Reply-To: <20190809024644.GL5482@bombadil.infradead.org>
References: <20190809010837.24166-1-miles.chen@mediatek.com>
         <20190809024644.GL5482@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-08 at 19:46 -0700, Matthew Wilcox wrote:
> On Fri, Aug 09, 2019 at 09:08:37AM +0800, miles.chen@mediatek.com wrote:
> > Possible approaches are:
> > 1. stop printing kernel addresses
> > 2. print with %pK,
> > 3. print with %px.
> 
> No.  The point of obscuring kernel addresses is that if the attacker manages to find a way to get the kernel to spit out some debug messages that we shouldn't
> leak all this extra information.

got it.
> 
> > 4. do nothing
> 
> 5. Find something more useful to print.

agree
> 
> > INFO: Slab 0x(____ptrval____) objects=25 used=10 fp=0x(____ptrval____)
> 
> ... you don't have any randomness on your platform?

We have randomized base on our platforms.

> But if you have randomness, at least some of these "pointers" are valuable
> because you can compare them against "pointers" printed by other parts
> of the kernel.

Understood. Keep current %p, do not leak kernel addresses.

I'll collect more cases and see if we really need some extra
information. (maybe the @offset in current message is enough)


thanks for your comments!



