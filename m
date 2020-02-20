Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 884CB16672C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 20:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgBTTaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 14:30:01 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53176 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgBTTaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:30:00 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01KJTJ7k059691;
        Thu, 20 Feb 2020 13:29:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582226959;
        bh=7VYc8CJ2y2APcsIbYj7iN6/uBegeLD4mvzWH1dQDQa8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DApX65vZNJ/d9RG5qjp3W88p5qEPBfEW3+vakGKqMQ7Rg95D2WdiaIzJoDke+qBf/
         OwfGlJlU90vBDTsyxmfAL3/tWP76RSUQz81JHgqtqLrA0y06FGLdQFkUJLls4N55LS
         1gRh9F39eST9pH4TnaE/wa7Px0KKSPOIc6UE7imQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01KJTJRN003290;
        Thu, 20 Feb 2020 13:29:19 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 20
 Feb 2020 13:29:19 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 20 Feb 2020 13:29:19 -0600
Received: from [128.247.59.107] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01KJTJPt053232;
        Thu, 20 Feb 2020 13:29:19 -0600
Subject: Re: [PATCH v3 0/2] Introduce the TLV320ADCx140 codec family
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20200219125942.22013-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <1d2b79f5-a928-adc5-b6f8-e73e0c061f75@ti.com>
Date:   Thu, 20 Feb 2020 13:24:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219125942.22013-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 2/19/20 6:59 AM, Dan Murphy wrote:
> Hello
>
> Introducing the Texas Instruments TLV320ADCx140 quad channel audio ADC.
> This device supports 4 analog inputs, 8 digital inputs or a combination of
> analog and digital microphones.
>
> TLV320ADC3140 - http://www.ti.com/lit/gpn/tlv320adc3140
> TLV320ADC5140 - http://www.ti.com/lit/gpn/tlv320adc5140
> TLV320ADC6140 - http://www.ti.com/lit/gpn/tlv320adc6140

Please let me know if there are any additional review comments on this 
code I have 2 more feature add patches on top of this patch that I 
developed a couple days ago and don't want to submit them for review 
until this driver is integrated.

Dan

