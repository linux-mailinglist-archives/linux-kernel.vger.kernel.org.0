Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9118CC3CD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 21:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbfJDTzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 15:55:02 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37374 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730836AbfJDTzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:55:02 -0400
Received: from 94.112.246.102.static.b2b.upcbusiness.cz ([94.112.246.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iGTfI-0006St-CU; Fri, 04 Oct 2019 21:55:00 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: add analog audio nodes on rk3399-rockpro64
Date:   Fri, 04 Oct 2019 21:54:59 +0200
Message-ID: <3908342.LUz8zmGQAZ@phil>
In-Reply-To: <74097d16-ec3e-70e9-f835-25ae265b0ad9@katsuster.net>
References: <20190907174833.19957-1-katsuhiro@katsuster.net> <74097d16-ec3e-70e9-f835-25ae265b0ad9@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Katsuhiro,

Am Freitag, 4. Oktober 2019, 19:26:00 CEST schrieb Katsuhiro Suzuki:
> Past about 1 month, so I send a ping...
> 
> On 2019/09/08 2:48, Katsuhiro Suzuki wrote:
> > This patch adds audio codec (Everest ES8316) and I2S audio nodes for
> > RK3399 RockPro64.
> > 
> > Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

thanks for the reminder, applied for 5.5

Heiko


