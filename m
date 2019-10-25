Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDFEE480B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 12:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502286AbfJYKCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 06:02:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11340 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408871AbfJYKCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:02:43 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9P9kCWW017181;
        Fri, 25 Oct 2019 12:02:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=L3mtGVkYrQhlA9oMyG4z+zFmzlcb+vI8GVGs4DcezXs=;
 b=A/OkVqFKWSxzuT+sF0tIFGtEkqXmPoLwQtuOihl0MJVjs9tdkR2msDxWM7yGkuXgdY8f
 3Kv2FPd7fLkdjubQDxGSIqSqV2yPauoXLytDspg3Iu3k/C0Sg18HcElk+y7WVloHKW62
 1c7NUUyJ8ZowVKZQek3JHZHt36yECnPDyOtNEX9A17xonUqOM8cr/4Yh7Mle3o0iGf90
 CKLr6yhv8ZNde6oFi5j3DNRpUhC63pIoEtXUji1hOsLHx7qc/Asl23EQo+/j1bxVp81C
 jBsIdZKsd1lsqrd65MFVJadXf9T43P+imE0/UdHGdgyBre7JQ4ucGYkZwyEwj2uiXUtZ bA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vt9s5706c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 12:02:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A2E1B10002A;
        Fri, 25 Oct 2019 12:02:33 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 960CB2C2E84;
        Fri, 25 Oct 2019 12:02:33 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 25 Oct
 2019 12:02:32 +0200
Subject: Re: [PATCH] ARM: dts: stm32f469: remove useless interrupt from dsi
 node
To:     Benjamin Gaignard <benjamin.gaignard@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191011130658.23670-1-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <a2a82d35-100f-40c3-0827-c110ac37a02f@st.com>
Date:   Fri, 25 Oct 2019 12:02:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011130658.23670-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-25_05:2019-10-23,2019-10-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin

On 10/11/19 3:06 PM, Benjamin Gaignard wrote:
> DSI driver doesn't use interrupt, remove it from the node since it
> breaks yaml check.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   arch/arm/boot/dts/stm32f469.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32f469.dtsi b/arch/arm/boot/dts/stm32f469.dtsi
> index 5ae5213f68cb..be002e8a78ac 100644
> --- a/arch/arm/boot/dts/stm32f469.dtsi
> +++ b/arch/arm/boot/dts/stm32f469.dtsi
> @@ -8,7 +8,6 @@
>   		dsi: dsi@40016c00 {
>   			compatible = "st,stm32-dsi";
>   			reg = <0x40016c00 0x800>;
> -			interrupts = <92>;
>   			resets = <&rcc STM32F4_APB2_RESET(DSI)>;
>   			reset-names = "apb";
>   			clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>;
> 

Applied on stm32-next. For the next time commit header has to be 
formatted like that:

ARM: dts: stm32: .....

Thanks.
Alex
