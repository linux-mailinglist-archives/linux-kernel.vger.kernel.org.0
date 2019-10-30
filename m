Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E48FE992D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 10:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfJ3Jbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 05:31:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfJ3Jbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:31:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4F3B979BCF39E7193C8F;
        Wed, 30 Oct 2019 17:31:49 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 30 Oct 2019
 17:31:44 +0800
Message-ID: <5DB9587F.8050705@huawei.com>
Date:   Wed, 30 Oct 2019 17:31:43 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <akinobu.mita@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fault-inject: use DEFINE_DEBUGFS_ATTRIBUTE to define
 debugfs fops
References: <1572423756-59943-1-git-send-email-zhongjiang@huawei.com> <20191030091051.GA634735@kroah.com>
In-Reply-To: <20191030091051.GA634735@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/30 17:10, Greg KH wrote:
> On Wed, Oct 30, 2019 at 04:22:36PM +0800, zhong jiang wrote:
>> It is more clear to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
>> operation rather than DEFINE_SIMPLE_ATTRIBUTE.
> Why does this matter?  What does this change?  You are changing how some
> of the file reference counting works now, are you sure this is ok?
I think that it is more correct to use DEFINE_DEBUGFS_ATTRIBUTE(), since they are debugfs attrs.
It is designed and defined for debugfs fops.  

Of course,  Use DEFINE_SIMPLE_ATTRIBUTE here  to define debugfs attrs is feasible  functionally.

Thanks,
zhong jiang
> thanks,
>
> greg k-h
>
> .
>


