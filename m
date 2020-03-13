Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1D3185065
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 21:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgCMUfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 16:35:31 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:40789 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgCMUfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:35:31 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 3A460240009;
        Fri, 13 Mar 2020 20:35:27 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] arm64: dts: marvell: fix non-existed cpu referrence in armada-ap806-dual.dtsi
In-Reply-To: <20200209212016.27062-1-vadym.kochan@plvision.eu>
References: <20200209212016.27062-1-vadym.kochan@plvision.eu>
Date:   Fri, 13 Mar 2020 21:35:26 +0100
Message-ID: <87v9n8xab5.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vadym,

> armada-ap806-dual.dtsi includes armada-ap806.dtsi which describes
> thermal zones for 4 cpus but only cpu0 and cpu1 only exists for dual
> configuration, this makes dtb compilation fail. Fix it by removing
> thermal zone nodes for non-existed cpus for dual configuration.
>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
> index 09849558a776..fcab5173fe67 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
> @@ -53,4 +53,9 @@
>  			cache-sets = <512>;
>  		};
>  	};
> +
> +	thermal-zones {
> +		/delete-node/ ap-thermal-cpu2;
> +		/delete-node/ ap-thermal-cpu3;
> +	};
>  };
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
