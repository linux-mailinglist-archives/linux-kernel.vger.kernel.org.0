Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE0DA9D70
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 10:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfIEIqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 04:46:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6681 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730939AbfIEIqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:46:54 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D6B0097C7232F14FB686;
        Thu,  5 Sep 2019 16:46:52 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 16:46:51 +0800
Message-ID: <5D70CB7A.8040307@huawei.com>
Date:   Thu, 5 Sep 2019 16:46:50 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Markus Elfring <Markus.Elfring@web.de>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: drm/amdgpu: remove the redundant null check
References: <1567491305-18320-1-git-send-email-zhongjiang@huawei.com> <62b33279-9ca9-5970-5336-a8511ce54197@web.de> <5D70A196.3020106@huawei.com> <dd351754-cb3a-b19a-64e1-f2f583c2a23a@web.de>
In-Reply-To: <dd351754-cb3a-b19a-64e1-f2f583c2a23a@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/5 16:38, Markus Elfring wrote:
>>> Were any source code analysis tools involved for finding
>>> these update candidates?
>> With the help of Coccinelle. You can find out some example in scripts/coccinelle/.
> Thanks for such background information.
> Was the script “ifnullfree.cocci” applied here?
Yep
> Will it be helpful to add attribution for such tools
> to any more descriptions in your patches?
Sometimes, I will add the description in my patches. Not always.

Thanks,
zhong jiang
> Regards,
> Markus
>
> .
>


