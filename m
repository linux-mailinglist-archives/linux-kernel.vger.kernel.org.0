Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2226C8B821
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 14:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfHMMKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 08:10:07 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48290 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfHMMKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:10:06 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7DC9su1053904;
        Tue, 13 Aug 2019 07:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565698194;
        bh=cTM7S2PLpa3mnQ4eBvwPzdCvn8W5H1f6uFiW2fuHzLE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IwVoj/JJDYlvqMb88DXh1W4/LfS9IGheVUuU65L6FAgfn8e7qrdz7e/DjCyJFluLZ
         /4aDQ6gpwuTf+EYGnXRlcXzzOpUvzIO0WBWa4hcUclDsGloytKPIsIvBwRLc6dFkKX
         p4YfaSxpYzgqAkpPQKruHi/jYXrxN0jNay5ncj8Y=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7DC9sGS071766
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Aug 2019 07:09:54 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 13
 Aug 2019 07:09:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 13 Aug 2019 07:09:54 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7DC9pug081737;
        Tue, 13 Aug 2019 07:09:52 -0500
Subject: Re: [PATCH] soc: ti: pm33xx: Fix static checker warnings
To:     Tony Lindgren <tony@atomide.com>
CC:     <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>,
        <d-gerlach@ti.com>, <dan.carpenter@oracle.com>
References: <20190626075014.2911-1-j-keerthy@ti.com>
 <20190813120453.GW52127@atomide.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <e66d31bb-1e03-919a-184f-32a1a5124009@ti.com>
Date:   Tue, 13 Aug 2019 17:40:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813120453.GW52127@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/08/19 5:34 PM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [190626 00:50]:
>> The patch fixes a bunch of static checker warnings.
> 
> Sorry I just noticed that this one is still pending, applying
> into fixes.

Thanks Tony

> 
> Tony
> 
