Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6348CF726E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 11:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKKKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 05:46:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40160 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfKKKqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:46:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id i10so14049062wrs.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 02:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unipv-it.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yxRDzZD0x5jD7UV3+6FgosgP6nkWD8N7G9X6bEPt3Ko=;
        b=Tu38d6k7Kks+jbAkbbo/OmauYHik4AILQ5Y/vMGRYIxYmJXSBQUMT31+rWKpB8n5C+
         tzW7pQ2VBLpQr7W/IRcsXy2+2ofxFz49LK4wk4TIKJwTnqGExvFmjQ6x5NwmR2GsgVE/
         OhEKZ6KCX4TNbqXG3Zk0Y7ijGbW5Wtodg5sBNY/HxvUat1oMQlLr9n8jw60jFI3TATxV
         KAPF7mE/JMtDxDlQOzIXD76pvW+iVkurq16aOnThc/JVc3OyfyjWso0irPU8djwKiPh+
         nrg/srnzANwefFwC2rqwpa5/9jhzkRGsNSMNRnVae66vvTWuLmNQIc0ac7Y8RWOS0laK
         tjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=yxRDzZD0x5jD7UV3+6FgosgP6nkWD8N7G9X6bEPt3Ko=;
        b=YJ/+iZ7r30nd1TXpRaxK9zrRR62fd72LBn83GBkzwn9bojH5ILc7ZFzgqosAYAGyLy
         KLUTP5MZxrvzvcwa/tXcHoaVSS8K8YaLhdX14nfmE++iTV1EcopO6nBIFPan0scGcmRp
         Q2E9ale9WgOdk71WQKErVIokar2TwqD3gM10+42dyy0tF/1MPTyY5k64r4eoLpboFjK0
         lQ1iuoSW3LDD5UbA2J1PklTBp2AOv76nuZdp136fBYqV8RkB3QpeiCTsLUDWA1sQ4Gnt
         rB2Ck1WefHhR/2hl3zrqvef09OVGDk4C2IEHdhYidsFX6lBXCVqeYCG7/JyLPasIR0D7
         nzVQ==
X-Gm-Message-State: APjAAAV32YL+hy1Ehb83iKlNagx6zbUkk/u1D9CZdx6RcY5ps2mYaPQ3
        L+1f+ZqD6aQjmoI9BZ6fDMJKX+SivXtJBQ==
X-Google-Smtp-Source: APXvYqxqlbmvGsUuWvUwKyWh56kj/hB+AZN1goluANcijZ7NQ7eKypL+NIUquzFnIJw7f56MBUSAmw==
X-Received: by 2002:a5d:4585:: with SMTP id p5mr20987500wrq.134.1573469173805;
        Mon, 11 Nov 2019 02:46:13 -0800 (PST)
Received: from angus.unipv.it (angus.unipv.it. [193.206.67.163])
        by smtp.gmail.com with ESMTPSA id w18sm14288552wrl.2.2019.11.11.02.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 02:46:13 -0800 (PST)
Message-ID: <83c6176bf08d52bf71a4635d62a1c2c4ad97a88d.camel@unipv.it>
Subject: Re: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
From:   Andrea Vai <andrea.vai@unipv.it>
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        USB list <linux-usb@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Date:   Mon, 11 Nov 2019 11:46:12 +0100
In-Reply-To: <72fc7fd1-cf86-969c-d1ed-36201cf9510a@kernel.dk>
References: <Pine.LNX.4.44L0.1911061044070.1694-100000@iolanthe.rowland.org>
         <BYAPR04MB5816640CEF40CB52430BBD3AE7790@BYAPR04MB5816.namprd04.prod.outlook.com>
         <b22c1dd95e6a262cf2667bee3913b412c1436746.camel@unipv.it>
         <BYAPR04MB58167B95AF6B7CDB39D24C52E7780@BYAPR04MB5816.namprd04.prod.outlook.com>
         <CAOsYWL3NkDw6iK3q81=5L-02w=VgPF_+tYvfgnTihgCcwKgA+g@mail.gmail.com>
         <BYAPR04MB5816ECD4302AD94338CB9072E77B0@BYAPR04MB5816.namprd04.prod.outlook.com>
         <72fc7fd1-cf86-969c-d1ed-36201cf9510a@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno ven, 08/11/2019 alle 07.33 -0700, Jens Axboe ha scritto:
> On 11/8/19 1:42 AM, Damien Le Moal wrote:
> > On 2019/11/08 4:00, Andrea Vai wrote:
> >> [Sorry for the duplicate message, it didn't reach the lists due
> to
> >> html formatting]
> >> Il giorno gio 7 nov 2019 alle ore 08:54 Damien Le Moal
> >> <Damien.LeMoal@wdc.com> ha scritto:
> >>>
> >>> On 2019/11/07 16:04, Andrea Vai wrote:
> >>>> Il giorno mer, 06/11/2019 alle 22.13 +0000, Damien Le Moal ha
> scritto:
> >>>>>
> >>>>>
> >>>>> Please simply try your write tests after doing this:
> >>>>>
> >>>>> echo mq-deadline > /sys/block/<name of your USB
> >>>>> disk>/queue/scheduler
> >>>>>
> >>>>> And confirm that mq-deadline is selected with:
> >>>>>
> >>>>> cat /sys/block/<name of your USB disk>/queue/scheduler
> >>>>> [mq-deadline] kyber bfq none
> >>>>
> >>>> ok, which kernel should I test with this: the fresh git cloned,
> or the
> >>>> one just patched with Alan's patch, or doesn't matter which
> one?
> >>>
> >>> Probably all of them to see if there are any differences.
> >>
> >> with both kernels, the output of
> >> cat /sys/block/sdh/queue/schedule
> >>
> >> already contains [mq-deadline]: is it correct to assume that the
> echo
> >> command and the subsequent testing is useless? What to do now?
> > 
> > Probably, yes. Have you obtained a blktrace of the workload during
> these
> > tests ? Any significant difference in the IO pattern (IO size and
> > randomness) and IO timing (any device idle time where the device
> has no
> > command to process) ? Asking because the problem may be above the
> block
> > layer, with the file system for instance.
> 
> blktrace would indeed be super useful, especially if you can do that
> with a kernel that's fast for you, and one with the current kernel
> where it's slow.
> 
> Given that your device is sdh, you simply do:
> 
> # blktrace /dev/sdh
> 
> and then run the test, then ctrl-c the blktrace. Then do:
> 
> # blkparse sdh > output
> 
> and save that output file. Do both runs, and bzip2 them up. The
> shorter
> the run you can reproduce with the better, to cut down on the size
> of
> the traces.

Sorry, the next message from Ming...

-----
You may get the IO pattern via the previous trace 
https://lore.kernel.org/linux-usb/20190710024439.GA2621@ming.t460p/

IMO, if it is related write order, one possibility could be that
the queue lock is killed in .make_request_fn().
-----

...made me wonder if I should really do the blkparse trace test, or
not. So please confirm if it's needed (testing is quite time-consuming 
, so I'd like to do it if it's needed).

Thanks, and bye,
Andrea

