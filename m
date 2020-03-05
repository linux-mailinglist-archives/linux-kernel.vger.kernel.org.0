Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFFA517B0C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 22:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgCEVi5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Mar 2020 16:38:57 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53830 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbgCEVi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:38:57 -0500
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j9yCi-00067A-Sg; Thu, 05 Mar 2020 22:38:52 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andy Yan <andy.yan@rock-chips.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] arm64: dts: rockchip: remove dvs2 pinctrl for pmic on rk3399 evb
Date:   Thu, 05 Mar 2020 22:38:52 +0100
Message-ID: <1742149.p31cPTDa3R@diego>
In-Reply-To: <20200305113912.32226-2-andy.yan@rock-chips.com>
References: <20200305113912.32226-1-andy.yan@rock-chips.com> <20200305113912.32226-2-andy.yan@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. M�rz 2020, 12:39:09 CET schrieb Andy Yan:
> DVS2 of pmic is connected to GND, no pinctrl for it.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

applied for 5.7

Thanks
Heiko


