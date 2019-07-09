Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 156416325F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 09:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGIHvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 03:51:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:62964 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbfGIHvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:51:00 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x697fIMC005989;
        Tue, 9 Jul 2019 09:50:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=/DmdBFluf3TNNYk0EQ5Y03piO+O0zI/xncWXtOGKcac=;
 b=P+nWViIidUmuppObGmoj4H4VowV9mJSROGx0hIanQdkFgY9X/9Q4mNFhKSYMf129WOWg
 BUnGr/00pT5Q8nB2AfajhXVLGc41p5UNbuDGArY3UWqg6E/rxIDuZFRyKiiars0JUQ05
 Fpd/mYHI/4OrsAdGMX6uEAO04FGUNlXbvJZF1Iu4UHOGorgaBmPf2nZ8aPcRANomMvc1
 l8xRc7P+xfONcOulMYA8ww5z9yNu+jvJ5Lzk4tvP0pDT66y/xZs84Q6nzcJnYSRCxuS4
 RI+cg9ipLGn6KJcwsKFpAY4epJrvhq/247/r7iD6yRkkATQQD3LNI9VMAcwmdnQ6FPR4 5g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tmh511qy7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Jul 2019 09:50:31 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0E23D34;
        Tue,  9 Jul 2019 07:50:28 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DDEC228B4;
        Tue,  9 Jul 2019 07:50:25 +0000 (GMT)
Received: from [10.201.23.29] (10.75.127.46) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 9 Jul
 2019 09:50:24 +0200
Subject: Re: [PATCH] mtd: rawnand: stm32_fmc2: avoid warnings when building
 with W=1 option
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1561128189-14411-1-git-send-email-christophe.kerello@st.com>
 <20190701091128.4e67f1de@xps13>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <13d30ef8-b649-6416-3814-35a53c5c09ce@st.com>
Date:   Tue, 9 Jul 2019 09:50:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190701091128.4e67f1de@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-09_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/19 9:11 AM, Miquel Raynal wrote:
> Hi Christophe,
> 
> Christophe Kerello <christophe.kerello@st.com> wrote on Fri, 21 Jun
> 2019 16:43:09 +0200:
> 
>> This patch solves warnings detected by setting W=1 when building.
>>
>> Warnings type detected:
>> drivers/mtd/nand/raw/stm32_fmc2_nand.c: In function ‘stm32_fmc2_calc_timings’:
>> drivers/mtd/nand/raw/stm32_fmc2_nand.c:1417:23: warning: comparison is
>> always false due to limited range of data type [-Wtype-limits]
>>    else if (tims->twait > FMC2_PMEM_PATT_TIMING_MASK)
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>> ---
> 
> Applied to nand/next, thanks.

Hi Miquel,

After fetching nand/next, I do not see this patch applied.

Regards,
Christophe Kerello.

> 
> Miquèl
> 
