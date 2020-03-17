Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC761876DF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 01:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbgCQA2X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Mar 2020 20:28:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51620 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733033AbgCQA2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:28:22 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jE05j-0004PC-3C; Tue, 17 Mar 2020 01:28:19 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: dts: rockchip: remove clock-names property from 'generic-ohci' nodes
Date:   Tue, 17 Mar 2020 01:28:18 +0100
Message-ID: <3829489.fZJU2aXfik@phil>
In-Reply-To: <20200312171441.21144-2-jbx6244@gmail.com>
References: <20200312171441.21144-1-jbx6244@gmail.com> <20200312171441.21144-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 12. M�rz 2020, 18:14:39 CET schrieb Johan Jonker:
> A test with the command below gives for example this error:
> 
> arch/arm/boot/dts/rv1108-evb.dt.yaml: usb@30160000:
> 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 'clock-names' is not a valid property name for usb_host nodes with
> compatible string 'generic-ohci', so remove them.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/generic-ohci.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.7

Thanks
Heiko


