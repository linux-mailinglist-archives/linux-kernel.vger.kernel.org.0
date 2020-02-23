Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4276F1695D0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 05:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgBWEVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 23:21:31 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:60286 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726983AbgBWEVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 23:21:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TqdtHoh_1582431686;
Received: from 30.27.235.101(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TqdtHoh_1582431686)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 23 Feb 2020 12:21:28 +0800
Subject: Re: [PATCH] crypto: sm3 - export crypto_sm3_final function
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, ebiggers@kernel.org, pvanleeuwen@rambus.com,
        zohar@linux.ibm.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, gilad@benyossef.com
References: <20200216090233.109416-1-tianjia.zhang@linux.alibaba.com>
 <20200222011926.GA18695@gondor.apana.org.au>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <8acc79e8-8b3d-856d-06d2-5322c9a66be9@linux.alibaba.com>
Date:   Sun, 23 Feb 2020 12:21:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200222011926.GA18695@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/2/22 9:19, Herbert Xu wrote:
> On Sun, Feb 16, 2020 at 05:02:33PM +0800, Tianjia Zhang wrote:
>> Both crypto_sm3_update and crypto_sm3_finup have been
>> exported, exporting crypto_sm3_final, to avoid having to
>> use crypto_sm3_finup(desc, NULL, 0, dgst) to calculate
>> the hash in some cases.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   crypto/sm3_generic.c | 7 ++++---
>>   include/crypto/sm3.h | 2 ++
>>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> Please add this into the series that actually uses the function.
> It makes no sense on its own.
> 
> Thanks,
> 

The actual use of this function is in sm2 and OSCCA certificates. This 
set of patches has been submitted to the community. Please review them.
