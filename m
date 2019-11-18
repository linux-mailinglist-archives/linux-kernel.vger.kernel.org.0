Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5430DFFC9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 01:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfKRA6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 19:58:42 -0500
Received: from gloria.sntech.de ([185.11.138.130]:40224 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfKRA6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 19:58:41 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iWVNF-0003hD-Gj; Mon, 18 Nov 2019 01:58:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        kever.yang@rock-chips.com, cl@rock-chips.com
Subject: Re: [PATCH] arm64: dts: rockchip: remove 408MHz operating point from px30
Date:   Mon, 18 Nov 2019 01:58:36 +0100
Message-ID: <4318673.vLX1ueDYfg@phil>
In-Reply-To: <20191116095220.31122-1-heiko@sntech.de>
References: <20191116095220.31122-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 16. November 2019, 10:52:20 CET schrieb Heiko Stuebner:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> It looks like the px30 is running unstable at this 408MHz operating point.
> This shows in stalled threads and other big numbers of kernel exception.
> 
> At 600MHz and above it instead works stable and as expected. As the 408MHz
> point doesn't even decrease the voltage compared to 600MHz, just drop this
> 408MHz operating point for now.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

applied


