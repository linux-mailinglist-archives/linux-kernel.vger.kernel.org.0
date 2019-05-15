Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC7B1EAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 11:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfEOJZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 05:25:23 -0400
Received: from nbd.name ([46.4.11.11]:52580 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfEOJZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:25:22 -0400
Received: from p548c8a24.dip0.t-ipconnect.de ([84.140.138.36] helo=[192.168.178.20])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hQq9w-0006aH-TN; Wed, 15 May 2019 11:25:12 +0200
Subject: Re: [PATCH] clk: Remove io.h from clk-provider.h
To:     Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Tero Kristo <t-kristo@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <20190514170931.56312-1-sboyd@kernel.org>
From:   John Crispin <john@phrozen.org>
Message-ID: <da02de1e-40cb-d76b-7742-9b3b7db8107c@phrozen.org>
Date:   Wed, 15 May 2019 11:25:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514170931.56312-1-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/05/2019 19:09, Stephen Boyd wrote:
> Now that we've gotten rid of clk_readl() we can remove io.h from the
> clk-provider header and push out the io.h include to any code that isn't
> already including the io.h header but using things like readl/writel,
> etc.

for arch/mips/ath79/*

Acked-by: John Crispin <john@phrozen.org>

