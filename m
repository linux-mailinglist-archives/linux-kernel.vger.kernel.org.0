Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E317B0C0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 22:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgCEVf4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Mar 2020 16:35:56 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53792 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgCEVfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:35:55 -0500
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j9y9o-00066C-8b; Thu, 05 Mar 2020 22:35:52 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: rockchip: add missing model properties
Date:   Thu, 05 Mar 2020 22:35:51 +0100
Message-ID: <5155217.YDJUN7Zz9T@phil>
In-Reply-To: <20200304074051.8742-1-jbx6244@gmail.com>
References: <20200304074051.8742-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. M�rz 2020, 08:40:49 CET schrieb Johan Jonker:
> A test with the command below gives these errors:
> 
> arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: /: 'model'
> is a required property
> arch/arm/boot/dts/rk3288-evb-rk808.dt.yaml: /: 'model'
> is a required property
> arch/arm/boot/dts/rk3288-r89.dt.yaml: /: 'model'
> is a required property
> 
> Fix this error by adding the missing model properties to
> the involved dts files.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
> schemas/root-node.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.7

Thanks
Heiko


