Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A759BBEAEE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 05:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391698AbfIZDo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 23:44:27 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:18333 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391561AbfIZDo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 23:44:27 -0400
Received: from [10.28.19.63] (10.28.19.63) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 26 Sep
 2019 11:44:25 +0800
Subject: Re: [PATCH v2 3/3] reset: add support for the Meson-A1 SoC Reset
 Controller
To:     Kevin Hilman <khilman@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1569227661-4261-1-git-send-email-xingyu.chen@amlogic.com>
 <1569227661-4261-4-git-send-email-xingyu.chen@amlogic.com>
 <7hlfucrnlo.fsf@baylibre.com>
From:   Xingyu Chen <xingyu.chen@amlogic.com>
Message-ID: <85eeda38-f04f-71d7-3c45-bc03e8c13953@amlogic.com>
Date:   Thu, 26 Sep 2019 11:44:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7hlfucrnlo.fsf@baylibre.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.19.63]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kevin
Thanks for your reminder

On 2019/9/26 6:57, Kevin Hilman wrote:
> Hi Xingyu,
> 
> Xingyu Chen <xingyu.chen@amlogic.com> writes:
> 
>> The number of RESET registers and offset of RESET_LEVEL register for
>> Meson-A1 are different from previous SoCs, In order to describe these
>> differences, we introduce the struct meson_reset_param.
>>
>> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Again, order here isn't quite right.  Add the reviewed-by tags first,
> and the sender should be the last sign-off.
I will reorder Signed-off and Reviewed in next version
> 
> Other than that, driver looks good.
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com >
> Kevin
> 
> .
> 
