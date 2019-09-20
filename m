Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9530B8FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 14:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408967AbfITMWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 08:22:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406276AbfITMWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 08:22:04 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9B838EC4FBE89CAAA15E;
        Fri, 20 Sep 2019 20:22:02 +0800 (CST)
Received: from [127.0.0.1] (10.57.88.168) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Sep 2019
 20:21:54 +0800
Subject: Re: [PATCH] jffs2:freely allocate memory when parameters are invalid
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     <dwmw2@infradead.org>, <dilinger@queued.net>, <richard@nod.at>,
        <houtao1@huawei.com>, <bbrezillon@kernel.org>,
        <daniel.santos@pobox.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1568962478-126260-1-git-send-email-nixiaoming@huawei.com>
 <20190920114336.GM1131@ZenIV.linux.org.uk>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <206f8d57-dad9-26c3-6bf6-1d000f5698d4@huawei.com>
Date:   Fri, 20 Sep 2019 20:21:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920114336.GM1131@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.88.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/20 19:43, Al Viro wrote:
> On Fri, Sep 20, 2019 at 02:54:38PM +0800, Xiaoming Ni wrote:
>> Use kzalloc() to allocate memory in jffs2_fill_super().
>> Freeing memory when jffs2_parse_options() fails will cause
>> use-after-free and double-free in jffs2_kill_sb()
> 
> ... so we are not freeing it there.  What's the problem?

No code logic issues, no memory leaks

But there is too much code logic between memory allocation and free,
which is difficult to understand.

The modified code is easier to understand.

thanks

Xiaoming Ni

