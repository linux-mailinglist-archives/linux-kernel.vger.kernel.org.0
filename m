Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D77BA6A92
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 15:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfICN6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 09:58:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbfICN6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:58:00 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7C8D5F910AFE46A19A58;
        Tue,  3 Sep 2019 21:57:53 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 21:57:50 +0800
Message-ID: <5D6E715E.2070602@huawei.com>
Date:   Tue, 3 Sep 2019 21:57:50 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Bob Copeland <me@bobcopeland.com>
CC:     <linux-kernel@vger.kernel.org>,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: Re: [PATCH] fs: omfs: Use kmemdup rather than duplicating its implementation
 in omfs_get_imap
References: <1567492784-19304-1-git-send-email-zhongjiang@huawei.com> <20190903132532.GB5280@localhost>
In-Reply-To: <20190903132532.GB5280@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/3 21:25, Bob Copeland wrote:
> On Tue, Sep 03, 2019 at 02:39:44PM +0800, zhong jiang wrote:
>> kmemdup contains the kmalloc + memcpy. hence it is better to use kmemdup
>> directly. Just replace it.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> This same patch was already sent to me by someone else and I acked it:
>
> https://lore.kernel.org/lkml/20190703163158.937-1-huangfq.daxian@gmail.com/
>
I miss the patch.  Thanks,

Sincerely,
zhong jiang

