Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF1C19BEFA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbgDBJ57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 05:57:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36813 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgDBJ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:57:59 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJwbh-00013E-B2; Thu, 02 Apr 2020 11:57:53 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D2C75100D52; Thu,  2 Apr 2020 11:57:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        qemu-discuss@nongnu.org, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: qemu-x86: kernel panic when host is loaded
In-Reply-To: <20200402093132.GA15839@Red>
References: <20200402093132.GA15839@Red>
Date:   Thu, 02 Apr 2020 11:57:52 +0200
Message-ID: <87eet6nra7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corentin,

Corentin Labbe <clabbe.montjoie@gmail.com> writes:
> On our kernelci lab, each qemu worker pass an healtcheck job each day and after each job failure, so it is heavily used.
> The healtcheck job is a Linux boot with a stable release.
>
> Since we upgraded our worker to buster, the qemu x86_64 healthcheck randomly panic with:
> <0>[    0.009000] Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report.  Then try booting with the 'noapic' option.
>
> After some test I found the source of this kernel panic, the host is
> loaded and qemu run "slower".  Simply renicing all qemu removed this
> behavour.
>
> So now what can I do ?
> Appart renicing qemu process, does something could be done ?

As the qemu timer/ioapic routing is actually sane, you might try to add
"no_timer_check" to the kernel command line.

Thanks,

        tglx

