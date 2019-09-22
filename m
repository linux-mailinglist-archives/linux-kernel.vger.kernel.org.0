Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8175BA18B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2019 10:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfIVImT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 04:42:19 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2423 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727809AbfIVImT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 04:42:19 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 47D16A3DAE455B128752;
        Sun, 22 Sep 2019 16:42:17 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 22 Sep 2019 16:42:17 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Sun, 22 Sep 2019 16:42:16 +0800
Date:   Sun, 22 Sep 2019 16:41:04 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     kbuild test robot <lkp@intel.com>
CC:     <kbuild-all@01.org>, Chao Yu <yuchao0@huawei.com>,
        <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH] erofs: fix erofs_get_meta_page locking by a cleanup
Message-ID: <20190922084101.GA114049@architecture4>
References: <20190921073035.209811-1-gaoxiang25@huawei.com>
 <20190922083205.GN13569@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190922083205.GN13569@xsang-OptiPlex-9020>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 22, 2019 at 04:32:05PM +0800, kbuild test robot wrote:
> 
> All warnings (new ones prefixed by >>):
> 
>    fs//erofs/data.c: In function 'erofs_get_meta_page':
> >> fs//erofs/data.c:43:10: warning: return makes pointer from integer without a cast [-Wint-conversion]
>       return PTR_ERR(page);

It was already fixed in v2.

Thanks,
Gao Xiang

