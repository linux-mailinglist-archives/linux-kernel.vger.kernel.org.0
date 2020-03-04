Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF6F2179013
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 13:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgCDMJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 07:09:26 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48618 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgCDMJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:09:26 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 024C9D8V129529;
        Wed, 4 Mar 2020 06:09:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583323753;
        bh=JhEJq56rPjtPZfyWnCQPE/SGrmng2ck/eXL4JnTgN3I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dPCu8AlZNR7LEeL7hJy25iCw052pNU8U+kOPBkWY1t5f+ORnmEn1/esc7WQc5ds8B
         2W8giGBQXA9qmLIQBdWQGm3jsZtpMmvg4ceFe3892gtQZ39wHL3XGTKnCJ5HaqOsU1
         R+KVVb8MUryDec2GtTYfYrRw/yfAQVWBip8AQuuE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 024C9DpU052249
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Mar 2020 06:09:13 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Mar
 2020 06:09:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Mar 2020 06:09:13 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 024C9Aop088563;
        Wed, 4 Mar 2020 06:09:10 -0600
Subject: Re: [PATCH v2 0/7] phy: socionext: Add some improvements and legacy
 SoC support
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1580367165-16760-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0ec7417e-8c83-176e-6aab-c53541db823c@ti.com>
Date:   Wed, 4 Mar 2020 17:43:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1580367165-16760-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/01/20 12:22 pm, Kunihiko Hayashi wrote:
> This series adds some improvements to PHY interface drivers, and
> adds legacy SoC support that needs to manage gio clock and reset.

merged, thanks!

-Kishon

> 
> Changes since v1:
> - dt-bindings: Add Reviewed-by: line
> - Add SoC-dependent phy-mode function support for pcie-phy
> 
> Kunihiko Hayashi (7):
>   phy: socionext: Use devm_platform_ioremap_resource()
>   dt-bindings: phy: socionext: Add Pro5 support and remove Pro4 from
>     usb3-hsphy
>   phy: uniphier-usb3ss: Add Pro5 support
>   phy: uniphier-usb3hs: Add legacy SoC support for Pro5
>   phy: uniphier-usb3hs: Change Rx sync mode to avoid communication
>     failure
>   phy: uniphier-pcie: Add legacy SoC support for Pro5
>   phy: uniphier-pcie: Add SoC-dependent phy-mode function support
> 
>  .../devicetree/bindings/phy/uniphier-pcie-phy.txt  |  13 ++-
>  .../bindings/phy/uniphier-usb3-hsphy.txt           |   6 +-
>  .../bindings/phy/uniphier-usb3-ssphy.txt           |   5 +-
>  drivers/phy/socionext/phy-uniphier-pcie.c          | 102 +++++++++++++++++----
>  drivers/phy/socionext/phy-uniphier-usb3hs.c        |  92 ++++++++++++++-----
>  drivers/phy/socionext/phy-uniphier-usb3ss.c        |   8 +-
>  6 files changed, 172 insertions(+), 54 deletions(-)
> 
