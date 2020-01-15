Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3628A13B78F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 03:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgAOCNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 21:13:37 -0500
Received: from mx.socionext.com ([202.248.49.38]:22447 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgAOCNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:13:37 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 15 Jan 2020 11:13:35 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 903FC603AB;
        Wed, 15 Jan 2020 11:13:35 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 15 Jan 2020 11:14:44 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 5DE9740362;
        Wed, 15 Jan 2020 11:13:35 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 2E499120136;
        Wed, 15 Jan 2020 11:13:35 +0900 (JST)
Date:   Wed, 15 Jan 2020 11:13:35 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 0/6] phy: socionext: Add some improvements and legacy SoC support
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <1573035979-32200-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1573035979-32200-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-Id: <20200115111334.FD2E.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Gentle ping.
Is there any comments about this series?

Thank you,

On Wed, 6 Nov 2019 19:26:13 +0900 <hayashi.kunihiko@socionext.com> wrote:

> This series adds some improvements to PHY interface drivers, and adds legacy SoC
> support that needs to manage gio clock and reset.
> 
> Kunihiko Hayashi (6):
>   phy: socionext: Use devm_platform_ioremap_resource()
>   dt-bindings: phy: socionext: Add Pro5 support and remove Pro4 from
>     usb3-hsphy
>   phy: uniphier-usb3ss: Add Pro5 support
>   phy: uniphier-usb3hs: Add legacy SoC support for Pro5
>   phy: uniphier-usb3hs: Change Rx sync mode to avoid communication
>     failure
>   phy: uniphier-pcie: Add legacy SoC support for Pro5
> 
>  .../devicetree/bindings/phy/uniphier-pcie-phy.txt  | 13 ++-
>  .../bindings/phy/uniphier-usb3-hsphy.txt           |  6 +-
>  .../bindings/phy/uniphier-usb3-ssphy.txt           |  5 +-
>  drivers/phy/socionext/phy-uniphier-pcie.c          | 87 ++++++++++++++++----
>  drivers/phy/socionext/phy-uniphier-usb3hs.c        | 92 ++++++++++++++++------
>  drivers/phy/socionext/phy-uniphier-usb3ss.c        |  8 +-
>  6 files changed, 163 insertions(+), 48 deletions(-)
> 
> -- 
> 2.7.4

---
Best Regards,
Kunihiko Hayashi

