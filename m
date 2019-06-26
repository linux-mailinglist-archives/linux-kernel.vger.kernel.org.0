Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12263562EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 09:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfFZHNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 03:13:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbfFZHNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:13:48 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C9EE18BFD69C7550F6E3;
        Wed, 26 Jun 2019 15:13:43 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Jun
 2019 15:13:36 +0800
Subject: Re: [PATCH RESEND] staging: erofs: remove unsupported ->datamode
 check in fill_inline_data()
To:     Yue Hu <zbestahu@gmail.com>, <gaoxiang25@huawei.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <huyue2@yulong.com>
References: <20190626032831.7252-1-zbestahu@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <654721e9-fdca-f21f-c244-9e9c8c421f4b@huawei.com>
Date:   Wed, 26 Jun 2019 15:13:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190626032831.7252-1-zbestahu@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/26 11:28, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Already check if ->datamode is supported in read_inode(), no need to check
> again in the next fill_inline_data() only called by fill_inode().
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
