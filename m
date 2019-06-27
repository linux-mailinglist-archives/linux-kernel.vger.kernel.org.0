Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258C85809D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 12:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfF0Kkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 06:40:40 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33186 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfF0Kkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:40:39 -0400
Received: from wf0413.dip.tu-dresden.de ([141.76.181.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hgRpQ-0007QZ-3N; Thu, 27 Jun 2019 12:40:32 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        justin.swartz@risingedge.co.za, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Subject: Re: [PATCH 0/4] hdmi on rk3229
Date:   Thu, 27 Jun 2019 12:40:31 +0200
Message-ID: <1889663.L4fA2jsj6U@phil>
In-Reply-To: <20190614165454.13743-1-heiko@sntech.de>
References: <20190614165454.13743-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 14. Juni 2019, 18:54:50 CEST schrieb Heiko Stuebner:
> The hdmiphy needs its clock reparented to the actual hdmiphy-pll
> that gets generated in the hdmiphy itself.
> 
> This incorporates adapted versions of Justin's original patches
> and also the needed clock adaptions to make it possible to
> reparent the hdmiphy clock.
> 
> Heiko Stuebner (2):
>   clk: rockchip: add clock id for hdmi_phy special clock
>   clk: rockchip: export HDMIPHY clock
> 
> Justin Swartz (2):
>   ARM: dts: rockchip: add display nodes for rk322x
>   ARM: dts: rockchip: fix vop iommu-cells on rk322x

applied all 4 to relevant branches for 5.3

Cheers
Heiko


