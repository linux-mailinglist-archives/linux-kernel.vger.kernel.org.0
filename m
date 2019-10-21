Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 104D7DE642
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 10:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfJUIXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 04:23:51 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:57276 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfJUIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:23:51 -0400
Received: from [10.18.29.227] (10.18.29.227) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 21 Oct
 2019 16:23:57 +0800
Subject: Re: [PATCH] mmc: fix mmc dma operation
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
CC:     Nan Li <nan.li@amlogic.com>, Jerome Brunet <jbrunet@baylibre.com>,
        <linux-amlogic@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Victor Wan <victor.wan@amlogic.com>
References: <1571637541-119016-1-git-send-email-jianxin.pan@amlogic.com>
 <fc1f61e1-b156-11e6-3f21-c498d2f0a8c6@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <a322d35b-28de-acb9-842c-ac64ba40e9b8@amlogic.com>
Date:   Mon, 21 Oct 2019 16:23:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fc1f61e1-b156-11e6-3f21-c498d2f0a8c6@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.227]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Thanks for the review, I will update the subject and commit message in the next version.

On 2019/10/21 15:57, Neil Armstrong wrote:
> Hi,
> 
> Thanks for the fix.
> 
> First, you should add "mmc: meson-gx:" in the subject.
> 
> On 21/10/2019 07:59, Jianxin Pan wrote:
>> From: Nan Li <nan.li@amlogic.com>
>>
>> In MMC dma transfer, the region requested by dma_map_sg() may be released
>> by dma_unmap_sg() before the transfer is completed.
>>
>> Put the unmap operation in front of mmc_request_done() to avoid this.
> 
> 
> You should add a "Fixes:" tag so it can be backported on stable kernels.
> 
>>
>> Signed-off-by: Nan Li <nan.li@amlogic.com>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
[...]
>>  }
>>  
>>  static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
>>
> Neil
> 
> .
> 

