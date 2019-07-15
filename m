Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA1AA6970D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 17:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbfGOPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 11:08:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48165 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733095AbfGOPIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:08:15 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hn2aG-0006iR-Bm; Mon, 15 Jul 2019 17:08:08 +0200
Date:   Mon, 15 Jul 2019 17:08:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Avi Fishman <avifishman70@gmail.com>
cc:     Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clocksource/drivers/npcm: fix GENMASK and timer
 operation
In-Reply-To: <CAKKbWA4jBMG8v4unqWEpGWgRm9CH+EJvojsOwMWTvnQH15HWdQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907151707200.1722@nanos.tec.linutronix.de>
References: <CAKKbWA6S7KotAFtLO=ow=XYnLL2Ny5Mz2kcgM1cs+j=5mHQNmw@mail.gmail.com> <alpine.DEB.2.21.1907151435080.1722@nanos.tec.linutronix.de> <CAKKbWA4jBMG8v4unqWEpGWgRm9CH+EJvojsOwMWTvnQH15HWdQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avi,

On Mon, 15 Jul 2019, Avi Fishman wrote:
> On Mon, Jul 15, 2019 at 3:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >   9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK macro")
> 
> The automatic fix changed from
> GENMASK(3, 27) to
> GENMASK(27, 3)
> I reviewd again the code to check how it worked so far and saw that it
> should have been
> GENMASK(28, 27) - this is a different value than 9bdd7bb3a844
> For our fortune this wrong value didn't effect the our final write to
> the register.
> But still this should be fixed.

Fair enough. Please explain it proper in the changelog.

Thanks,

	tglx
