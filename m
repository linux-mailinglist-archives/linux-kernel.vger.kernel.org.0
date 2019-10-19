Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB344DD93A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 16:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfJSOu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Oct 2019 10:50:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:47550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfJSOu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:50:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E00E6AF41;
        Sat, 19 Oct 2019 14:50:57 +0000 (UTC)
Subject: Re: [PATCH] MAINTAINERS: Add mailing list for Realtek SoCs
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191019141310.26892-1-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <c4c38df2-faf5-2f17-b614-966a296dc97a@suse.de>
Date:   Sat, 19 Oct 2019 16:50:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191019141310.26892-1-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.10.19 um 16:13 schrieb Andreas Färber:
> Document linux-realtek-soc mailing list to be CC'ed on patches.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7b48525822a..8be71b3d25e7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2168,6 +2168,7 @@ F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
>  ARM/REALTEK ARCHITECTURE
>  M:	Andreas Färber <afaerber@suse.de>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	linux-realtek-soc@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	arch/arm64/boot/dts/realtek/
>  F:	Documentation/devicetree/bindings/arm/realtek.yaml

Applied to linux-realtek.git v5.5/arm64:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git/log/?h=v5.5/arm64

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
