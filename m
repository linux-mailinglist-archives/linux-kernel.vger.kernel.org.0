Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFBE098135
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 19:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfHURYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 13:24:30 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55336 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfHURYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:24:30 -0400
Received: from wsip-184-188-36-2.sd.sd.cox.net ([184.188.36.2] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1i0ULQ-0003jl-3C; Wed, 21 Aug 2019 19:24:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dt-bindings: Convert Arm Mali GPUs to DT schema
Date:   Wed, 21 Aug 2019 19:24:19 +0200
Message-ID: <174045783.D6yh98NvXX@phil>
In-Reply-To: <20190820195959.6126-1-robh@kernel.org>
References: <20190820195959.6126-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 20. August 2019, 21:59:56 CEST schrieb Rob Herring:
> This series converts the various Arm Mali GPU bindings to use the DT
> schema format.
> 
> The Midgard and Bifrost bindings generate warnings on 'interrupt-names'
> because there's all different ordering. The Utgard binding generates 
> warnings on Rockchip platforms because 'clock-names' order is reversed.

Are you planning on sending fixes for these, should I just change the
ordering myself?


> Rob Herring (3):
>   dt-bindings: Convert Arm Mali Midgard GPU to DT schema
>   dt-bindings: Convert Arm Mali Bifrost GPU to DT schema
>   dt-bindings: Convert Arm Mali Utgard GPU to DT schema

Acked-by: Heiko Stuebner <heiko@sntech.de>


Thanks for doing the conversion
Heiko


>  .../bindings/gpu/arm,mali-bifrost.txt         |  92 ----------
>  .../bindings/gpu/arm,mali-bifrost.yaml        | 115 ++++++++++++
>  .../bindings/gpu/arm,mali-midgard.txt         | 119 -------------
>  .../bindings/gpu/arm,mali-midgard.yaml        | 165 +++++++++++++++++
>  .../bindings/gpu/arm,mali-utgard.txt          | 129 --------------
>  .../bindings/gpu/arm,mali-utgard.yaml         | 166 ++++++++++++++++++
>  6 files changed, 446 insertions(+), 340 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
> 
> 




