Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC3A24C92
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 12:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEUKWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 06:22:18 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36139 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbfEUKWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:22:17 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4LAC0jl012556;
        Tue, 21 May 2019 12:22:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=uBeTxmf+H4C1rTAhfKgga+Zi5F1l6OoU1pJr8tM6Vkw=;
 b=rfNoC2Oq1Jrf+4wUp+9/dXRC+gN5yQWchGC1N7jqWp5ZLRTH2Uo3GAV3B9liim8ihTaI
 WNmwmu7hIW+SlHUBzC3ROixRqzRjJ/id/M44gp6wnXUmhnvFIEKcrZff/N8y0FhXY4Cq
 Tns0q54stxItIPQprzVsO/ftovA+HHZbHoR4ETl053LF9UbdAkAqZb6kzRNb9lhySzS3
 CpuOsSr0UTDPYJY5QWSsvXECNJ+pGtUHP8b0ZKDvAUj3hTVR0KnyC4NlAxzJ8LTV9TaL
 64LhytZtpsuddaooSGJAvmFWy9iXpU7e10n9D91LpwT3iqxFn4mHNtROPeMkqFR5XItE Ww== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sj7tu0qsj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 May 2019 12:22:06 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2713334;
        Tue, 21 May 2019 10:22:06 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 05B862649;
        Tue, 21 May 2019 10:22:06 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 21 May
 2019 12:22:05 +0200
Subject: Re: [PATCH v1 0/2] enable display on stm32mp157c-dk1 board
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
References: <1553863438-6720-1-git-send-email-yannick.fertre@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <5864f09f-4cd3-cadc-2210-4946142e582d@st.com>
Date:   Tue, 21 May 2019 12:22:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553863438-6720-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick

On 3/29/19 1:43 PM, Yannick Fertré wrote:
> Enable display on stm32mp157c-dk1 board. I2c node must be created first.
> 
> Yannick Fertré (2):
>    ARM: dts: stm32: Add I2C 1 and 4 config for stm32mp157a-dk1
>    ARM: dts: stm32: enable display on stm32mp157c-dk1 board
> 
>   arch/arm/boot/dts/stm32mp157a-dk1.dts | 78 +++++++++++++++++++++++++++++++++++
>   1 file changed, 78 insertions(+)
> 
> --
> 2.7.4
> 

Series applied on stm32-next.

Regards
Alex
