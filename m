Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F35CA75924
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 22:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfGYUvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 16:51:40 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39636 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbfGYUvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:51:40 -0400
Received: from d57e23da.static.ziggozakelijk.nl ([213.126.35.218] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hqki6-000216-NC; Thu, 25 Jul 2019 22:51:34 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] dt-bindings: ARM: dts: rockchip: Add bindings for rk3288-veyron-{fievel,tiger}
Date:   Thu, 25 Jul 2019 22:51:33 +0200
Message-ID: <9603810.NFohB8vNa9@phil>
In-Reply-To: <20190725162642.250709-4-mka@chromium.org>
References: <20190725162642.250709-1-mka@chromium.org> <20190725162642.250709-4-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 25. Juli 2019, 18:26:40 CEST schrieb Matthias Kaehlcke:
> Fievel is a Chromebox and Tiger a Chromebase with a 10" display and
> touchscreen. Tiger and Fievel are based on the same board.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

applied for 5.4


