Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D94CA27F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 16:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfEWOPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 10:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730890AbfEWOPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:15:09 -0400
Received: from [192.168.0.101] (unknown [58.212.135.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87BD1217D4;
        Thu, 23 May 2019 14:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558620908;
        bh=qwqlp4bdgNAL+XXJWyRakX+x/x/fQQBKtG0R3j4UKuE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XTxxRgdeWMni1dVmxaHBtbu+ZdPMPvWGQZTzIflHd6RDFyPy8RAFJg32tFRfnv+ET
         IWvNveyS49xlC/6ZEX1+KLtZ9xIqSjLnfqlZSAY3W3ZnvGTgFOrJTsdBZlYRZZIqUJ
         bc64AGFAz6qMS/SHOdfaeMjgKFf9DKvy65YCah8I=
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add missing sysfs entries in
 documentation
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20190521180606.10461-1-jaegeuk@kernel.org>
 <20190522175035.GB81051@jaegeuk-macbookpro.roam.corp.google.com>
 <14672901-54a2-120f-a2ce-52f7d6fb3008@kernel.org>
 <20190523140649.GA10954@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <fc1eda2c-1d31-749f-03ef-eed152fb42c0@kernel.org>
Date:   Thu, 23 May 2019 22:14:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190523140649.GA10954@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-5-23 22:06, Jaegeuk Kim wrote:
> On 05/23, Chao Yu wrote:
>> On 2019-5-23 1:50, Jaegeuk Kim wrote:
>>> This patch cleans up documentation to cover missing sysfs entries.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>>> + reserved_blocks	      This parameter indicates the number of blocks that
>>> +			      f2fs reserves internally for root.
>>> +
>>
>> I mean we can move below entry here.
> 
> Ah, I'd like to keep the order defined in sysfs.c.

No problem. :)

Thanks,

> 
>>
>> current_reserved_blocks	      This shows # of blocks currently reserved.
>>
>>> + reserved_blocks	      This shows # of blocks currently reserved.
>>
>> Thanks,
