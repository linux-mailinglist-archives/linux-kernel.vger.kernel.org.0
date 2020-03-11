Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD3E18142B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 10:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgCKJKH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Mar 2020 05:10:07 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38066 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCKJKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:10:07 -0400
Received: from p5b127c69.dip0.t-ipconnect.de ([91.18.124.105] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jBxNL-0000a4-7G; Wed, 11 Mar 2020 10:10:03 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ARM: dts: rockchip: remove #dma-cells from dma client nodes for rv1108
Date:   Wed, 11 Mar 2020 10:10:02 +0100
Message-ID: <2565398.9qm7F6LNF9@phil>
In-Reply-To: <20200309134020.14935-1-jbx6244@gmail.com>
References: <20200309134020.14935-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 9. M�rz 2020, 14:40:20 CET schrieb Johan Jonker:
> When we combine spi-rockchip.yaml and
> spi-controller.yaml and add 'additionalProperties: false'
> it gives for example this error:
> 
> arch/arm/boot/dts/rv1108-evb.dt.yaml: spi@10270000:
> '#dma-cells' does not match any of the regexes:
> '^.*@[0-9a-f]+$', '^slave$'
> 
> '#dma-cells' are not used for dma clients, so remove them all.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.7

Thanks
Heiko


