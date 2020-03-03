Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A75DF17731A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 10:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgCCJvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 04:51:32 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44506 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbgCCJvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:51:31 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 11EC5620F1442FAA58A8;
        Tue,  3 Mar 2020 17:51:29 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 3 Mar 2020
 17:51:19 +0800
Subject: Re: [PATCH 3/3] erofs: handle corrupted images whose decompressed
 size less than it'd be
To:     Gao Xiang <gaoxiang25@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        "Lasse Collin" <lasse.collin@tukaani.org>
References: <20200226023011.103798-1-gaoxiang25@huawei.com>
 <20200226023011.103798-3-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <83e017a2-f94b-7dea-7ffd-301303b18397@huawei.com>
Date:   Tue, 3 Mar 2020 17:51:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200226023011.103798-3-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/26 10:30, Gao Xiang wrote:
> As Lasse pointed out, "Looking at fs/erofs/decompress.c,
> the return value from LZ4_decompress_safe_partial is only
> checked for negative value to catch errors. ... So if
> I understood it correctly, if there is bad data whose
> uncompressed size is much less than it should be, it can
> leave part of the output buffer untouched and expose the
> previous data as the file content. "
> 
> Let's fix it now.
> 
> Cc: Lasse Collin <lasse.collin@tukaani.org>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
