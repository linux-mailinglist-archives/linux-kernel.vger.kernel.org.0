Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48815D9A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 21:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbfJPTlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 15:41:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51914 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfJPTlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 15:41:52 -0400
Received: from remote.shanghaihotelholland.com ([46.44.148.63] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iKpB5-00069G-QQ; Wed, 16 Oct 2019 21:41:47 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: rk3399-rock-pi-4: restyle rockchip,pins
Date:   Wed, 16 Oct 2019 21:41:41 +0200
Message-ID: <3153873.PTcAyu4JSx@phil>
In-Reply-To: <20191015205852.4200-1-jbx6244@gmail.com>
References: <20191015191000.2890-1-jbx6244@gmail.com> <20191015205852.4200-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 15. Oktober 2019, 22:58:51 CEST schrieb Johan Jonker:
> The define RK_FUNC_1 is no longer used,
> so restyle the rockchip,pins definitions.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied both for 5.5

Thanks
Heiko


