Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A62D1117D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 03:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLJCJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 21:09:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7653 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbfLJCJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:09:28 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3727580365B3C590DBB2;
        Tue, 10 Dec 2019 10:09:27 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 10 Dec
 2019 10:09:23 +0800
Subject: Re: [f2fs-dev] [PATCH 1/6] f2fs: call f2fs_balance_fs outside of
 locked page
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20191209222345.1078-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0f842142-4931-dcb8-9843-47510851e93b@huawei.com>
Date:   Tue, 10 Dec 2019 10:09:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191209222345.1078-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/10 6:23, Jaegeuk Kim wrote:
> Otherwise, we can hit deadlock by waiting for the locked page in
> move_data_block in GC.
> 
>  Thread A                     Thread B
>  - do_page_mkwrite
>   - f2fs_vm_page_mkwrite
>    - lock_page
>                               - f2fs_balance_fs
>                                   - mutex_lock(gc_mutex)
>                                - f2fs_gc
>                                 - do_garbage_collect
>                                  - ra_data_block
>                                   - grab_cache_page
>    - f2fs_balance_fs
>     - mutex_lock(gc_mutex)
> 
> Fixes: 39a8695824510 ("f2fs: refactor ->page_mkwrite() flow")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
