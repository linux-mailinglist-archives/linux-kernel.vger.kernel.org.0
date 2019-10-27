Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506DFE64D7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 19:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfJ0SWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 14:22:22 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58160 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbfJ0SWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 14:22:22 -0400
Received: from [46.218.74.72] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iOnBE-0008Ha-IL; Sun, 27 Oct 2019 19:22:20 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH] arm64: dts: rockchip: add px30 otp controller
Date:   Sun, 27 Oct 2019 19:21:58 +0100
Message-ID: <10558180.LDrOcu2nhT@phil>
In-Reply-To: <20191023224113.3268-1-heiko@sntech.de>
References: <20191023224113.3268-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 24. Oktober 2019, 00:41:13 CET schrieb Heiko Stuebner:
> The px30 soc contains a controller for one-time-programmable memory,
> so add the necessary node for it and the fields defined in it by default.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied for 5.5


