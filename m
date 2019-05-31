Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3E230C88
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 12:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfEaK2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 06:28:09 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:54130 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfEaK2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:28:07 -0400
Received: from g550jk.localnet (80-110-121-20.cgn.dynamic.surfer.at [80.110.121.20])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id A4A83C59F0;
        Fri, 31 May 2019 10:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1559298485; bh=Se4dUZTYep0OSyM0WeJ2pYjOSnGAVavK0huOC+bbDCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YH+IXwzLuOG3Z6tvsWcUim+3YLlZU9jcxO0xv+Y38t1ecU/TXC1hL1kwFL99yHXga
         hJoaRYID5kqhEUscXaNRwE0waJAd8xM3j0sFWwqz269g02BH6RRe4nenMKPUlGbOEG
         LYC0MdrlJTxZD8G0yw/6iRueY8ftowp/h4ovDw5o=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add lradc node
Date:   Fri, 31 May 2019 12:27:55 +0200
Message-ID: <6901794.oDhxEVzEqc@g550jk>
In-Reply-To: <20190524092001.ztf3kntaj4uiswnv@flea>
References: <20190518170929.24789-1-luca@z3ntu.xyz> <4343071.IDWclfcoxo@g550jk> <20190524092001.ztf3kntaj4uiswnv@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 24. Mai 2019 11:20:01 CEST Maxime Ripard wrote:
> 
> It would be great to drop the -keys from the compatible, and to
> document the bindings
> 
> Looks good otherwise
> 
> Maxime

Hi again,

So I should just document the "allwinner,sun50i-a64-lradc" string in 
Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt ? Don't I also 
have to add the compatible to the driver code then? Just adding the a64 
compatible to a dts wouldn't work without that.

Thanks, Luca



