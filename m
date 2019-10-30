Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF99AE9506
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 03:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfJ3CeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 22:34:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfJ3CeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 22:34:01 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 72FD0B1E863A346FBC17;
        Wed, 30 Oct 2019 10:33:56 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 30 Oct
 2019 10:33:48 +0800
Subject: Re: [PATCH v5] erofs: support superblock checksum
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Pratik Shinde <pratikshinde320@gmail.com>,
        <linux-erofs@lists.ozlabs.org>
CC:     Gao Xiang <xiang@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191028134405.GA186556@architecture4>
 <20191028143202.133428-1-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d604526a-70dd-0a44-f001-33c84be99084@huawei.com>
Date:   Wed, 30 Oct 2019 10:33:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191028143202.133428-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/28 22:32, Gao Xiang wrote:
> From: Pratik Shinde <pratikshinde320@gmail.com>
> 
> Introduce superblock checksum feature in order to verify
> a number of given blocks at mounting time.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
