Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8D8E64BD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 18:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfJ0Rzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 13:55:45 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58038 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfJ0Rzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 13:55:44 -0400
Received: from [46.218.74.72] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iOmlR-0008C3-MT; Sun, 27 Oct 2019 18:55:41 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Andy Yan <andy.yan@rock-chips.com>
Cc:     kever.yang@rock-chips.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 4/4] arm64: dts: rockchip: Add basic dts for RK3308 EVB
Date:   Sun, 27 Oct 2019 18:55:40 +0100
Message-ID: <2097189.7Le80tXmf3@phil>
In-Reply-To: <20191021084657.28629-1-andy.yan@rock-chips.com>
References: <20191021084437.28279-1-andy.yan@rock-chips.com> <20191021084657.28629-1-andy.yan@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 21. Oktober 2019, 10:46:57 CET schrieb Andy Yan:
> This board use uart4 as debug port and arm core voltage
> is modulated by pwm, logic voltage is fixed to 1.05V.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

applied for 5.5

Thanks
Heiko


