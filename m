Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F06F7EDA0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 09:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389969AbfHBHgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 03:36:39 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42021 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726601AbfHBHgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:36:39 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x727VJJx012518;
        Fri, 2 Aug 2019 09:36:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=dNdFBpnmHr57yWOWaZOQqM6cLIxmm15yY5RHlO47mkw=;
 b=n2uaUNmkk6TmujMSGcFYd1PxMzfaQYxVJS1u7h+b2LKKp3xO1AKkBOnKdOlODirELbPq
 OStYdNHcG56tCBok3AwwXvVTcUv+fxLTl9y8h/nDTjGGDbwzMFX+OKWvtOTNRwBsUwHz
 PSDWOAU6DAZyTN12Xz70gYK1lqSnejizUWzCy3jjP/8v+7cUTyNXIBk5QP5iTMoEIbcd
 IXqmPht/XJSsjIIOjDGeRsRJrQ1HJVszrxXoHGYxg80yDFNp5nAYgyLgtOv4KDhP1/5G
 SRDAKqvTQLzs5PI48F7cexIDRrXt+Ftkf4aKeW2SrlqIE97nUKd2b8IUUPHAO2aqLYjo 2w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u3vd05qye-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 02 Aug 2019 09:36:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1386F3A;
        Fri,  2 Aug 2019 07:36:19 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 037D5206862;
        Fri,  2 Aug 2019 09:36:19 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 2 Aug
 2019 09:36:18 +0200
Subject: Re: [PATCH] ARM: dts: stm32: add phy-dsi-supply property on
 stm32mp157c-ev1
To:     =?UTF-8?Q?Yannick_Fertr=c3=a9?= <yannick.fertre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <1564410548-20436-1-git-send-email-yannick.fertre@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <346d04ad-17ed-40c8-f10a-b13a2ea79d92@st.com>
Date:   Fri, 2 Aug 2019 09:36:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564410548-20436-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick

On 7/29/19 4:29 PM, Yannick Fertré wrote:
> The dsi physical layer is powered by the 1v8 power controller supply.
> 
> Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c-ev1.dts | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> index feb8f77..19d69d0 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> @@ -101,6 +101,7 @@
>   &dsi {
>   	#address-cells = <1>;
>   	#size-cells = <0>;
> +	phy-dsi-supply = <&reg18>;
>   	status = "okay";
>   
>   	ports {
> 

Applied on stm32-next.

Thanks.
Alex
