Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F0117B3AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 02:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFBTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 20:19:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbgCFBTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:19:46 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 77563EC8DC063C1F3480;
        Fri,  6 Mar 2020 09:19:43 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 6 Mar 2020
 09:19:41 +0800
Subject: Re: [PATCH V2 2/2] f2fs: Add a new CP flag to help fsck fix resize
 SPO issues
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1583245766-3351-1-git-send-email-stummala@codeaurora.org>
 <1583245766-3351-2-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e164f166-5c3f-a2ce-aec6-ff01ecb902e8@huawei.com>
Date:   Fri, 6 Mar 2020 09:19:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1583245766-3351-2-git-send-email-stummala@codeaurora.org>
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
> Add and set a new CP flag CP_RESIZEFS_FLAG during
> online resize FS to help fsck fix the metadata mismatch
> that may happen due to SPO during resize, where SB
> got updated but CP data couldn't be written yet.
> 
> fsck errors -
> Info: CKPT version = 6ed7bccb
>         Wrong user_block_count(2233856)
> [f2fs_do_mount:3365] Checkpoint is polluted

I'm not against this patch, however without this change, could
fsck have any chance to repair old image?

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>
