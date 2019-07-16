Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28CDA6A889
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 14:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbfGPMRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 08:17:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726997AbfGPMRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 08:17:49 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C54159B27B271D41CE26;
        Tue, 16 Jul 2019 20:17:46 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 20:17:36 +0800
Subject: Re: [PATCH v2] staging: erofs: avoid opened loop codes
To:     Chao Yu <yuchao0@huawei.com>, <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <chao@kernel.org>
References: <20190716094422.110805-1-yuchao0@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <e0725b60-c6d2-1590-c974-f79e085e8cb8@huawei.com>
Date:   Tue, 16 Jul 2019 20:17:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190716094422.110805-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/16 17:44, Chao Yu wrote:
> Use __GFP_NOFAIL to avoid opened loop codes in z_erofs_vle_unzip().
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang
