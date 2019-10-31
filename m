Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F734EB24B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 15:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfJaOPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 10:15:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38116 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfJaOPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:15:53 -0400
Received: from dhcp-64-28.ens-lyon.fr ([140.77.64.28] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iQBEs-0005kg-Tz; Thu, 31 Oct 2019 15:15:50 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH 01/13] arm64: dts: rockchip: fix iface clock-name on px30 iommus
Date:   Thu, 31 Oct 2019 15:15:49 +0100
Message-ID: <8112330.DWCu6rFsBr@phil>
In-Reply-To: <2015322.eFjuJPvpNX@phil>
References: <20190917082659.25549-1-heiko@sntech.de> <2015322.eFjuJPvpNX@phil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 3. Oktober 2019, 23:25:51 CET schrieb Heiko Stuebner:
> Am Dienstag, 17. September 2019, 10:26:47 CEST schrieb Heiko Stuebner:
> > The iommu clock names are aclk+iface not aclk+hclk as in the vendor kernel,
> > so fix that in the px30.dtsi
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> applied patches 1-11 for 5.5
> 
> Patches 12+13 need the corresponding phy change to land first

also applied 12+13 now



