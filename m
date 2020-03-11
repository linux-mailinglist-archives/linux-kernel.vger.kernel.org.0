Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE0131814F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 10:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgCKJcz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Mar 2020 05:32:55 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38330 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbgCKJcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:32:55 -0400
Received: from p5b127c69.dip0.t-ipconnect.de ([91.18.124.105] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jBxjP-0000hs-6C; Wed, 11 Mar 2020 10:32:51 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: add bus to rockchip amba nodenames
Date:   Wed, 11 Mar 2020 10:32:50 +0100
Message-ID: <1741084.mhMtVdeNFd@phil>
In-Reply-To: <20200302153047.17101-1-jbx6244@gmail.com>
References: <20200302153047.17101-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 2. März 2020, 16:30:46 CET schrieb Johan Jonker:
> A test with the command below gives for example this error:
> 
> arch/arm/boot/dts/rk3188-bqedison2qc.dt.yaml: amba: $nodename:0:
> 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> 
> AMBA is a open standard for the connection and
> management of functional blocks in a SoC.
> It's compatible with 'simple-bus', so fix this error
> by adding 'bus' to all Rockchip 'amba' nodes.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
> schemas/simple-bus.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied both for 5.7

Thanks
Heiko


