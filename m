Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B413580A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 12:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfF0Kku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 06:40:50 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33218 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfF0Kku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:40:50 -0400
Received: from wf0413.dip.tu-dresden.de ([141.76.181.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hgRpg-0007Qx-O0; Thu, 27 Jun 2019 12:40:48 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, papadakospan@gmail.com,
        sboyd@kernel.org, mturquette@baylibre.com
Subject: Re: [PATCH 1/3] clk: rockchip: add clock id for watchdog pclk on rk3328
Date:   Thu, 27 Jun 2019 12:40:48 +0200
Message-ID: <3064210.M1lX7hhosJ@phil>
In-Reply-To: <20190615153032.27772-1-heiko@sntech.de>
References: <20190615153032.27772-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 15. Juni 2019, 17:30:30 CEST schrieb Heiko Stuebner:
> Needed to export that added clock.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied all 3 patches to relevant branches for 5.3

Cheers
Heiko


