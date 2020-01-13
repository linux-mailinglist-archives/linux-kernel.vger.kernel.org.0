Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A19138DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 10:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgAMJ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 04:28:47 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53238 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgAMJ2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:28:47 -0500
Received: from wf0253.dip.tu-dresden.de ([141.76.180.253] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iqw1Z-00021m-Ph; Mon, 13 Jan 2020 10:28:41 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 3/3] arm64: dts: rockchip: Enable sdio0 and uart0 on rk3399-roc-pc-mezzanine
Date:   Mon, 13 Jan 2020 10:28:41 +0100
Message-ID: <7106354.sWKCicHN03@phil>
In-Reply-To: <20200109154211.1530-1-m.reichl@fivetechno.de>
References: <20200109154211.1530-1-m.reichl@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 9. Januar 2020, 16:42:10 CET schrieb Markus Reichl:
> The mezzanine board carries an E key type M.2 slot. This is
> connected to USB, SDIO and UART0. Enable sdio and uart0 for use
> with wlan and/or bt M.2 cards.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>

applied for 5.6

Thanks
Heiko


