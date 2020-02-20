Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1058166954
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 21:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgBTU6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 15:58:03 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39504 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbgBTU6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:58:00 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01KKvHCJ105285;
        Thu, 20 Feb 2020 14:57:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582232237;
        bh=X3B9YA+HYhbDjiSSV/KXZjKFnfL2uUR1R1CMQRV6xKY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OYHA4x0D26SlRwGDGIj8aJfbnmqoeMHwKR4skopT1AfW+u2sKc/6xYJ+O44JYmtQ0
         DWV+Iy4harNp+BjgtGGrSsAJ5fwltvqqGLYV004p+iTC1RQcB/m3zAdvj0JLWrCAEO
         +SJr00Es+7fIfV6dXDZqxDQNlOYCS6bNqr4rkEjk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01KKvHjO108341
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Feb 2020 14:57:17 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 20
 Feb 2020 14:57:16 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 20 Feb 2020 14:57:16 -0600
Received: from [128.247.59.107] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01KKvGIT014192;
        Thu, 20 Feb 2020 14:57:16 -0600
Subject: Re: [PATCH v3 2/2] ASoC: tlv320adcx140: Add the tlv320adcx140 codec
 driver family
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20200219125942.22013-1-dmurphy@ti.com>
 <20200219125942.22013-3-dmurphy@ti.com>
 <20200220204834.GA20618@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <5cc47587-eae1-0b41-e91d-f9885a69d75e@ti.com>
Date:   Thu, 20 Feb 2020 14:52:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220204834.GA20618@sirena.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 2/20/20 2:48 PM, Mark Brown wrote:
> On Wed, Feb 19, 2020 at 06:59:42AM -0600, Dan Murphy wrote:
>> Add the tlv320adcx140 codec driver family.
>>
>> The TLV320ADCx140 is a Burr-Brown™ highperformance, audio analog-to-digital
>> converter (ADC) that supports simultaneous sampling of up to four analog
>> channels or eight digital channels for the pulse density modulation (PDM)
> This doesn't apply against current code, please check and resend.

Ok this is against linux master should this be against your for-next branch?

Dan

