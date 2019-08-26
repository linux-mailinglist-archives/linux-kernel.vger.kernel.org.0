Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4EF9D7DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 23:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfHZU7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 16:59:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41204 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfHZU7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:59:46 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2M5T-0005Zl-CV; Mon, 26 Aug 2019 22:59:39 +0200
Date:   Mon, 26 Aug 2019 22:59:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Anson Huang <anson.huang@nxp.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jon Hunter <jonathanh@nvidia.com>,
        Magnus Damm <damm+renesas@opensource.se>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] timers drivers v5.5
In-Reply-To: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
Message-ID: <alpine.DEB.2.21.1908262257570.1939@nanos.tec.linutronix.de>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019, Daniel Lezcano wrote:

> The following changes since commit 08a3c192c93f4359a94bf47971e55b0324b72b8b:
> 
>   posix-timers: Prepare for PREEMPT_RT (2019-08-01 20:51:25 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/daniel.lezcano/linux.git tags/timers-v5.5

5.5 - that's for next year's first kernel so I'll put it into the fridge for now.


