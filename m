Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10345E5D8F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 15:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfJZN5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 09:57:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:55386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726256AbfJZN5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:57:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 85577B319;
        Sat, 26 Oct 2019 13:57:53 +0000 (UTC)
Subject: Re: [PATCH v2 3/8] dt-bindings: arm: realtek: Tidy up conversion to
 json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191020040817.16882-1-afaerber@suse.de>
 <20191020040817.16882-4-afaerber@suse.de> <20191025212127.GA4819@bogus>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <1c4eae6d-d145-72af-85dd-18c8e1fdc848@suse.de>
Date:   Sat, 26 Oct 2019 15:57:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025212127.GA4819@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.10.19 um 23:21 schrieb Rob Herring:
> On Sun, 20 Oct 2019 06:08:12 +0200, =?UTF-8?q?Andreas=20F=C3=A4rber?= wrote:
>> Restore the device names for compatible strings as comments.
>> Prepare for adding more SoCs by inserting oneOf.
>>
>> Fixes: 693af5f3eeaa ("dt-bindings: arm: Convert Realtek board/soc bindings to json-schema")
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
>>  v2: New
>>  
>>  Documentation/devicetree/bindings/arm/realtek.yaml | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, applied to linux-realtek.git v5.5/dt64:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git/log/?h=v5.5/dt64

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
