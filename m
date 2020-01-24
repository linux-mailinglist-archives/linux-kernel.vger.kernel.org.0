Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F30B11475E5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 02:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgAXBE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 20:04:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41273 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbgAXBE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:04:57 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iunOz-0002FU-R1; Fri, 24 Jan 2020 02:04:49 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 2C1EF100490; Fri, 24 Jan 2020 02:04:49 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephen Boyd <swboyd@chromium.org>,
        John Stultz <john.stultz@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 3/3] alarmtimer: Always export alarmtimer_get_rtcdev() and update docs
In-Reply-To: <20200121194811.145644-4-swboyd@chromium.org>
References: <20200121194811.145644-1-swboyd@chromium.org> <20200121194811.145644-4-swboyd@chromium.org>
Date:   Fri, 24 Jan 2020 02:04:49 +0100
Message-ID: <87lfpx1x72.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Boyd <swboyd@chromium.org> writes:
> The export isn't there for the stubbed version of
> alarmtimer_get_rtcdev(), so move the export outside of the ifdef. And
> rtcdev isn't used outside of this ifdef so we don't need to redefine it
> as NULL.

This does not make any sense. Why would we export a trivial stub which
just returns NULL?

The right thing to do is to make that an inline function in the relevant
header file.

> @@ -67,8 +67,6 @@ static DEFINE_SPINLOCK(rtcdev_lock);
>   * alarmtimer_get_rtcdev - Return selected rtcdevice
>   *
>   * This function returns the rtc device to use for wakealarms.
> - * If one has not already been chosen, it checks to see if a
> - * functional rtc device is available.

Unrelated comment change which is not explained in the changelog. Please
make that a separate patch as it has absolutely nothing to do with the
stub function issue.

Thanks,

        tglx
