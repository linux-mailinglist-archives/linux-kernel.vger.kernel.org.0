Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB7AFFFCA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 02:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfKRBD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 20:03:57 -0500
Received: from gloria.sntech.de ([185.11.138.130]:40396 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfKRBD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 20:03:57 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iWVSB-0003iv-GC; Mon, 18 Nov 2019 02:03:43 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Soeren Moch <smoch@web.de>, Kever Yang <kever.yang@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Alexis Ballier <aballier@gentoo.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Andy Yan <andyshrk@gmail.com>, linux-kernel@vger.kernel.org,
        Vicente Bergas <vicencb@gmail.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Oskari Lemmela <oskari@lemmela.net>,
        Nick Xie <nick@khadas.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Akash Gajjar <akash@openedev.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix vdd_log on rk3399-roc-pc
Date:   Mon, 18 Nov 2019 02:03:42 +0100
Message-ID: <1963448.kY1Vgr51ze@phil>
In-Reply-To: <d786ef47-eda8-3994-2ef2-fc4a584bcdcc@fivetechno.de>
References: <20191111005158.25070-1-kever.yang@rock-chips.com> <fd9ee2bc-9dfb-1aa2-f00f-add9b3069876@web.de> <d786ef47-eda8-3994-2ef2-fc4a584bcdcc@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 12. November 2019, 12:42:09 CET schrieb Markus Reichl:
> On rk3399 vdd_log shall not exceed 1.0 V. On rk3399-roc-pc
> vdd_log is presently 1118 mV. Fix by setting the min voltage
> of the respective pwm-regulator down to 450 mV.
> This results in a vdd_log of 953 mV.
> Specify the supply to silence warning.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>

applied for 5.6 (or maybe still 5.5)

Thanks
Heiko


