Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C594C9EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 10:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfFTIy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 04:54:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726084AbfFTIyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:54:22 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C6AA268F413AB82727B4;
        Thu, 20 Jun 2019 16:54:17 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 20 Jun
 2019 16:54:07 +0800
Subject: Re: [PATCH] staging: erofs: clean up initialization of pointer de
To:     Colin King <colin.king@canonical.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190617125529.28327-1-colin.king@canonical.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <63acf133-b0b5-aafa-6880-bb9517ef6be9@huawei.com>
Date:   Thu, 20 Jun 2019 16:54:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190617125529.28327-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/17 20:55, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently pointer de is being initialized with a value that is
> never read and a few statements later de is being re-assigned. Clean
> this up by ininitialzing de and removing the re-assignment.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
