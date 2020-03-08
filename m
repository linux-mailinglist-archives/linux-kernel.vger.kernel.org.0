Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955C117D6D4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 23:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgCHWjo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 8 Mar 2020 18:39:44 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47682 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgCHWjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 18:39:43 -0400
Received: from p508fd11c.dip0.t-ipconnect.de ([80.143.209.28] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jB4a8-00040n-Ox; Sun, 08 Mar 2020 23:39:36 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, christoph.muellner@theobroma-systems.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        kever.yang@rock-chips.com, linux-kernel@vger.kernel.org,
        jbx6244@gmail.com
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: add Odroid Advance Go
Date:   Sun, 08 Mar 2020 23:39:35 +0100
Message-ID: <2618559.AJtVb54S78@phil>
In-Reply-To: <20200308223250.353053-3-heiko@sntech.de>
References: <20200308223250.353053-1-heiko@sntech.de> <20200308223250.353053-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 8. M�rz 2020, 23:32:50 CET schrieb Heiko Stuebner:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> The Odroid Advance Go is a handheld based on Rockchip's rk3326 soc
> with a DSI display and some handheld controls including an analog
> joystick connected to the saradc.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

> +		 *      *** ODROIDGO2-Advance Switch layoout ***

It was pointed out to me that there is a typo here, layout instead
of layoout ;-) .

I'll hopefully just remember to remove that when applying, if I don't
need a v3 for other things.

> +		 * |------------------------------------------------|
> +		 * | sw15                                      sw16 |
> +		 * |------------------------------------------------|
> +		 * |     sw1      |-------------------|      sw8    |
> +		 * |  sw3   sw4   |                   |   sw7   sw5 |
> +		 * |     sw2      |    LCD Display    |      sw6    |
> +		 * |              |                   |             |
> +		 * |              |-------------------|             |
> +		 * |         sw9 sw10   sw11 sw12   sw13 sw14       |
> +		 * |------------------------------------------------|
> +		 */
> +



