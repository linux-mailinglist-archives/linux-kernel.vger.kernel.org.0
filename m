Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5B6167E4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfEGQ3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 12:29:13 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44722 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfEGQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:29:13 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x47GTA7X052626;
        Tue, 7 May 2019 11:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557246550;
        bh=latJPCxVxOxnoJw3g8qf+igWGVV+JWgQnCwSGe3528U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TsSFG7123AzOLIdTitWrYvQq+NzgVdq6UmN7UBQpRzB1SPDXZpLnmL+C+TPbT7kYS
         NaDL7Gc6/5bA7+dOAtfuGxaQ/TmSrOBb5+Br5RpFWW305ZJUPKNRmUq+WbgUCsChV7
         pxolKG/lrWp5j7Ybaf5HPF7lb0Cx9hhDf4XZvKuw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x47GTAmW125852
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 May 2019 11:29:10 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 7 May
 2019 11:29:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 7 May 2019 11:29:10 -0500
Received: from [10.250.139.87] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x47GT75O007955;
        Tue, 7 May 2019 11:29:08 -0500
Subject: Re: [PATCH 1/2] mmc: sdhci_am654: Fix minor phy configurations
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>
References: <20190425155727.20010-1-faiz_abbas@ti.com>
 <20190425155727.20010-2-faiz_abbas@ti.com>
 <8317e8a0-1b1f-4b0d-8a9b-2a6fdd0ab4e5@intel.com>
From:   Faiz Abbas <a0230074@ti.com>
Message-ID: <2c867970-1255-b11f-9edf-ff002b7cea58@ti.com>
Date:   Tue, 7 May 2019 21:59:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8317e8a0-1b1f-4b0d-8a9b-2a6fdd0ab4e5@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 26/04/19 11:20 AM, Adrian Hunter wrote:
> On 25/04/19 6:57 PM, Faiz Abbas wrote:
>> Fix the following minor things:
>>
>> 1. Line wrapping with the regmap_*() functions is way more conservative
>> than required by the 80 character rule. Expand the function calls out to
>> use less number of lines.
>>
>> 2. Add an error message if the DLL fails to lock.
> 
> Please make the white space changes a separate patch.
> 
> Also I would prefer not to use "fix" in the subject unless the patch fixes
> driver behaviour.
> 

Ok. Two different patches. No "fix" in the subject. Sending v2.

Thanks,
Faiz
