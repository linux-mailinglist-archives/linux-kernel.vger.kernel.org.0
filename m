Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 060E8F224
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 10:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfD3Ijt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 04:39:49 -0400
Received: from mail-n.franken.de ([193.175.24.27]:54041 "EHLO drew.franken.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfD3Ijs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:39:48 -0400
Received: from perth.hirmke.de (aquarius.franken.de [193.175.24.89])
        (Authenticated sender: antares)
        by mail-n.franken.de (Postfix) with ESMTPSA id 7E220721E2830
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 10:39:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by perth.hirmke.de (Postfix) with ESMTP id 3C025964AD0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 10:39:45 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Header field occurs more than once: "Cc"
        occurs 7 times
Received: from perth.hirmke.de ([127.0.0.1])
        by localhost (perth.hirmke.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id XFZ9nsj8Y-NI for <linux-kernel@vger.kernel.org>;
        Tue, 30 Apr 2019 10:39:44 +0200 (CEST)
Received: by perth.hirmke.de (Postfix, from userid 10)
        id 1B332964A5A; Tue, 30 Apr 2019 10:39:41 +0200 (CEST)
Received: by mike.franken.de (OpenXP/5.0.34 (Linux) (x86_64));
          30 Apr 2019 10:39:33 +0200
Date:   30 Apr 2019 10:39:00 +0200
From:   opensuse@mike.franken.de (Michael Hirmke)
To:     jslaby@suse.cz
Cc:     tiwai@suse.de
Cc:     bhelgaas@google.com
Cc:     ckellner@redhat.com
Cc:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Cc:     lukas@wunner.de
Cc:     mika.westerberg@linux.intel.com
Message-ID: <EksOpJxc6GB@mike.franken.de>
In-Reply-To: <s5hsgu0ihyg.wl-tiwai@suse.de>
Subject: Re: [REGRESSION 5.0.8] Dell thunderbolt dock broken (xhci_hcd and thunderbolt)
User-Agent: OpenXP/5.0.34 (Linux) (x86_64)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline;
 modification-date="30 Apr 2019 08:38:55 +0000";
 read-date="Tue, 30 Apr 2019 10:38:55 +0200";
 creation-date="Tue, 30 Apr 2019 10:38:55 +0200"
Organization: Kommunikationsnetz Franken e.V. (Nuernberg)
Reply-To: mh@mike.franken.de
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

[...]
>>> I also have XPS 9370 but not that particular dock. I will check tomorrow
>>> if I can reproduce it as well.
>>
>> There aren't too many changes between 5.0.7 and 5.0.8 that touch
>> PCI/ACPI. This is just a shot in the dark but could you try to revert:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.gi
>>   t/commit/?h=linux-5.0.y&id=da6a87fb0ad43ae811519d2e0aa325c7f792b13a
>>
>> and see if it makes any difference?

>OK, I'm building a test kernel package with the revert in OBS
>home:tiwai:bsc1133486 repo.  A new kernel will be
>kernel-default-5.0.10-*g8edeab8:
>  http://download.opensuse.org/repositories/home:/tiwai:/bsc1133486/standard/

>Michael, once when the new kernel is ready, please give it a try.

as far as I can see, state is back to normal with this kernel.
No more error messages or crashing modules and all devices seem to work
as expected.
Only thing is, that the external devices connected to the Thunderbolt
dock are coming up a little bit slower than with 5.0.7 - but this is
nothing, I'd worry about.

>thanks,

Thank *you*.

>Takashi

Bye.
Michael.
-- 
Michael Hirmke
