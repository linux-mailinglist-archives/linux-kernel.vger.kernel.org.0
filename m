Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29DA3C100
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 03:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390818AbfFKBlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 21:41:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18543 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389168AbfFKBlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 21:41:23 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2BAAF7B73AFA17A6A68B;
        Tue, 11 Jun 2019 09:41:21 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 11 Jun
 2019 09:41:13 +0800
Subject: Re: [PATCH] staging: erofs: make use of DBG_BUGON
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
References: <20190608094918.GA11605@hari-Inspiron-1545>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f35ac2bf-14e2-2fff-cb89-caca4f790298@huawei.com>
Date:   Tue, 11 Jun 2019 09:41:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190608094918.GA11605@hari-Inspiron-1545>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/8 17:49, Hariprasad Kelam wrote:
> DBG_BUGON is introduced and it could only crash when EROFS_FS_DEBUG
> (EROFS developping feature) is on.
> replace BUG_ON with DBG_BUGON.
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
