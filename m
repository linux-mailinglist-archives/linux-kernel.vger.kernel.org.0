Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5AE0E7FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 06:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbfJ2FZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 01:25:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:52918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfJ2FZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 01:25:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6521AD09;
        Tue, 29 Oct 2019 05:25:53 +0000 (UTC)
Subject: Re: [PATCH v2 01/11] dt-bindings: reset: Add Realtek RTD1295
To:     linux-realtek-soc@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20191023101317.26656-1-afaerber@suse.de>
 <20191023101317.26656-2-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <2b30a15d-b610-fca7-97cf-9a570494d545@suse.de>
Date:   Tue, 29 Oct 2019 06:25:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023101317.26656-2-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.10.19 um 12:13 schrieb Andreas Färber:
> Add a header with symbolic reset indices for Realtek RTD1295 SoC.
> Naming was derived from reset-names in an OEM's Device Tree.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> [AF: Dropped RTD1295 specific binding definition, updated SPDX]
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Dropped textual binding with new compatible
>  * Updated SPDX-License-Identifier location
>  * Updated to SPDX 2.0
>  * Changed from MIT to BSD (Rob)
>  
>  include/dt-bindings/reset/realtek,rtd1295.h | 111 ++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 include/dt-bindings/reset/realtek,rtd1295.h

Added Philipp's Acked-by and applied to linux-realtek.git v5.5/dt64:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git/log/?h=v5.5/dt64

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
