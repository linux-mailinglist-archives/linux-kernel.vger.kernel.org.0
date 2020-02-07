Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C4A1552C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 08:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgBGHKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 02:10:16 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51050 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgBGHKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:10:16 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 02ACA5D67E5839828354;
        Fri,  7 Feb 2020 15:10:14 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.66) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 7 Feb 2020
 15:10:02 +0800
Subject: Re: [PATCH] block: revert pushing the final release of request_queue
 to a workqueue.
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>, <chaitanya.kulkarni@wdc.com>,
        <damien.lemoal@wdc.com>, <dhowells@redhat.com>,
        <asml.silence@gmail.com>, <ajay.joshi@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <luoshijie1@huawei.com>
References: <20200206111052.45356-1-yukuai3@huawei.com>
 <51b4cd75-2b19-3e4d-7ead-409c77c44b70@acm.org>
 <d253d904-fe37-c1cd-05f5-a02f7c5730d3@huawei.com>
Message-ID: <d2be00d5-6a17-ea18-2f27-ffbfc6bfaa48@huawei.com>
Date:   Fri, 7 Feb 2020 15:10:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d253d904-fe37-c1cd-05f5-a02f7c5730d3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.66]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/7 14:02, yukuai (C) wrote:
> And I do agree that commit 7b36a7189fc3 is the right
> one.

My apologize that this is a mistake. Commit db6d99523560 is the one that
makes it safe to revert commit dc9edc44de6c. Because Commit db6d99523560
remove blk_exit_rl() from blkg_free().

blkg_release
   call_rcu --> can't sleep inside this
     __blkg_release
       blkg_free
         blk_exit_rl
	  blk_put_queue

