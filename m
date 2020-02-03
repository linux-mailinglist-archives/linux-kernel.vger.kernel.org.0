Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD4C1502AF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 09:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBCIfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 03:35:51 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34486 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgBCIfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:35:50 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0138ZcL0009609;
        Mon, 3 Feb 2020 02:35:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580718939;
        bh=1PMMDpp6XSqR9WhBph6lQ2FGqfnPABFZhmuwEKRj1ms=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=r0TVpkHDXmlJkbqH8GwxZfFQyOsSIC6G9WUWLNdWiCveKA3CiusHofUW9YMXisBOO
         /PPehsI1dJ+q5+r9YWpiBr3MzktC0+lsSDVfTzvcxJ206gOkEcSapKRCdPM4R/XUNI
         Ux7wCHpd73tjGth0jEmJCE+Yi00jYdn2Dg/zvUlE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0138Zce1064333
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Feb 2020 02:35:38 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 3 Feb
 2020 02:35:38 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 3 Feb 2020 02:35:38 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0138ZZGl119265;
        Mon, 3 Feb 2020 02:35:36 -0600
Subject: Re: [PATCH] firmware: ti_sci: Export devm_ti_sci_get_of_resource for
 modules
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <nm@ti.com>,
        <ssantosh@kernel.org>, <santosh.shilimkar@oracle.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>
References: <20200122104031.15733-1-peter.ujfalusi@ti.com>
 <88323f5b-1732-f780-5a0d-754026997c2c@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <da988700-d7de-ae81-01d2-6bb5d9fa5985@ti.com>
Date:   Mon, 3 Feb 2020 10:35:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <88323f5b-1732-f780-5a0d-754026997c2c@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2020 10:10, Peter Ujfalusi wrote:
> Hi,
> 
> On 22/01/2020 12.40, Peter Ujfalusi wrote:
>> Allow devm_ti_sci_get_of_resource() to be usable from modules.

This one looks fine to me, so:

Acked-by: Tero Kristo <t-kristo@ti.com>

> 
> I would really appreciate if ti_sci maintainers would spare some time on
> this and the other two patch ;)
> 
> https://lore.kernel.org/lkml/20200122104044.15837-1-peter.ujfalusi@ti.com/
> https://lore.kernel.org/lkml/20200122104009.15622-1-peter.ujfalusi@ti.com/
> 
> - Péter
> 
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>   drivers/firmware/ti_sci.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
>> index f13e4a96f3b7..3d8241cb6921 100644
>> --- a/drivers/firmware/ti_sci.c
>> +++ b/drivers/firmware/ti_sci.c
>> @@ -3332,6 +3332,7 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
>>   
>>   	return ERR_PTR(-EINVAL);
>>   }
>> +EXPORT_SYMBOL_GPL(devm_ti_sci_get_of_resource);
>>   
>>   static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
>>   				void *cmd)
>>
> 
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
