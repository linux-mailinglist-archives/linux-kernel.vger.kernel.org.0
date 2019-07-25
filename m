Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8660775852
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 21:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfGYTrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 15:47:55 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39198 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfGYTrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:47:55 -0400
Received: from d57e23da.static.ziggozakelijk.nl ([213.126.35.218] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hqjiK-0001nu-FG; Thu, 25 Jul 2019 21:47:44 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, andy.yan@rock-chips.com,
        zhangqing@rock-chips.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] clk: rockchip: Fix -Wunused-const-variable
Date:   Thu, 25 Jul 2019 21:47:42 +0200
Message-ID: <1785547.ocfUNUBeK4@phil>
In-Reply-To: <20190627222220.89175-1-nhuck@google.com>
References: <20190627222220.89175-1-nhuck@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 28. Juni 2019, 00:22:20 CEST schrieb Nathan Huckleberry:
> Clang produces the following warning
> 
> drivers/clk/rockchip/clk-rv1108.c:125:7: warning: unused variable
> 'mux_pll_src_3plls_p' [-Wunused-const-variable]
> PNAME(mux_pll_src_3plls_p)      = { "apll", "gpll", "dpll" };
> 
> Looks like this variable was never used. Deleting it to remove the
> warning.
> 
> Cc: clang-built-linux@googlegroups.com
> Link: https://github.com/ClangBuiltLinux/linux/issues/524
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

applied for 5.4

Thanks
Heiko


