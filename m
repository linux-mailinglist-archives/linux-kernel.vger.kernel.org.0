Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 376F27B9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 08:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfGaG2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 02:28:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39097 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727479AbfGaG2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:28:17 -0400
X-UUID: be7293d6d19b4eff8b14efb567f5b460-20190731
X-UUID: be7293d6d19b4eff8b14efb567f5b460-20190731
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1463714770; Wed, 31 Jul 2019 14:28:10 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 31 Jul 2019 14:28:04 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 31 Jul 2019 14:28:04 +0800
Message-ID: <1564554484.28000.3.camel@mtkswgap22>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
From:   Miles Chen <miles.chen@mediatek.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 31 Jul 2019 14:28:04 +0800
In-Reply-To: <20190731161151.26ef081e@canb.auug.org.au>
References: <20190731161151.26ef081e@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: F9A6698179806194C69ED63691B213C0C26E3B2D449056AD4A5BFEBD37F7919F2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 16:11 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the akpm-current tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
> 
> mm/memcontrol.c: In function 'invalidate_reclaim_iterators':
> mm/memcontrol.c:1160:11: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
>   } while (memcg = parent_mem_cgroup(memcg));
>            ^~~~~
> 

Hi Stephen,

Thanks for the telling me this. Sorry for the build warning. 
Should I send patch v5 to the mailing list to fix this? 


Miles

> Introduced by commit
> 
>   c48a2f5ce935 ("mm/memcontrol.c: fix use after free in mem_cgroup_iter()")
> 


