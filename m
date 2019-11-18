Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C21010079A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 15:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfKROpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 09:45:19 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42098 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfKROpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:45:19 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAIEjAqh014685;
        Mon, 18 Nov 2019 08:45:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574088310;
        bh=ctTwfjC6MESChCXZHvxDAUGUwacS+WuFLzM6MQMYqkg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=umlsD5D/sxtMHzl6czy9c1X91mIxsoccFHQoBXVCPdYTGEEx8fPfPm1BLik1PgE9s
         NfQyP+ExvZxhzHA+zwN5pGuYYC9BdF425RkXEMgrSJI3OTZzjoyuhiZYB0+F11sY9J
         02vmIVibCBA9GqOdG1Eh/tTX8KViU/trkuXcs71Y=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAIEjAlX100119
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Nov 2019 08:45:10 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 18
 Nov 2019 08:45:10 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 18 Nov 2019 08:45:10 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAIEj8Ur105800;
        Mon, 18 Nov 2019 08:45:08 -0600
Subject: Re: [PATCH 1/2] bindings: sound: pcm3168a: Document optional RST gpio
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <kuninori.morimoto.gx@renesas.com>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20191113124734.27984-1-peter.ujfalusi@ti.com>
 <20191113124734.27984-2-peter.ujfalusi@ti.com>
 <20191118130855.GE9761@sirena.org.uk>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <5f824119-9b5b-5ad2-6915-d174f9cca8af@ti.com>
Date:   Mon, 18 Nov 2019 16:46:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118130855.GE9761@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

On 18/11/2019 15.08, Mark Brown wrote:
> On Wed, Nov 13, 2019 at 02:47:33PM +0200, Peter Ujfalusi wrote:
>> On boards where the RST line is not pulled up, but it is connected to a
>> GPIO line this property must present in order to be able to enable the
>> codec.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

What would be the appropriate subject line for
Documentation/devicetree/bindings/sound

Oops, I have missed the dt- prefix for the bindings for sure.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
