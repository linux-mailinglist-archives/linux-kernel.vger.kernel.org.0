Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C62D6326
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 14:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbfJNM4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 08:56:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38562 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbfJNM4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:56:39 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iJztp-0008OM-0h; Mon, 14 Oct 2019 14:56:33 +0200
Date:   Mon, 14 Oct 2019 14:56:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
cc:     fweisbec@gmail.com, mingo@kernel.org, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] tick: check if broadcast device could really be
 stopped
In-Reply-To: <20191009160246.17898-1-benjamin.gaignard@st.com>
Message-ID: <alpine.DEB.2.21.1910141441350.2531@nanos.tec.linutronix.de>
References: <20191009160246.17898-1-benjamin.gaignard@st.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019, Benjamin Gaignard wrote:
> @@ -78,7 +78,7 @@ static bool tick_check_broadcast_device(struct clock_event_device *curdev,
>  {
>  	if ((newdev->features & CLOCK_EVT_FEAT_DUMMY) ||
>  	    (newdev->features & CLOCK_EVT_FEAT_PERCPU) ||
> -	    (newdev->features & CLOCK_EVT_FEAT_C3STOP))
> +	    tick_broadcast_could_stop(newdev))

No. This might be called _before_ a cpuidle driver is available and then
when that driver is loaded and goes deep, everything goes south.

Aside of that it definitely breaks everything which does not use the
cpuidle stuff, which includes all machines affected by X86_BUG_AMD_APIC_C1E
and everything which uses the INTEL_IDLE driver.

Pretty much the same problem for all other places you changed.

Thanks,

	tglx
