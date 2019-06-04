Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465853438A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 11:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfFDJ4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 05:56:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18080 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727075AbfFDJ4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:56:37 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7D02DE4F6DB8E951CA4C;
        Tue,  4 Jun 2019 17:48:55 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 4 Jun 2019
 17:48:53 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add a rw_sem to cover quota flag
 changes
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190530033115.16853-1-jaegeuk@kernel.org>
 <20190530175714.GB28719@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c4348b1c-02ba-44e7-598c-e2435e53077d@huawei.com>
Date:   Tue, 4 Jun 2019 17:48:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190530175714.GB28719@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/31 1:57, Jaegeuk Kim wrote:
> thread 1:                        thread 2:
> writeback                        checkpoint
> set QUOTA_NEED_FLUSH
>                                  clear QUOTA_NEED_FLUSH
> f2fs_dquot_commit
> dquot_commit
> clear_dquot_dirty
>                                  f2fs_quota_sync
>                                  dquot_writeback_dquots
> 				 nothing to commit
> commit_dqblk
> quota_write
> f2fs_quota_write
> waiting for f2fs_lock_op()
> 				 pass __need_flush_quota
>                                  (no F2FS_DIRTY_QDATA)
> 
> -> up-to-date quota is not written
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
