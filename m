Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65644E7F43
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 05:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbfJ2Ej0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 00:39:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:43218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbfJ2EjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 00:39:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41769AD14;
        Tue, 29 Oct 2019 04:39:24 +0000 (UTC)
Subject: Re: [PATCH v2 5/8] arm64: dts: realtek: Change dual-license from MIT
 to BSD
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-realtek-soc@lists.infradead.org
References: <20191020040817.16882-1-afaerber@suse.de>
 <20191020040817.16882-6-afaerber@suse.de>
 <CAL_Jsq+OhiZZ4Ei3wg4s-1z+WsqQSvvRMNrK37Yq+1XR3-3_uA@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <66c69519-6717-8c2e-dc92-05448535c181@suse.de>
Date:   Tue, 29 Oct 2019 05:39:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+OhiZZ4Ei3wg4s-1z+WsqQSvvRMNrK37Yq+1XR3-3_uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.10.19 um 22:52 schrieb Rob Herring:
> On Sat, Oct 19, 2019 at 11:08 PM Andreas Färber <afaerber@suse.de> wrote:
>>
>> Move the SPDX-License-Identifier to the top line and update to SPDX 2.0.
>> While at it, switch from GPLv2+/MIT to GPLv2+/BSD2c before adding more.
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
>>  v2: New
>>
>>  arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts | 3 +--
>>  arch/arm64/boot/dts/realtek/rtd1295.dtsi          | 3 +--
>>  arch/arm64/boot/dts/realtek/rtd129x.dtsi          | 3 +--
>>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> It's really only schema files that I'm pushing towards BSD2C. Maybe in
> hindsight we should have done MIT as that's more common in the dts
> files.

After discussion with Rob about whether to drop this change I dropped
the misunderstood Suggested-by and applied this to linux-realtek.git
v5.5/dt64 anyway:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git/log/?h=v5.5/dt64

I don't mind either license.

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
