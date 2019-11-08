Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C95F43C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 10:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbfKHJqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 04:46:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:45818 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730645AbfKHJqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:46:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 052B8AB92;
        Fri,  8 Nov 2019 09:46:09 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: realtek: Document RTD1619 and
 Realtek Mjolnir EVB
To:     James Tai <james.tai@realtek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        'DTML' <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
References: <43B123F21A8CFE44A9641C099E4196FFCF91F9DF@RTITMBSVM04.realtek.com.tw>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <7ce21666-79a0-11ed-9984-d9fb3f67218c@suse.de>
Date:   Fri, 8 Nov 2019 10:46:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <43B123F21A8CFE44A9641C099E4196FFCF91F9DF@RTITMBSVM04.realtek.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.11.19 um 10:42 schrieb James Tai:
> Define compatible strings for Realtek RTD1619 SoC and Realtek Mjolnir EVB.
> 
> Signed-off-by: James Tai <james.tai@realtek.com>
> ---
>  Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Andreas Färber <afaerber@suse.de>

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
