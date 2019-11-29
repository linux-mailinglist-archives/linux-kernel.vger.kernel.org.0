Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 894B810D777
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 15:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfK2OwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 09:52:10 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:52525 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726843AbfK2OwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:52:10 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATEl2rW015649;
        Fri, 29 Nov 2019 15:51:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=g8lD3rtdXNrCg147P/vL/OTbncUOSvc26kNNxIEODlU=;
 b=kcjurm5sWToNx0YxGPewWYGHrO6fGpUyf6fVE3BiBVSse71WSxfWao+4zlxicrc4hVXw
 4/2x6utimcqGQPR0/QULgoj2VHX4b2+inZ5O1MGFNWOsUvYjH9kEmtQxk4pFra33P31n
 gMZtS+MnVpo9AvHicIdyxUrN8lopXOiCZuqsNzjTV1XAV/RG2lGF9Oy22/Bb1AQHxAUa
 KnFryJpdfh7UaI9YmZW/54NYzzBO5sHroCSyXnZ5AXPY0JHcb6MlB5zVCgEOaaUYTLMq
 tR4Ytc2/IL1LnhMwgp+s3kjw0a3GpCiKeByP5nxenR/LmY7zY8ynZBC0mDU8csL/g/P6 TA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2whcxjg1nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 15:51:51 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 778B310002A;
        Fri, 29 Nov 2019 15:51:49 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4622B2B9FAF;
        Fri, 29 Nov 2019 15:51:49 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 29 Nov
 2019 15:51:48 +0100
Subject: Re: [PATCH 5/6] ARM: dts: stm32: Adapt STM32MP157 DK boards to stm32
 DT diversity
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20191120144109.25321-1-alexandre.torgue@st.com>
 <20191120144109.25321-6-alexandre.torgue@st.com>
 <CAK8P3a2Bg9KwfEqEE3_NUHxVv=svFGuj--Tnq-w-xFg63cfqAA@mail.gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <92be0a67-c0ed-23bd-08f3-73f71d8bfc3f@st.com>
Date:   Fri, 29 Nov 2019 15:51:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2Bg9KwfEqEE3_NUHxVv=svFGuj--Tnq-w-xFg63cfqAA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_04:2019-11-29,2019-11-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/19 3:20 PM, Arnd Bergmann wrote:
> On Wed, Nov 20, 2019 at 3:41 PM Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
>>
>> To handle STM32MP15 SOCs diversity, some updates have to been done.
>> This commit mainly adapt dk1 board to include the correct package and the
>> correct SOC version. A new file has been created to factorize common parts.
>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
>>
>> diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
>> index 3f869bd67082..1292ac3b6890 100644
>> --- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
>> +++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
>>          model = "STMicroelectronics STM32MP157A-DK1 Discovery Board";
>>          compatible = "st,stm32mp157a-dk1", "st,stm32mp157";
>> -
>> -       aliases {
>> -               ethernet0 = &ethernet0;
>> -               serial0 = &uart4;
>> -       };
>> -
>> -       chosen {
>> -               stdout-path = "serial0:115200n8";
>> -       };
>> -
> 
> As a rule, I would leave aliases and chosen nodes in the .dts file and not
> move them into a shared .dtsi, since they tend to be board specific.
> 
> (even if that may not be the case in this particular file)

I agree, I'll move them in V2.

Thanks
Alex

> 
>        Arnd
> 
