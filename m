Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A15D9118042
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 07:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfLJGSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 01:18:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7205 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbfLJGSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:18:08 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 19D4DBA2B8D8F9A920B2;
        Tue, 10 Dec 2019 14:18:05 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 10 Dec
 2019 14:18:00 +0800
Subject: Re: [PATCH] f2fs: cleanup duplicate stats for atomic files
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <0101016ed414fbce-f78f838a-bc2b-4ee7-88b1-88bc07e1e0f4-000000@us-west-2.amazonses.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <60cd9ef9-1323-da0d-a0db-5fdba52a0e1e@huawei.com>
Date:   Tue, 10 Dec 2019 14:18:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0101016ed414fbce-f78f838a-bc2b-4ee7-88b1-88bc07e1e0f4-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/5 11:22, Sahitya Tummala wrote:
> Remove duplicate sbi->aw_cnt stats counter that tracks
> the number of atomic files currently opened (it also shows
> incorrect value sometimes). Use more reliable sbi->atomic_files
> to show in the stats.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
