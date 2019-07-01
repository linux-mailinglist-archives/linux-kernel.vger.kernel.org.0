Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9E034910
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 15:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfFDNjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 09:39:35 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47630 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbfFDNje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:39:34 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hY9ew-0001Qf-Fe; Tue, 04 Jun 2019 15:39:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Akash Gajjar <akash@openedev.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add WiFi+BT support on ROCK Pi4 board
Date:   Tue, 04 Jun 2019 15:39:25 +0200
Message-ID: <1697100.2SMvg6TTVp@phil>
In-Reply-To: <20190528184705.5240-1-akash@openedev.com>
References: <20190528184705.5240-1-akash@openedev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 28. Mai 2019, 20:46:58 CEST schrieb Akash Gajjar:
> Rock Pi 4 has a on board AP6256 WiFi/BT Module. enable wifi and bluetooth
> support on Rock Pi 4 board.
> 
> Signed-off-by: Akash Gajjar <akash@openedev.com>

applied for 5.3

Thanks
Heiko


