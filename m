Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBAC1620AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 07:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgBRGJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 01:09:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbgBRGJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 01:09:53 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C8727B81DB7338D6EC55;
        Tue, 18 Feb 2020 14:09:48 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 18 Feb
 2020 14:09:43 +0800
Subject: Re: [PATCH v3] f2fs: fix the panic in do_checkpoint()
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1581997747-31044-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <53aacd2c-8e6b-91f8-b105-270502d6d6d1@huawei.com>
Date:   Tue, 18 Feb 2020 14:09:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1581997747-31044-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/18 11:49, Sahitya Tummala wrote:
> There could be a scenario where f2fs_sync_meta_pages() will not
> ensure that all F2FS_DIRTY_META pages are submitted for IO. Thus,
> resulting in the below panic in do_checkpoint() -
> 
> f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_META) &&
> 				!f2fs_cp_error(sbi));
> 
> This can happen in a low-memory condition, where shrinker could
> also be doing the writepage operation (stack shown below)
> at the same time when checkpoint is running on another core.
> 
> schedule
> down_write
> f2fs_submit_page_write -> by this time, this page in page cache is tagged
> 			as PAGECACHE_TAG_WRITEBACK and PAGECACHE_TAG_DIRTY
> 			is cleared, due to which f2fs_sync_meta_pages()
> 			cannot sync this page in do_checkpoint() path.
> f2fs_do_write_meta_page
> __f2fs_write_meta_page
> f2fs_write_meta_page
> shrink_page_list
> shrink_inactive_list
> shrink_node_memcg
> shrink_node
> kswapd
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
