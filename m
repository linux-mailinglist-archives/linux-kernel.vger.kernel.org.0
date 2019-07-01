Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE022799
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2019 19:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfESRUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 May 2019 13:20:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55672 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfESRUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:20:42 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hSO9r-000660-SR; Sun, 19 May 2019 17:55:32 +0200
Date:   Sun, 19 May 2019 17:55:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
cc:     Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] time: validate watchdog clocksource using second
 best candidate
In-Reply-To: <alpine.DEB.2.21.1905182023520.3019@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1905191753300.3019@nanos.tec.linutronix.de>
References: <155790645605.1933.906798561802423361.stgit@buzz> <alpine.DEB.2.21.1905181712000.3019@nanos.tec.linutronix.de> <602b155f-4108-2865-3f1c-4e63d73405ed@yandex-team.ru> <alpine.DEB.2.21.1905182023520.3019@nanos.tec.linutronix.de>
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

On Sat, 18 May 2019, Thomas Gleixner wrote:
> On Sat, 18 May 2019, Konstantin Khlebnikov wrote:
> > If there is no second clocksource my patch does noting:
> > watchdog_backup stays NULL and backup_consent always true.
> 
> That still does not justify the extra complexity for a few custom built
> systems.

Aside of that this leaves the HPET in a half broken state. HPET is not only
used as a clock event device it's also exposed by HPET device. So no, if we
figure out that HPET is broken on some platforms we have to blacklist and
disable it completely and not just duct tape the place which exposes the
wreckage.

Thanks,

	tglx
