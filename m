Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6D9AE9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 14:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfIJL77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 07:59:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49051 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfIJL77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:59:59 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i7eoL-0003mF-92; Tue, 10 Sep 2019 13:59:53 +0200
Message-ID: <1568116792.3062.3.camel@pengutronix.de>
Subject: Re: [PATCH] reset: uniphier-glue: Add Pro5 USB3 support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Date:   Tue, 10 Sep 2019 13:59:52 +0200
In-Reply-To: <20190910205640.6ABD.4A936039@socionext.com>
References: <1568080527-1767-1-git-send-email-hayashi.kunihiko@socionext.com>
         <1568101695.3062.1.camel@pengutronix.de>
         <20190910205640.6ABD.4A936039@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kunihiko,

On Tue, 2019-09-10 at 20:56 +0900, Kunihiko Hayashi wrote:
[...]
> This driver is derived from reset-simple, so the method to control reset
> in the glue block is the same for each SoC.
> 
> And both Pro4 and Pro5 need same parent clock and reset, so the data for
> these SoCs refer same parent clock names and parent reset names.
> 
> However, since the glue block itself can be different, I think that
> compatible string should be distinguished for each SoC.

Ok, in that case I'll apply the patch as-is. Thank you for clarifying.

regards
Philipp
