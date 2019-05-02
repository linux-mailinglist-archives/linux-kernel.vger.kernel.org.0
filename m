Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51DFE11731
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 12:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfEBKZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 06:25:33 -0400
Received: from mail2.sp2max.com.br ([138.185.4.9]:43020 "EHLO
        mail2.sp2max.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfEBKZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:25:33 -0400
Received: from [172.17.0.2] (unknown [186.137.130.251])
        (Authenticated sender: pablo@fliagreco.com.ar)
        by mail2.sp2max.com.br (Postfix) with ESMTPA id 4FC087B05A2;
        Thu,  2 May 2019 07:25:27 -0300 (-03)
Subject: Re: [linux-sunxi] Re: [PATCH v5 3/7] ARM: dts: sun8i: v40:
 bananapi-m2-berry: Enable GMAC ethernet controller
To:     maxime.ripard@bootlin.com
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1556040365-10913-1-git-send-email-pgreco@centosproject.org>
 <1556040365-10913-4-git-send-email-pgreco@centosproject.org>
 <20190502073904.yng5dz5kwgulw6ha@flea>
From:   =?UTF-8?Q?Pablo_Sebasti=c3=a1n_Greco?= <pgreco@centosproject.org>
Message-ID: <2af6a523-adeb-7f7d-c2b1-de852aa3c562@centosproject.org>
Date:   Thu, 2 May 2019 07:25:25 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502073904.yng5dz5kwgulw6ha@flea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: 4FC087B05A2.A2B5A
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
        escore=-2.9, requerido 6, autolearn=not spam, ALL_TRUSTED -1.00,
        BAYES_00 -1.90)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


El 2/5/19 a las 04:39, Maxime Ripard escribió:
> On Tue, Apr 23, 2019 at 02:26:00PM -0300, Pablo Greco wrote:
>> Just like the Bananapi M2 Ultra, the Bananapi M2 Berry has a Realtek
>> RTL8211E RGMII PHY tied to the GMAC.
>> The PMIC's DC1SW output provides power for the PHY, while the ALDO2
>> output provides I/O voltages on both sides.
>>
>> Signed-off-by: Pablo Greco <pgreco@centosproject.org>
>> ---
>>   arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 29 +++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>> index 2cb2ce0..561319b 100644
>> --- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>> +++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>> @@ -50,6 +50,7 @@
>>   	compatible = "sinovoip,bpi-m2-berry", "allwinner,sun8i-r40";
>>
>>   	aliases {
>> +		ethernet0 = &gmac;
>>   		serial0 = &uart0;
>>   	};
>>
>> @@ -92,6 +93,22 @@
>>   	status = "okay";
>>   };
>>
>> +&gmac {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&gmac_rgmii_pins>;
>> +	phy-handle = <&phy1>;
>> +	phy-mode = "rgmii";
>> +	phy-supply = <&reg_dc1sw>;
>> +	status = "okay";
>> +};
>> +
>> +&gmac_mdio {
>> +	phy1: ethernet-phy@1 {
>> +		compatible = "ethernet-phy-ieee802.3-c22";
>> +		reg = <1>;
>> +	};
>> +};
>> +
>>   &i2c0 {
>>   	status = "okay";
>>
>> @@ -133,6 +150,12 @@
>>   	vcc-pg-supply = <&reg_dldo1>;
>>   };
>>
>> +&reg_aldo2 {
>> +	regulator-min-microvolt = <2500000>;
>> +	regulator-max-microvolt = <2500000>;
>> +	regulator-name = "vcc-pa";
>> +};
>> +
> Shouldn't this one be added to the patch 2?
>
> Thanks
> Maxime
Yes, I'll do that in next version
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
Pablo.
