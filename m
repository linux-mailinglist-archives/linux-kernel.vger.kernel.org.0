Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 297DA2107F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 00:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfEPWXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 18:23:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57212 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfEPWXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 18:23:52 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hROmt-0007Ew-NA; Fri, 17 May 2019 00:23:43 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/clk/rockchip/clk-rk3228.c: add 1.464GHz clock rate
Date:   Fri, 17 May 2019 00:23:42 +0200
Message-ID: <5025740.0R6fdBNFxo@phil>
In-Reply-To: <20190516124437.4906-1-justin.swartz@risingedge.co.za>
References: <20190516124437.4906-1-justin.swartz@risingedge.co.za>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

Am Donnerstag, 16. Mai 2019, 14:44:36 CEST schrieb Justin Swartz:
> Add missing 1.464GHz clock rate to rk3228_cpuclk_rates[]
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

I've applied the patch for kernel 5.3 and adapted the subject
plus commit message a bit to:

"clk: rockchip: add 1.464GHz cpu-clock rate to rk3228
    
Add missing 1.464GHz clock rate to rk3228_cpuclk_rates[], which gets
referenced in the operating points but wasn't defined till now."

So just for you next submissions:
The patch subject should match the subsystem prefix which you can see with
something like "git log --oneline drivers/clk/rockchip" and the commit
message can be as verbose as you like.

So just to clarify, no need to change anything for this patch, just to
keep in mind for future patches :-) .

Thanks
Heiko


