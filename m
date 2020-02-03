Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 583EA150F19
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 19:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgBCSIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 13:08:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60301 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgBCSIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:08:13 -0500
Received: from [185.104.136.29] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iyg8n-0005sR-MD; Mon, 03 Feb 2020 19:08:09 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id AAAFD100C1B; Mon,  3 Feb 2020 19:08:03 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-kernel@vger.kernel.org
Cc:     "Sverdlin\, Alexander \(Nokia - DE\/Ulm\)" 
        <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH RESEND] cpu/hotplug: Wait for cpu_hotplug to be enabled in cpu_up/down
In-Reply-To: <d950a169-941e-7caa-608a-df97a127c95d@nokia.com>
References: <d950a169-941e-7caa-608a-df97a127c95d@nokia.com>
Date:   Mon, 03 Feb 2020 19:08:03 +0100
Message-ID: <87o8uf1r3w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matija,

Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com> writes:

> Heavier user of cpu_hotplug_enable/disable is pci_device_probe yielding
> errors on bringing cpu cores up/down if pci devices are getting probed.
> Situation in which pci devices are getting probed and having cpus going
> down/up is valid situation.

So what?. User space has to handle -EBUSY properly and it was possible
even before that PCI commit that the online/offline operation request
returned -EBUSY. 

> Problem was observed on x86 board by having partitioning of the system
> to RT/NRT cpu sets failing (of which part is to bring cpus down/up via
> sysfs) if pci devices would be getting probed at the same time. This is

I have no idea why you need to offline/online CPUs to partition a
system. There are surely more sensible ways to do that, but that's not
part of this discussion.

> confusing for userspace as dependency to pci devices is not clear.

What's confusing about a EBUSY return code? It's pretty universaly used
in situations where a facility is temporarily busy. If it's not
sufficiently documented, why EBUSY can be returned and what that means,
then this needs to be improved.

> Fix this behavior by waiting for cpu hotplug to be ready. Return -EBUSY
> only after hotplugging was not enabled for about 10 seconds.

There is nothing to fix here, really. Fix the user space handling which
fails to handle EBUSY. Just because this commit made it more likely that
EBUSY is returned does not justify this horrid hack.

Thanks,

        tglx
