Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD2101F86
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 10:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKSJKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 04:10:06 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54680 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfKSJKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:10:05 -0500
Received: from wf0530.dip.tu-dresden.de ([141.76.182.18] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iWzWI-0004Dg-Jv; Tue, 19 Nov 2019 10:09:58 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Enable MTD Flash on rk3399-roc-pc
Date:   Tue, 19 Nov 2019 10:09:57 +0100
Message-ID: <6728270.yCOpIldRRh@phil>
In-Reply-To: <94f44e1d-86c6-1e32-aa63-56edbd7d75f5@fivetechno.de>
References: <94f44e1d-86c6-1e32-aa63-56edbd7d75f5@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 18. November 2019, 13:44:54 CET schrieb Markus Reichl:
> rk3399-roc-pc has 16 MB SPI NOR Flash, enable it.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>

applied (yesterday evening already)

Thanks
Heiko


