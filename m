Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E679E144730
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 23:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgAUWXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 17:23:21 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35690 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgAUWXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:23:20 -0500
Received: from mail.linser.at ([80.109.168.170] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iu1va-0005pR-LJ; Tue, 21 Jan 2020 23:23:18 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH] arm64: dts: rockchip: fix px30 lvds ports
Date:   Tue, 21 Jan 2020 23:23:17 +0100
Message-ID: <9992820.Mh4mFioDHX@phil>
In-Reply-To: <20200121222055.4068166-2-heiko@sntech.de>
References: <20200121222055.4068166-1-heiko@sntech.de> <20200121222055.4068166-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 21. Januar 2020, 23:20:55 CET schrieb Heiko Stuebner:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> The lvds controller has two ports. port@0 for the connection
> to the display controller(s) and port@1 for the connection to
> the panel, so should have a ports node covering the port@x nodes.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

ignore this second one please :-)
Something went wrong when sending.


