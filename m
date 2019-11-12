Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE2AF8C67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 11:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKLKDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 05:03:06 -0500
Received: from regular1.263xmail.com ([211.150.70.195]:33194 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfKLKDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:03:06 -0500
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id 070C5BCF;
        Tue, 12 Nov 2019 18:02:55 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.60.65] (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P3849T140143446607616S1573552957842936_;
        Tue, 12 Nov 2019 18:02:54 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <3042783e90e705440e20c31947d337db>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: akash@openedev.com
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 3/3] arm64: dts: rk3399: Add init voltage for vdd_log
To:     Markus Reichl <m.reichl@fivetechno.de>, Soeren Moch <smoch@web.de>,
        heiko@sntech.de
Cc:     Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andrius_=c5=a0tikonas?= <andrius@stikonas.eu>,
        linux-kernel@vger.kernel.org, Alexis Ballier <aballier@gentoo.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Andy Yan <andyshrk@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Nick Xie <nick@khadas.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Akash Gajjar <akash@openedev.com>
References: <20191111005158.25070-1-kever.yang@rock-chips.com>
 <20191111005158.25070-3-kever.yang@rock-chips.com>
 <ef8830f3-10d1-7b71-0e18-232f2eaeef2d@web.de>
 <1eaef5d5-c923-da56-b9c4-48d517b3c969@rock-chips.com>
 <acbab893-9e9a-cfe1-67bf-a9e2b2e50114@fivetechno.de>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <17e14b30-02ee-2379-8891-088677924479@rock-chips.com>
Date:   Tue, 12 Nov 2019 18:02:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <acbab893-9e9a-cfe1-67bf-a9e2b2e50114@fivetechno.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Markus,


On 2019/11/12 下午4:16, Markus Reichl wrote:
> Hi Kever,
>
> have a rk3399-roc-pc running mainline U-Boot and kernel and vdd_log is
> showing 1118 mV.

The rk3399-roc-pc have the same vdd_log circuit in schematic, so it 
should like the patch 1/3 of

this patch set.

I don't understand who is setting this value, maybe the default value 
without pwm regulator enabled?

> Is this a danger for the board?
> How to fix it?

The best way is to set correct min/max microvolt of the 
regulator(measure with PWM output low and high),

(note that if  no driver touch the regulator, the PWM is default input, 
not output;)

and set a init-microvolt for U-Boot driver, and I think no kernel driver 
touch this regulator now.


Thanks,

- Kever

> Btw. vin-supply for this pwm-regulator is ignored and I could not find it
> in bindings doc.
>
> Gruß,


