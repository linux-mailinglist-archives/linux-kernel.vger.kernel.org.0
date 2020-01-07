Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B22E91335C6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 23:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgAGWcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 17:32:10 -0500
Received: from gloria.sntech.de ([185.11.138.130]:37618 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgAGWcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:32:10 -0500
Received: from ip5f5a5f74.dynamic.kabel-deutschland.de ([95.90.95.116] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ioxOP-000534-Gq; Tue, 07 Jan 2020 23:32:05 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: rk3399-firefly: remove num-slots from &sdio0 node
Date:   Tue, 07 Jan 2020 23:32:04 +0100
Message-ID: <2012646.CMKZZmdTN9@phil>
In-Reply-To: <20191231191154.5587-1-jbx6244@gmail.com>
References: <20191231191154.5587-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 31. Dezember 2019, 20:11:54 CET schrieb Johan Jonker:
> The option "num-slots" was deprecated long time ago, so remove it.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.6

Thanks
Heiko


