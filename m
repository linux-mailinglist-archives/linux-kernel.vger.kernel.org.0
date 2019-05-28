Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0342BDBF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 05:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfE1D2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 23:28:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39506 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727320AbfE1D2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 23:28:46 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 08070316052553E07046;
        Tue, 28 May 2019 11:28:45 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 28 May
 2019 11:28:37 +0800
Subject: Re: [PATCH v3 2/2] staging: erofs: fix i_blocks calculation
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190528023147.94117-2-gaoxiang25@huawei.com>
 <20190528031943.239665-1-gaoxiang25@huawei.com>
 <20190528031943.239665-2-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <acaed8f7-1449-6509-d7c3-a9e106305224@huawei.com>
Date:   Tue, 28 May 2019 11:28:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190528031943.239665-2-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/28 11:19, Gao Xiang wrote:
> For compressed files, i_blocks should not be calculated
> by using i_size. use i_u.compressed_blocks instead.
> 
> In addition, i_blocks was miscalculated for non-compressed
> files previously, fix it as well.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
