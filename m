Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D17F5FDB89
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 11:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfKOKij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 05:38:39 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:52679 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbfKOKii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:38:38 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFAVxM7004303;
        Fri, 15 Nov 2019 11:38:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=uNLK9FoUA5Uss+jpUkWda+7Twp6fHYrxsRWlK1dQc7k=;
 b=b3/P3/YJdE5ABYvTu4M/8G5LWbSOHe7NVUIOh0G6nfztZC2PUedEHt9lGZYO/z64cCcA
 jrm3/jIuGq4rDQe+ktiqgc9KTUcQnvvkQ1/3gwVy8hka0bhUsn+LOUBN83tClhNhnljR
 F8x2F+LRJhDcAD8usv0nP8Wef3IylQHfO9sNQ6tWRQVJ7yIOp2qe3LzUOn2N14raSrdv
 UcKQ5jyfn1d5xRbd+9ufED+1xMcpV1fhTm+akC8aFkpxOk3pr8i1JWFFRWoLJwZjEK0B
 btlEIBCmV6qufGQFex6GFCRmiREZQWS/twMyWO5Pvff6FQyFn9aKRp+1dZxo7+wJz74g 5A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w7psbkg4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 11:38:26 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CB3C110002A;
        Fri, 15 Nov 2019 11:38:25 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BC5902B3F87;
        Fri, 15 Nov 2019 11:38:25 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Nov
 2019 11:38:25 +0100
Subject: Re: [PATCH] ARM: dts: stm32: add timers counter support on
 stm32mp157c
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1573031484-18701-1-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <64bc558b-d0d2-5477-7b6e-3399fbcd5bed@st.com>
Date:   Fri, 15 Nov 2019 11:38:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573031484-18701-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_02:2019-11-15,2019-11-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 11/6/19 10:11 AM, Fabrice Gasnier wrote:
> Add counter support on stm32mp157c that provides quadrature encoder on
> timers 1, 2, 3, 4, 5 and 8.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index e0f3d4c6..a4ca23c 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -148,6 +148,11 @@

Applied on stm32-next.

Thanks.
Alex
