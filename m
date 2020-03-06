Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F40B317B39E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 02:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCFBQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 20:16:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbgCFBQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:16:10 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 701FE4C8BE47CF47207A;
        Fri,  6 Mar 2020 09:16:08 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 6 Mar 2020
 09:16:07 +0800
Subject: Re: [PATCH V2 1/2] f2fs: Fix mount failure due to SPO after a
 successful online resize FS
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1583245766-3351-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9edd90a3-85d4-1a9a-ce34-f05cec7e4da5@huawei.com>
Date:   Fri, 6 Mar 2020 09:16:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1583245766-3351-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/3 22:29, Sahitya Tummala wrote:
> Even though online resize is successfully done, a SPO immediately
> after resize, still causes below error in the next mount.
> 
> [   11.294650] F2FS-fs (sda8): Wrong user_block_count: 2233856
> [   11.300272] F2FS-fs (sda8): Failed to get valid F2FS checkpoint
> 
> This is because after FS metadata is updated in update_fs_metadata()
> if the SBI_IS_DIRTY is not dirty, then CP will not be done to reflect
> the new user_block_count.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
