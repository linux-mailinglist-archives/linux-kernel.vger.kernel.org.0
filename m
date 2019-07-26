Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 390E675D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 05:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfGZDzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 23:55:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfGZDzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:55:32 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9BD8BF112BB1844FE3BE;
        Fri, 26 Jul 2019 11:55:30 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 26 Jul
 2019 11:55:26 +0800
Subject: Re: [PATCH] fs: f2fs: Remove unnecessary checks of SM_I(sbi) in
 update_general_status()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190726034512.32478-1-baijiaju1990@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <039c2c03-51eb-0666-bfac-696fb678a733@huawei.com>
Date:   Fri, 26 Jul 2019 11:55:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190726034512.32478-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/26 11:45, Jia-Ju Bai wrote:
> In fill_super() and put_super(), f2fs_destroy_stats() is called 
> in prior to f2fs_destroy_segment_manager(), so if current
> sbi can still be visited in global stat list, SM_I(sbi) should be
> released yet.
> For this reason, SM_I(sbi) does not need to be checked in
> update_general_status().
> Thank Chao Yu for advice.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
