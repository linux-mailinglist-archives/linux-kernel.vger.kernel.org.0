Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72B815523E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 07:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgBGGCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 01:02:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbgBGGCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:02:35 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CC793CBFF9FB168A0E80;
        Fri,  7 Feb 2020 14:02:31 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.66) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 7 Feb 2020
 14:02:22 +0800
Subject: Re: [PATCH] block: revert pushing the final release of request_queue
 to a workqueue.
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>, <chaitanya.kulkarni@wdc.com>,
        <damien.lemoal@wdc.com>, <dhowells@redhat.com>,
        <asml.silence@gmail.com>, <ajay.joshi@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <luoshijie1@huawei.com>
References: <20200206111052.45356-1-yukuai3@huawei.com>
 <51b4cd75-2b19-3e4d-7ead-409c77c44b70@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <d253d904-fe37-c1cd-05f5-a02f7c5730d3@huawei.com>
Date:   Fri, 7 Feb 2020 14:02:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <51b4cd75-2b19-3e4d-7ead-409c77c44b70@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.66]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/7 12:09, Bart Van Assche wrote:
> I think the second commit reference is wrong. Did you perhaps want to
> refer to commit 7b36a7189fc3 ("block: don't call ioc_exit_icq() with the
> queue lock held for blk-mq")? That is the commit that removed the
> locking from blk_release_queue() and that makes it safe to revert commit
> dc9edc44de6c.

Thank you for your response.

Commit 1e9364283764 just fix some comments, real funtional modification
should before that. And I do agree that commit 7b36a7189fc3 is the right
one.

By the way, do you agree the way I fix the CVE? I can send a V2 patch if
you do.

Thanks!
Yu Kuai

