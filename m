Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFDC017B25F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 00:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgCEXrC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Mar 2020 18:47:02 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54824 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCEXrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 18:47:02 -0500
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jA0CY-0006aW-Td; Fri, 06 Mar 2020 00:46:50 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Andy Yan <andy.yan@rock-chips.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: Add pmic dt tree for rk3399 evb
Date:   Fri, 06 Mar 2020 00:46:50 +0100
Message-ID: <33721271.s4QA4oKXoP@phil>
In-Reply-To: <20200305113912.32226-3-andy.yan@rock-chips.com>
References: <20200305113912.32226-1-andy.yan@rock-chips.com> <20200305113912.32226-3-andy.yan@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. März 2020, 12:39:10 CET schrieb Andy Yan:
> RK3399 EVB use 2 SYR837/8 and a RK808 for power supply,
> Add regulator tree for it.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---

I applied this for 5.7 after fixing quite a number of issues
- spaces instead of tabs in one syr
- odering of nodes and properties
- node names


Heiko


