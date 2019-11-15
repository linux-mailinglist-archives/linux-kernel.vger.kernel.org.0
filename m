Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42667FDE97
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 14:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfKONKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 08:10:34 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51151 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727223AbfKONKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:10:33 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFD2Pcu022731;
        Fri, 15 Nov 2019 14:10:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=9rmwto7fOBN39SiXRHKuxkPMdmv3HZGhG7BMLDLWBXs=;
 b=it38MDpuYDLhG6jamaFeoXmLhqluiQEOXdJsj4ujecEVyW1onH6GHGQ0bekhkvwenlC4
 07uZCgXKkx0GLS3DG1SG02fFxmzQtNHs9MuK4Pz5TXoWmcKAbNlOHN2BCJldDEnqfjYb
 uXeHsmFKaavG/nAr+2Y49GmfOCN/KXhigkGF+vFFfxlKV30IEGZpMmkEORjZgaCbBnBK
 7T+hNMNL/xLdxrYWhIiwegLkhRGLrADw5ZA0YRiMyk6vGHQCXaMwJpJbndNQoM4uRsik
 CGA/8J750EcqctHJBrNmWyQdDKL1skR0tht2fjjbDjpTADlGZIlPuTmLczGgdHAu7GfY 3g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w7psbm8hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 14:10:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ED50910002A;
        Fri, 15 Nov 2019 14:10:19 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D6A6F2BC106;
        Fri, 15 Nov 2019 14:10:19 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Nov
 2019 14:10:19 +0100
Subject: Re: [PATCH 0/2] Add support for ADC on stm32mp157c-ed1
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1573231059-395-1-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <54a1b172-df71-0fec-cd40-e974dc70af34@st.com>
Date:   Fri, 15 Nov 2019 14:10:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573231059-395-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_03:2019-11-15,2019-11-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 11/8/19 5:37 PM, Fabrice Gasnier wrote:
> This series adds support for digital-to-analog converter on
> stm32mp157c-ed1 board:
> - define pins that can be used for ADC
> - configure ADC channels to use these
> 
> Fabrice Gasnier (2):
>    ARM: dts: stm32: add ADC pins used for stm32mp157c-ed1
>    ARM: dts: stm32: add ADC support to stm32mp157c-ed1
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi |  6 ++++++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts     | 16 ++++++++++++++++
>   2 files changed, 22 insertions(+)
> 
Series applied on stm32-next.

Regards
Alex
