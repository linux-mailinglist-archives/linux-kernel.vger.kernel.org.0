Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDB9163E77
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 09:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgBSIGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 03:06:24 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbgBSIGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:06:23 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 9B368CBC75E280C9FAF4;
        Wed, 19 Feb 2020 16:06:16 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 19 Feb 2020 16:06:15 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 19 Feb 2020 16:06:15 +0800
Date:   Wed, 19 Feb 2020 16:04:57 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>
CC:     <linux-erofs@lists.ozlabs.org>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH v2] erofs: convert workstn to XArray
Message-ID: <20200219080456.GA126843@architecture4>
References: <20200217033042.137855-1-gaoxiang25@huawei.com>
 <58f1ff26-e1f8-96a4-fa7b-ee86f972b0aa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <58f1ff26-e1f8-96a4-fa7b-ee86f972b0aa@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Wed, Feb 19, 2020 at 03:46:16PM +0800, Chao Yu wrote:
> On 2020/2/17 11:30, Gao Xiang wrote:

[]

> > -	return err;
> > +	sbi = EROFS_SB(sb);
> > +repeat:
> > +	xa_lock(&sbi->managed_pslots);
> > +	pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
> > +			   NULL, grp, GFP_NOFS);
> > +	if (pre) {
> 
> It looks __xa_cmpxchg() could return negative value in case of failure, e.g.
> no memory case. We'd better handle that case and old valid workgroup separately?

Thanks, that is a quite good catch!

To be honest, I'm not quite sure whether __xa_cmpxchg
could fail due to no memory here (as a quick scan, it
will do __xas_nomem loop interally.)

But anyway, it needs bailing out all potential errors
by using xa_is_err(). Will do some research and send
v3 then.

Thanks,
Gao Xiang

