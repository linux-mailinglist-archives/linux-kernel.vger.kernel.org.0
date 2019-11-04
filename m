Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFBBEE689
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 18:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfKDRs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 12:48:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37996 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfKDRs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:48:28 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iRgSp-0002TI-AM; Mon, 04 Nov 2019 18:48:27 +0100
Date:   Mon, 4 Nov 2019 18:48:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hslester96@gmail.com, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [GIT PULL] clockevents for 5.6
In-Reply-To: <6fd4d800-b1f8-d757-458e-23742d20884c@linaro.org>
Message-ID: <alpine.DEB.2.21.1911041845060.17054@nanos.tec.linutronix.de>
References: <6fd4d800-b1f8-d757-458e-23742d20884c@linaro.org>
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

On Mon, 4 Nov 2019, Daniel Lezcano wrote:
> 
> here are the changes for v5.6 timer drivers.

I assume this is targeted at 5.5. If not let me know and I put the
commits into the fridge to keep them fresh until next year :)
 
Thanks,

	tglx
