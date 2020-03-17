Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2E41876BE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 01:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbgCQAZd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Mar 2020 20:25:33 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51412 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733127AbgCQAZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:25:32 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jE02x-0004MY-3N; Tue, 17 Mar 2020 01:25:27 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: fix lvds-encoder ports subnode for rk3188-bqedison2qc
Date:   Tue, 17 Mar 2020 01:25:26 +0100
Message-ID: <6365496.CELQRQS0Ut@phil>
In-Reply-To: <20200316174647.5598-1-jbx6244@gmail.com>
References: <20200316174647.5598-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 16. M�rz 2020, 18:46:47 CET schrieb Johan Jonker:
> A test with the command below gives this error:
> 
> arch/arm/boot/dts/rk3188-bqedison2qc.dt.yaml: lvds-encoder:
> 'ports' is a required property
> 
> Fix error by adding a ports wrapper for port@0 and port@1
> inside the 'lvds-encoder' node for rk3188-bqedison2qc.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/
> bridge/lvds-codec.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.7

Thanks
Heiko


