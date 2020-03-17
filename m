Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7223C1876EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 01:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733132AbgCQAal convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Mar 2020 20:30:41 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51722 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732903AbgCQAal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:30:41 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jE07x-0004Qg-Lf; Tue, 17 Mar 2020 01:30:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: rockchip: remove #address-cells and #size-cells from i2s nodes
Date:   Tue, 17 Mar 2020 01:30:36 +0100
Message-ID: <17804728.xSKf3K9Wuf@phil>
In-Reply-To: <20200311162524.19748-2-jbx6244@gmail.com>
References: <20200311162524.19748-1-jbx6244@gmail.com> <20200311162524.19748-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 11. März 2020, 17:25:24 CET schrieb Johan Jonker:
> An experimental test with the command below gives
> for example this error:
> 
> arch/arm/boot/dts/rk3036-evb.dt.yaml: i2s@10220000:
> '#address-cells', '#size-cells'
> do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> '#address-cells' and '#size-cells' are not a valid property
> for i2s nodes, so remove them.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.7

Thanks
Heiko


