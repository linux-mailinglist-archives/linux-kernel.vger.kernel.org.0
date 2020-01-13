Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF905138D44
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 09:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgAMI4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 03:56:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8705 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbgAMI4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:56:32 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 12CE9F26DD09C2D7CF29;
        Mon, 13 Jan 2020 16:56:30 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 13 Jan
 2020 16:56:27 +0800
Subject: Re: [f2fs-dev][PATCH V2] resize.f2fs: add option for large_nat_bitmap
 feature
To:     ping xiong <xp1982.06.06@gmail.com>
CC:     <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, xiongping1 <xiongping1@xiaomi.com>
References: <1578898350-29607-1-git-send-email-xp1982.06.06@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6304784c-69f3-6542-a660-8513c3895b07@huawei.com>
Date:   Mon, 13 Jan 2020 16:56:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1578898350-29607-1-git-send-email-xp1982.06.06@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/13 14:52, ping xiong wrote:
> From: xiongping1 <xiongping1@xiaomi.com>
> 
> resize.f2fs has already supported large_nat_bitmap feature, but has no
> option to turn on it.
> 
> This change add a new '-i' option to control turning on it.
> 
> Signed-off-by: xiongping1 <xiongping1@xiaomi.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
