Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB213C2BC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 14:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgAON1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 08:27:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:47002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgAON07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:26:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1D95BACEF;
        Wed, 15 Jan 2020 13:26:58 +0000 (UTC)
Subject: Re: [PATCH 00/14] ARM: dts: realtek: Introduce syscon
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
To:     James Tai <james.tai@realtek.com>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191202182205.14629-1-afaerber@suse.de>
 <0f4d6872-b764-1c5e-9c2a-4e4e415a4877@suse.de>
 <996a6968f411467cb987a14a0764726d@realtek.com>
 <f1f3fc5f-ae6c-b803-cb02-d06d60c442ce@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <42cb14df-fb20-f191-3e24-4735a3b87954@suse.de>
Date:   Wed, 15 Jan 2020 14:26:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <f1f3fc5f-ae6c-b803-cb02-d06d60c442ce@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.01.20 um 03:58 schrieb Andreas Färber:
> Hi James,
> 
> Am 31.12.19 um 10:47 schrieb James Tai:
>>> I'm waiting for your Acked-by of the blocks & numbers in these patches.
>>> Other Realtek engineers are also invited to respond, of course.
>>
>> I have reviewed these patches.
> 
> Thanks - does anything need changes in patch 01 or is that ack'ed, too?

No further response, so all (incl. 01/14) applied to linux-realtek.git:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git/log/?h=v5.6/dt

Should there be anything wrong with 01/14, just send a follow-up patch.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
