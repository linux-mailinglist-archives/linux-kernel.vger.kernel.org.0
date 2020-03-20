Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1FC18CAF3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 10:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgCTJ5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 05:57:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35116 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgCTJ5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:57:38 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFEPC-0001Cs-H1; Fri, 20 Mar 2020 10:57:30 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7A509100375; Fri, 20 Mar 2020 10:57:29 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kyung Min Park <kyung.min.park@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, hpa@zytor.com, gregkh@linuxfoundation.org,
        ak@linux.intel.com, tony.luck@intel.com, ashok.raj@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        kyung.min.park@intel.com
Subject: Re: [PATCH v2 0/2] x86/delay: Introduce TPAUSE instruction
In-Reply-To: <1584677604-32707-1-git-send-email-kyung.min.park@intel.com>
References: <1584677604-32707-1-git-send-email-kyung.min.park@intel.com>
Date:   Fri, 20 Mar 2020 10:57:29 +0100
Message-ID: <87a74b4ad2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kyung Min Park <kyung.min.park@intel.com> writes:

> Intel processors that support the WAITPKG feature implement
> the TPAUSE instruction that suspends execution in a lower power
> state until the TSC (Time Stamp Counter) exceeds a certain value.
>
> Update the udelay() function to use TPAUSE on systems where it
> is available. Note that we hard code the deeper (C0.2) sleep
> state because exit latency is small compared to the "microseconds"
> that usleep() will delay.
>
> ChangeLog:
> - Change from v1 to v2:
>   1. The patchset applies after Thomas's cleanup patch as below:
>      https://lkml.org/lkml/diff/2020/3/18/893/1

lkml.org is horrible. Please use lore.kernel.org if at all.

Also please just add the patch to the series when posting so that people
don't have to go through loops and hoops to grab that dependency.

Thanks,

        tglx


