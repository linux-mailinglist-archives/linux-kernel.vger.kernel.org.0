Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C7218E479
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 21:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgCUUaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 16:30:02 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54496 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgCUUaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 16:30:02 -0400
Received: by mail-pj1-f65.google.com with SMTP id np9so4122544pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 13:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yQE1AGuPuSquTWhE+3+C/nBZtIGBtGuN9+H3HNtBPO4=;
        b=onoovAOqdnHVRsn+D2keLQnUIEXz3fTCxc3cksfVs1zkhu6Vdw8KpjxT6twmbTppwt
         LiZsjy65KFeJalVJfVLzWar6TXUbhOtml6ZyhcTMwc2YhaArKrHhlcULFDAp1aBIPanB
         i6BAT85NkErgBonyqGqRDlbdaBOw9/l8ASyRluZ8jAQoOG+wUwa5fIkbRwgsmwzsyjXB
         60W+PR7D80ZcGQwPrGlgm2tc3oXWoRBqtRHR8l5tVnOfuiX13cOM33maG6HqmbZnHBg2
         EL/j2etChh6dpRxHmVZVnfw2R4aOwpeueag239BNhc45g6EdvlY6juYW2mKEpFrFsSI8
         fd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yQE1AGuPuSquTWhE+3+C/nBZtIGBtGuN9+H3HNtBPO4=;
        b=NbhLtbtMXRgOrfekVCsEkTAwQpljDkcas0zh70TgVdcmBw4V7ftfgMs0zlGwFHXhsC
         uKjpadUS4RWbPlMdOhmoCh6eTRlTuNbaAi5sZHQNqTxeQhhQ1hYrEwp9/NdKbSXIbNzj
         pxlbUCNBmi9P+aztWifnVomUP8FHSFZWZWx6sgZg2P0Vr8P2S+Q0+vKZyUolYIsDblTZ
         UgG3S7TKYK1PQVIp889qBkF6nhba52Zs3OHqpoM5LOUl4VWAkd/qNQams2pSdxWqI99q
         ZGm8XNA2cUxC+nPu5Jhajc2O9H4xj9FqL0jO/HRltdDzrZz0xRfWLgl6x059QdUNhUbE
         OFPA==
X-Gm-Message-State: ANhLgQ3ghbnOUTHLGk+k17BPZcPeCb3I55ZcMPMmczqArREeJDAjoBI7
        +lcFoEnR3BR2nl+8SLLAzQwQgQ==
X-Google-Smtp-Source: ADFU+vtUmqZZZVxes1ZaCw/2dVpYE55mRIa/+emJV6bikExnLRHzXdQZYPtBfcwkAkkR+6uwQRUENw==
X-Received: by 2002:a17:90a:c396:: with SMTP id h22mr16833567pjt.128.1584822599958;
        Sat, 21 Mar 2020 13:29:59 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y30sm9353091pff.67.2020.03.21.13.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 13:29:59 -0700 (PDT)
Subject: Re: [PATCH V3] block, bfq: fix use-after-free in
 bfq_idle_slice_timer_body
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>, paolo.valente@linaro.org
Cc:     linux-block <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, yanxiaodan@huawei.com,
        "wubo (T)" <wubo40@huawei.com>, renxudong <renxudong1@huawei.com>,
        Louhongxiang <louhongxiang@huawei.com>, linfeilong@huawei.com,
        wangwang2@huawei.com
References: <da33586a-6fc1-0708-e86d-b09e349200f8@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1052be18-ef45-e254-e1bb-09a7cd6d891f@kernel.dk>
Date:   Sat, 21 Mar 2020 14:29:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <da33586a-6fc1-0708-e86d-b09e349200f8@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/20 5:18 AM, Zhiqiang Liu wrote:
> 
> In bfq_idle_slice_timer func, bfqq = bfqd->in_service_queue is
> not in bfqd-lock critical section. The bfqq, which is not
> equal to NULL in bfq_idle_slice_timer, may be freed after passing
> to bfq_idle_slice_timer_body. So we will access the freed memory.
> 
> In addition, considering the bfqq may be in race, we should
> firstly check whether bfqq is in service before doing something
> on it in bfq_idle_slice_timer_body func. If the bfqq in race is
> not in service, it means the bfqq has been expired through
> __bfq_bfqq_expire func, and wait_request flags has been cleared in
> __bfq_bfqd_reset_in_service func. So we do not need to re-clear the
> wait_request of bfqq which is not in service.

Applied, thanks.

-- 
Jens Axboe

