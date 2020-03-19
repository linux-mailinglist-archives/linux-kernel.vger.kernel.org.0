Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B997818BBBB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 16:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgCSP6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 11:58:15 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:45858 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgCSP6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:58:15 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02JFw1YW047815;
        Fri, 20 Mar 2020 00:58:01 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Fri, 20 Mar 2020 00:58:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from [192.168.1.2] (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02JFw0sv047811
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 20 Mar 2020 00:58:00 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] ARM: dts: rockchip: move uart2 pinctrl settings to each
 dts for rk3288
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200319151339.17909-1-katsuhiro@katsuster.net>
 <4307911.4IBKxFWOMT@diego>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <8eed33d8-142c-28cf-7fa4-faf9bebb13cf@katsuster.net>
Date:   Fri, 20 Mar 2020 00:58:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4307911.4IBKxFWOMT@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

On 2020/03/20 0:25, Heiko Stübner wrote:
> Hi,
> 
> Am Donnerstag, 19. März 2020, 16:13:39 CET schrieb Katsuhiro Suzuki:
>> This patch removes conflicted pinctrl settings uart2 and pwm 2/3
>> from common rk3288.dtsi and moves exist uart2 pinctrl settings
>> into each rk3288*.dts files.
>>
>>    - pwm2_pin  : use GPIO7_C6
>>    - pwm3_pin  : use GPIO7_C7
>>    - uart2_xfer: use GPIO7_C6, GPIO7_C7
> 
> Board files only ever get to enable either pwm2/3 or uart2,
> not both at once - so I'm not sure where you see conflicts.
> 

At first, I think so too. But I've saw this message when booting.

----------
[    2.435504] rockchip-pinctrl pinctrl: pin gpio7-22 already requested by ff680020.pwm; cannot claim for ff690000.serial
[    2.447506] rockchip-pinctrl pinctrl: pin-238 (ff690000.serial) status -22
[    2.455198] rockchip-pinctrl pinctrl: could not request pin 238 (gpio7-22) from group uart2-xfer  on device rockchip-pinctrl
----------

And it seems that uart2(ttyS2) is not working correctly.

----------
# cat /dev/ttyS2
cat: /dev/ttyS2: Input/output error
----------

I'm using newest linux-next, make defconfig and CONFIG_MODULES = n setting
with TinkerBoard. Can I resolve this issue in other ways?

Best Regards,
Katsuhiro Suzuki


> And of course there are alternative pins to use, if you need uart2
> you need both pins in uart-pinmux and if you need either as pwm, then
> the board by design just can't use them as uart2.
> 
> So pin setting should stay where they are, as there really is no conflict.
> 
> 
> Heiko
> 
> 
> 
>> Currently uart2 rk3288 user is the following:
>>
>>    - rk3288-evb.dtsi:&uart2 {
>>    - rk3288-firefly-reload.dts:&uart2 {
>>    - rk3288-firefly.dtsi:&uart2 {
>>    - rk3288-miqi.dts:&uart2 {
>>    - rk3288-phycore-rdk.dts:&uart2 {
>>    - rk3288-popmetal.dts:&uart2 {
>>    - rk3288-r89.dts:&uart2 {
>>    - rk3288-rock2-square.dts:&uart2 {
>>    - rk3288-tinker.dtsi:&uart2 {
>>    - rk3288-veyron.dtsi:&uart2 {
>>    - rk3288-vyasa.dts:&uart2 {
>>
>> And no one is using pwm2 nor pwm3.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   arch/arm/boot/dts/rk3288-evb.dtsi           | 2 ++
>>   arch/arm/boot/dts/rk3288-firefly-reload.dts | 2 ++
>>   arch/arm/boot/dts/rk3288-firefly.dtsi       | 2 ++
>>   arch/arm/boot/dts/rk3288-miqi.dts           | 2 ++
>>   arch/arm/boot/dts/rk3288-phycore-rdk.dts    | 2 ++
>>   arch/arm/boot/dts/rk3288-popmetal.dts       | 2 ++
>>   arch/arm/boot/dts/rk3288-r89.dts            | 2 ++
>>   arch/arm/boot/dts/rk3288-rock2-square.dts   | 2 ++
>>   arch/arm/boot/dts/rk3288-tinker.dtsi        | 2 ++
>>   arch/arm/boot/dts/rk3288-veyron.dtsi        | 2 ++
>>   arch/arm/boot/dts/rk3288-vyasa.dts          | 2 ++
>>   arch/arm/boot/dts/rk3288.dtsi               | 6 ------
>>   12 files changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
>> index 018802df4c0e..74091f831ecf 100644
>> --- a/arch/arm/boot/dts/rk3288-evb.dtsi
>> +++ b/arch/arm/boot/dts/rk3288-evb.dtsi
>> @@ -285,6 +285,8 @@ &uart1 {
>>   };
>>   
>>   &uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart2_xfer>;
>>   	status = "okay";
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rk3288-firefly-reload.dts b/arch/arm/boot/dts/rk3288-firefly-reload.dts
>> index 8c38bda21a7c..b0c976c8e35b 100644
>> --- a/arch/arm/boot/dts/rk3288-firefly-reload.dts
>> +++ b/arch/arm/boot/dts/rk3288-firefly-reload.dts
>> @@ -283,6 +283,8 @@ &uart1 {
>>   };
>>   
>>   &uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart2_xfer>;
>>   	status = "okay";
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
>> index 5e0a19004e46..1632cc083c12 100644
>> --- a/arch/arm/boot/dts/rk3288-firefly.dtsi
>> +++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
>> @@ -532,6 +532,8 @@ &uart1 {
>>   };
>>   
>>   &uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart2_xfer>;
>>   	status = "okay";
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rk3288-miqi.dts b/arch/arm/boot/dts/rk3288-miqi.dts
>> index c41d012c8850..2c0ed37fde80 100644
>> --- a/arch/arm/boot/dts/rk3288-miqi.dts
>> +++ b/arch/arm/boot/dts/rk3288-miqi.dts
>> @@ -379,6 +379,8 @@ &tsadc {
>>   };
>>   
>>   &uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart2_xfer>;
>>   	status = "okay";
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rk3288-phycore-rdk.dts b/arch/arm/boot/dts/rk3288-phycore-rdk.dts
>> index 1e33859de484..6532c1ac43cd 100644
>> --- a/arch/arm/boot/dts/rk3288-phycore-rdk.dts
>> +++ b/arch/arm/boot/dts/rk3288-phycore-rdk.dts
>> @@ -244,6 +244,8 @@ &uart0 {
>>   };
>>   
>>   &uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart2_xfer>;
>>   	status = "okay";
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
>> index 6a51940398b5..f18306bd9e6e 100644
>> --- a/arch/arm/boot/dts/rk3288-popmetal.dts
>> +++ b/arch/arm/boot/dts/rk3288-popmetal.dts
>> @@ -481,6 +481,8 @@ &uart1 {
>>   };
>>   
>>   &uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart2_xfer>;
>>   	status = "okay";
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rk3288-r89.dts b/arch/arm/boot/dts/rk3288-r89.dts
>> index a258c7ae5329..02d2f5cfe201 100644
>> --- a/arch/arm/boot/dts/rk3288-r89.dts
>> +++ b/arch/arm/boot/dts/rk3288-r89.dts
>> @@ -340,6 +340,8 @@ &uart1 {
>>   };
>>   
>>   &uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart2_xfer>;
>>   	status = "okay";
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
>> index cdcdc921ee09..a44290e882be 100644
>> --- a/arch/arm/boot/dts/rk3288-rock2-square.dts
>> +++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
>> @@ -264,6 +264,8 @@ &spdif {
>>   };
>>   
>>   &uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart2_xfer>;
>>   	status = "okay";
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
>> index acfaa12ec239..0327119f71b4 100644
>> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
>> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
>> @@ -500,6 +500,8 @@ &uart1 {
>>   };
>>   
>>   &uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart2_xfer>;
>>   	status = "okay";
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
>> index 54a6838d73f5..baa44d00e49a 100644
>> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
>> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
>> @@ -412,6 +412,8 @@ &uart1 {
>>   };
>>   
>>   &uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart2_xfer>;
>>   	status = "okay";
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
>> index 385dd59393e1..aa50cdc7f839 100644
>> --- a/arch/arm/boot/dts/rk3288-vyasa.dts
>> +++ b/arch/arm/boot/dts/rk3288-vyasa.dts
>> @@ -398,6 +398,8 @@ &tsadc {
>>   };
>>   
>>   &uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart2_xfer>;
>>   	status = "okay";
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
>> index 0cd88774db95..4c1f8cabb5eb 100644
>> --- a/arch/arm/boot/dts/rk3288.dtsi
>> +++ b/arch/arm/boot/dts/rk3288.dtsi
>> @@ -450,8 +450,6 @@ uart2: serial@ff690000 {
>>   		reg-io-width = <4>;
>>   		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
>>   		clock-names = "baudclk", "apb_pclk";
>> -		pinctrl-names = "default";
>> -		pinctrl-0 = <&uart2_xfer>;
>>   		status = "disabled";
>>   	};
>>   
>> @@ -706,8 +704,6 @@ pwm2: pwm@ff680020 {
>>   		compatible = "rockchip,rk3288-pwm";
>>   		reg = <0x0 0xff680020 0x0 0x10>;
>>   		#pwm-cells = <3>;
>> -		pinctrl-names = "default";
>> -		pinctrl-0 = <&pwm2_pin>;
>>   		clocks = <&cru PCLK_RKPWM>;
>>   		clock-names = "pwm";
>>   		status = "disabled";
>> @@ -717,8 +713,6 @@ pwm3: pwm@ff680030 {
>>   		compatible = "rockchip,rk3288-pwm";
>>   		reg = <0x0 0xff680030 0x0 0x10>;
>>   		#pwm-cells = <3>;
>> -		pinctrl-names = "default";
>> -		pinctrl-0 = <&pwm3_pin>;
>>   		clocks = <&cru PCLK_RKPWM>;
>>   		clock-names = "pwm";
>>   		status = "disabled";
>>
> 
> 
> 
> 
> 

