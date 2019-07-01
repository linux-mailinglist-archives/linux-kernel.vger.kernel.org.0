Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC31A5215D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 05:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfFYDvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 23:51:41 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45149 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfFYDvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 23:51:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id j19so16894940qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 20:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXJGETA/jJ0RNhUF4386IT59bPJr3Q37TZWH9CEiV9k=;
        b=hPTBh4P3Z7HxVQ1mJ762Mok61s1wxcWhUnvGdnKDOaJTWE83YvvY0cc1YDOaiqd7vi
         P0dDipAcCaZ3dHpKLAGwgnGe0Wgaqa+bfKynMaz5tBjJfnuAqFAdL/EyJ1eBrWezVs18
         ptnXHf7dxFDxwwoatvW15kdM1tOnFINndIdadOxn7Dk0tjxXq17X1zlMTKGMBeO3b8Zm
         CibeF4oHmo8j+8hQhCu5ZgDkBrUCBcBMoI3D++8Yr59saKhcuEnuSpamgac/xxgwUq4C
         THweH29RavF2tBZv3uTko+ba1VYlOn8w+7/GRUWWJgQ+XnCy35AbL6JKasygZeZRbaY2
         XhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXJGETA/jJ0RNhUF4386IT59bPJr3Q37TZWH9CEiV9k=;
        b=UfQheGp5UjzyNWrdSReHDQ3dCBQxB9oQ8jtO70d0aDC9e5RAYnThgnB3oQsdKeQkh5
         zOQKHP/OGaAfFUENaFz/HIj0i/KGWtNk/UJYnT789is2VRUfG4qUTnwqxgNEaOat6eRs
         7CMtbZuEZCADZRjHv4arsJBfxFCW8vBPFPRbhhuasJsAD2mCnjDAIgvpiR46rOFx1/M+
         YHK1qBlgx06quqZ21fJxWLWYxvfbN5QYvWrSqwEiyCHK8Aiwc4Lf2c6nZAvlRJdPZv7Y
         P36kimXAK5jFuw+sLJ9Qrkvgxy2dzFmuMIixuxK5Rw1i96BQbWiyLjkM9HUHgHU7vKdk
         hXqA==
X-Gm-Message-State: APjAAAWL2lwNJ9y/AlZmIn6HIZcY375u2n+XmTqjfP+RnYiSFIo4tdzf
        rWi/u9C7AE3XPyeSwFdANxJb3rnC7YAB6rDhyiqxJg==
X-Google-Smtp-Source: APXvYqysYiUZoWD/Jf4xCDTfTLYGuMOk+c5m665oC/suZNO5Km6hGfXjFCr3fn7wYiYo6ZCFPd5whrK8A0sCv8hhNSU=
X-Received: by 2002:a0c:9807:: with SMTP id c7mr30275759qvd.26.1561434700099;
 Mon, 24 Jun 2019 20:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190620051333.2235-1-drake@endlessm.com> <20190620051333.2235-3-drake@endlessm.com>
 <20190620061038.GA20564@lst.de> <CAD8Lp45ua=L+ixO+du=Njhy+dxjWobWA+V1i+Y2p6faeyt1FBQ@mail.gmail.com>
 <20190624061617.GA2848@lst.de>
In-Reply-To: <20190624061617.GA2848@lst.de>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 25 Jun 2019 11:51:28 +0800
Message-ID: <CAD8Lp464B0dOd+ayF_AK4DRzHEpiaSbUOXjVJ5bq5zMXq=BBKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] nvme: rename "pci" operations to "mmio"
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-ide@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 2:16 PM Christoph Hellwig <hch@lst.de> wrote:
> IFF we want to support it it has to be done at the PCIe layer.  But
> even that will require actual documentation and support from Intel.
>
> If Intel still believes this scheme is their magic secret to control
> the NVMe market and give themselves and unfair advantage over their
> competitors there is not much we can do.

Since the 2016 discussion, more documentation has been published:
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/300-series-chipset-pch-datasheet-vol-2.pdf
Chapter 15 is entirely new, and section 15.2 provides a nice clarity
improvement of the magic regs in the AHCI BAR, which I have used in
these patches to clean up the code and add documentation in the header
(see patch 1 in this series, ahci-remap.h).

I believe there's room for further improvement in the docs here, but
it would be nice to know what you see as the blocking questions or
documentation gaps that would prevent us from continuing to develop
the fake PCI bridge approach
(https://marc.info/?l=linux-pci&m=156015271021614&w=2). We are going
to try and push Intel on this via other channels to see if we can get
a contact to help us, so it would be useful if I can include a
concrete list of what we need.

Bearing in mind that we've already been told that the NVMe device
config space is inaccessible, and the new docs show exactly how the
BIOS enforces such inaccessibility during early boot, the remaining
points you mentioned recently were:

 b) reset handling, including the PCI device removal as the last
    escalation step
 c) SR-IOV VFs and their management
 d) power management

Are there other blocking questions you would require answers to?

Thanks,
Daniel
