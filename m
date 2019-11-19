Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C447110240F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 13:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfKSMQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 07:16:02 -0500
Received: from foss.arm.com ([217.140.110.172]:51704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfKSMQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:16:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 934E11FB;
        Tue, 19 Nov 2019 04:16:01 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70F813F703;
        Tue, 19 Nov 2019 04:16:01 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 15D23682956; Tue, 19 Nov 2019 12:16:00 +0000 (GMT)
Date:   Tue, 19 Nov 2019 12:16:00 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: arm: juno: Fix UART frequency
Message-ID: <20191119121559.7grzoz2yoxhg23nf@e110455-lin.cambridge.arm.com>
References: <20191119120331.28243-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191119120331.28243-1-andre.przywara@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 12:03:31PM +0000, Andre Przywara wrote:
> Older versions of the Juno *SoC* TRM [1] recommended that the UART clock
> source should be 7.2738 MHz, whereas the *system* TRM [2] stated a more
> correct value of 7.3728 MHz. Somehow the wrong value managed to end up in
> our DT.
> Doing a prime factorisation, a modulo divide by 115200 and trying
> to buy a 7.2738 MHz crystal at your favourite electronics dealer suggest
> that the old value was actually a typo. The actual UART clock is driven
> by a PLL, configured via a parameter in some board.txt file in the
> firmware, which reads 7.37 MHz (sic!).
> 
> Fix this to correct the baud rate divisor calculation on the Juno board.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> [1] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0515b.b/DDI0515B_b_juno_arm_development_platform_soc_trm.pdf
> [2] http://infocenter.arm.com/help/topic/com.arm.doc.100113_0000_07_en/arm_versatile_express_juno_development_platform_(v2m_juno)_technical_reference_manual_100113_0000_07_en.pdf

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  arch/arm64/boot/dts/arm/juno-clocks.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-clocks.dtsi b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
> index e5e265dfa902..2870b5eeb198 100644
> --- a/arch/arm64/boot/dts/arm/juno-clocks.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
> @@ -8,10 +8,10 @@
>   */
>  / {
>  	/* SoC fixed clocks */
> -	soc_uartclk: refclk7273800hz {
> +	soc_uartclk: refclk7372800hz {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> -		clock-frequency = <7273800>;
> +		clock-frequency = <7372800>;
>  		clock-output-names = "juno:uartclk";
>  	};
>  
> -- 
> 2.17.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
