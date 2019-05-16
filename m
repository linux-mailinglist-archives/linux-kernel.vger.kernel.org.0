Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F872208A3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 15:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfEPNyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 09:54:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60350 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEPNyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:54:20 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4GDsI1B101931;
        Thu, 16 May 2019 08:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558014858;
        bh=PXmqsDgOHC1zgJUNXKBZ/4xKuKk2v9nWZpRfx6nu53w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=v9VjY2+XiIcwuFCCkFM6ejYKHcZuG3UV+6wl57FdsxQdSWaTEhl0nwCcZ8IAt7yZe
         +EzpBE55c8DJxiN4YBhwsluZNzXvr3YkM7jC4zBlLi07LsypmHEBHM3oTSqmGUC9lS
         yE95P8QoHeSQ5xidrtIgME4B8Z2tluMnhooHOOjM=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4GDsIKq101262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 May 2019 08:54:18 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 16
 May 2019 08:54:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 16 May 2019 08:54:17 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4GDsFbt069321;
        Thu, 16 May 2019 08:54:16 -0500
Subject: Re: [PATCH RFT] regulator: tps6507x: Fix boot regression due to
 testing wrong init_data pointer
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, Adam Ford <aford173@gmail.com>
References: <20190516124808.3335-1-axel.lin@ingics.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <1d73f4fe-c343-ef57-757d-ff535e1b76c0@ti.com>
Date:   Thu, 16 May 2019 19:24:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516124808.3335-1-axel.lin@ingics.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/19 6:18 PM, Axel Lin wrote:
> A NULL init_data once incremented will lead to oops, fix it.
> 
> Fixes: f979c08f7624 ("regulator: tps6507x: Convert to regulator core's simplified DT parsing code")
> Reported-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Sekhar,
> Please check if this patch works, thanks.
> Axel

Boot is fine now and PMIC regulator rail microvolts readings from sysfs
are correct as well. I did not try to change the voltages though.

Tested-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
