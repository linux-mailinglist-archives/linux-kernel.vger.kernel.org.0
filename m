Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A21909F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 10:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCXJuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 05:50:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726413AbgCXJuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:50:04 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9C3D06FFE1308FAF180B;
        Tue, 24 Mar 2020 17:49:48 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 24 Mar
 2020 17:49:43 +0800
Subject: Re: [PATCH v2] f2fs: compress: support zstd compress algorithm
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200303094602.50372-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1ee0c565-930b-2379-b22b-40ddca271de3@huawei.com>
Date:   Tue, 24 Mar 2020 17:49:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200303094602.50372-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On 2020/3/3 17:46, Chao Yu wrote:
> Add zstd compress algorithm support, use "compress_algorithm=zstd"
> mountoption to enable it.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - avoid accessing invalid address
> - introduce .{init,destroy}_{,de}compress_ctx callback functions.

I guess we merged related patches with wrong sequence as this patch
depends on ("f2fs: compress: add .{init,destroy}_decompress_ctx callback").

Thanks,
