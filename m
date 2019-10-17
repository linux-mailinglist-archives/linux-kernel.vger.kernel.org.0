Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6307EDAED3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 15:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437261AbfJQNzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 09:55:45 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35274 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfJQNzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:55:45 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9HDtgnN110592;
        Thu, 17 Oct 2019 08:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571320542;
        bh=C776Kapi3cWTibCH4Brb0rSRcF7BNdlCJgOlAUvhd1c=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=PaZ8FAXMxknrb0WnqgtIp0VotCtpUgrn5aMnO9tjNJRqkvKAr1fPTi5W3t9hBInS9
         Zph/OOhGCWGZhGMG5YlK0uuKP5L1pjCUgtH7Y/MC1Or2SGv3fcAjWMIxEdisnxfigi
         o3G0X3uBS6cbat6EwBvErswPKNJpVFIfSCbFBBRI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9HDtgVF023638
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Oct 2019 08:55:42 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 17
 Oct 2019 08:55:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 17 Oct 2019 08:55:34 -0500
Received: from [172.24.190.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9HDtdDG103976;
        Thu, 17 Oct 2019 08:55:41 -0500
Subject: Re: [PATCH] ARM: davinci: dm644x-evm: Add Fixed regulators needed for
 tlv320aic33
From:   Sekhar Nori <nsekhar@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <bgolaszewski@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190830102308.22586-1-peter.ujfalusi@ti.com>
 <e6a03603-a901-56a8-c8ad-d528f2d51595@ti.com>
Message-ID: <4160082f-2f52-aa96-b280-abb5c53cc12e@ti.com>
Date:   Thu, 17 Oct 2019 19:25:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e6a03603-a901-56a8-c8ad-d528f2d51595@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/19 4:37 PM, Sekhar Nori wrote:
> On 30/08/19 3:53 PM, Peter Ujfalusi wrote:
>> The codec driver needs correct regulators in order to probe.
>> Both VCC_3.3V and VCC_1.8V is always on fixed regulators on the board.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Applied for v5.4

This too causes DM644x boot to break. I can enable DEBUG_LL and post
logs, but I suspect they will look very similar to the DM365 case.

Thanks,
Sekhar
