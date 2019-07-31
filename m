Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2689E7B9EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 08:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfGaGsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 02:48:10 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:43242 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbfGaGsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:48:10 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6V6gJi8017316;
        Wed, 31 Jul 2019 08:47:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=702VqZhtTL5oaW1SMZWfTjutuV+GOvsgBWv49RLVlDk=;
 b=E2DL2tW00m7fzvOFNPOJpqKSXh/VtWpzDybK6YydTQ2QDwnQxhbKNtASnG7YHqr0Cffn
 oC2A5s5Ngs5p1QjPeFFPLZl/OXfKEuYtATTllmpD2zYy4KsQT57hv0GTTQ1gn5IzzCu/
 oabO3c1bmeUUkMgiKv1WYx/QTwCx0SA2tT39Jzbe8PcK3eeL54On0/fR6WKnKaRAr1h2
 dFQ9X8D46pkU6/byd3diEBJWU7dEp5+yjgEdi+46BIHcPxUqYiVVRfXYyhdAejpSgmJ1
 oJgfrF7frjYw8an823YbiSsWIRry7gJIMikPEILsMI8n2Ox8tqwesZ7lzzx4NM5RX1tO eA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u0c2yerc3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 08:47:51 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BB3FC31;
        Wed, 31 Jul 2019 06:47:49 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9206A12AD;
        Wed, 31 Jul 2019 06:47:49 +0000 (GMT)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 31 Jul
 2019 08:47:48 +0200
Subject: Re: ARM: multi_v7_defconfig: Enable SPI_STM32_QSPI support
To:     Olof Johansson <olof@lixom.net>,
        Patrice CHOTARD <patrice.chotard@st.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20190729135505.15394-1-patrice.chotard@st.com>
 <CAOesGMg-3xt2qjjZ569pUE+d6tn7nz264AN9ARkBT_Ej4TFC2A@mail.gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <de6ab910-380e-6271-88d8-6fe670525e60@st.com>
Date:   Wed, 31 Jul 2019 08:47:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMg-3xt2qjjZ569pUE+d6tn7nz264AN9ARkBT_Ej4TFC2A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof

On 7/30/19 7:36 PM, Olof Johansson wrote:
> Hi Patrice,
> 
> If you cc soc@kernel.org on patches you want us to apply, you'll get
> them automatically tracked by patchwork.
> 

Does it means that you will take it directly in arm-soc tree ?
I mean, I used to take this kind of patch (multi-v7_defconfig patch 
linked to STM32 driver) in my stm32 branch and to send PR for them.

regards
Alex

> 
> -Olof
> 
> On Mon, Jul 29, 2019 at 3:55 PM <patrice.chotard@st.com> wrote:
>>
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> Enable support for QSPI block on STM32 SoCs.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> ---
>>   arch/arm/configs/multi_v7_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 6a40bc2ef271..78d1d93298af 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -403,6 +403,7 @@ CONFIG_SPI_SH_MSIOF=m
>>   CONFIG_SPI_SH_HSPI=y
>>   CONFIG_SPI_SIRF=y
>>   CONFIG_SPI_STM32=m
>> +CONFIG_SPI_STM32_QSPI=m
>>   CONFIG_SPI_SUN4I=y
>>   CONFIG_SPI_SUN6I=y
>>   CONFIG_SPI_TEGRA114=y
>> --
>> 2.17.1
>>
