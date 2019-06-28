Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 926AF59289
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 06:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfF1EUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 00:20:41 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58032 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF1EUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:20:41 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5S4KVjm018708;
        Thu, 27 Jun 2019 23:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561695631;
        bh=TggwOrOTARuDtQhTBOdx51iLtk8dv+A5tcd4Av8NBIo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lZ4TQX3BK1DsDgiM5OthOhR5qruh8OVsmip+8T8aIMQm3wgLIP3BCSK+wj96InK1c
         oHRgqo35JXn7Xx1AaFxcqCyMf/rwIRc3V6EEnRPJPRv+RTvnK/rEcbX7W7oTn4/uPI
         2vQzkeIlCOeh5OZyjYDm4lhgd8K/0EzE3SG++zLE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5S4KVP7023809
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jun 2019 23:20:31 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 27
 Jun 2019 23:20:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 27 Jun 2019 23:20:31 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5S4KSZx120807;
        Thu, 27 Jun 2019 23:20:29 -0500
Subject: Re: [PATCH 00/10] crypto: k3: Add sa2ul driver
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <t-kristo@ti.com>, <nm@ti.com>
References: <20190618120843.18777-1-j-keerthy@ti.com>
 <20190628041939.7yduk77x62twath6@gondor.apana.org.au>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <df7aab2c-bc4d-1390-4cbb-550873f33705@ti.com>
Date:   Fri, 28 Jun 2019 09:51:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628041939.7yduk77x62twath6@gondor.apana.org.au>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/06/19 9:49 AM, Herbert Xu wrote:
> On Tue, Jun 18, 2019 at 05:38:33PM +0530, Keerthy wrote:
>> The series adds Crypto hardware accelerator support for SA2UL.
>> SA2UL stands for security accelerator ultra lite.
> 
> Please cc linux-crypto@vger.kernel.org.

Okay. I will do that.

> 
> Thanks,
> 
