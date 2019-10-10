Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F212D22B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 10:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbfJJI1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 04:27:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56144 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733202AbfJJI1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:27:07 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iITm9-0002M8-BR; Thu, 10 Oct 2019 10:26:21 +0200
Date:   Thu, 10 Oct 2019 10:26:21 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/8] clocksource/drivers/timer-atmel-tcb: add sama5d2
 support
Message-ID: <20191010082602.ytfc2tilizruwrts@linutronix.de>
References: <20191009224006.5021-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191009224006.5021-1-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-10 00:39:58 [+0200], Alexandre Belloni wrote:
> This series mainly adds sama5d2 support where we need to avoid using
> clock index 0 because that clock is never enabled by the driver.
> 
> There is also a rework of the 32khz clock handling so it is not used for
> clockevents on 32 bit counter because the increased rate improves the
> resolution and doesn't have any drawback with that counter width. This
> replaces a patch that has been carried in the linux-rt tree for a while.

Thank you for doing this!

Sebastian
