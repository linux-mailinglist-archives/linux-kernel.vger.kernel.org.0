Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 364F31876D6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 01:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733247AbgCQA1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 20:27:37 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51562 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733009AbgCQA1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:27:36 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jE051-0004Oe-74; Tue, 17 Mar 2020 01:27:35 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Joshua Watt <jpewhacker@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joshua Watt <JPEWhacker@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARM: dts: rockchip: Keep rk3288-tinker SD card IO powered during reboot
Date:   Tue, 17 Mar 2020 01:27:34 +0100
Message-ID: <2163959.mC3bBs0uTH@phil>
In-Reply-To: <20200219204224.34154-1-JPEWhacker@gmail.com>
References: <20200219204224.34154-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 19. Februar 2020, 21:42:20 CET schrieb Joshua Watt:
> IO voltage regulator for the SD card must be kept on all the time,
> otherwise when the board reboots the SD card can't be read by the
> bootloader.
> 
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>

applied for 5.7

Thanks
Heiko


