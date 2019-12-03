Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23AF710FCEA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 12:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfLCLy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 06:54:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35544 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfLCLy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:54:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so3355015wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 03:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+WIWRDqUrNa3Vz0vkAgniAzsAnjKkXYESaBrWD4fFkM=;
        b=m4qrb6yiypHYi3ZRGQQi8dTn37rz5gbDv916tRh9lEUdzVQS1fefAKVt1XSqOD2Jqq
         7ZID4YZZPfS5mkVCCksveucYj7fn7BUPaqYXBLdLiss83ZWi/kSm0E826/NbVFG5GdSB
         NyNPuqdf0aXggsIV5L+SDYMgwgVSQ9M7OBtdGemRKQP3evBS+9eq7UoLznKxdHOQtUSv
         qQgnZLrXb3vOkurhU4K32yoDy2t4jqhNhyBZqEQQkJB/kmZqhzS4BGGbfjTyh36FD3DC
         +AsENHgPSULSPolwUQ0GkWOQtnSeODHlPu6zER3S7jFtpYAflxjZrTL2BAV1w/PiS0Ko
         rHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+WIWRDqUrNa3Vz0vkAgniAzsAnjKkXYESaBrWD4fFkM=;
        b=dI9IvZVp5Gj2yak7kOVC3jBK+kt45dtBAS9z2QwQlMh2a1Fnk5KjK+qoKww/WzWxeb
         nB7iFVo4ipI85J8T1kO4xJYovnLVErUvf21E+hliEMUK+8wdmylSAFemgxtX2Q9GQw5P
         CYJZEwJqPtESzWIMvvx6hkzGfaikNGuM9hpxSZ8LiKA1CRRJ8vVMpM/s13+EwreYS2Uk
         EJM1+xEyeTMzvGsyVpo/weVs3C1RNTms1zAQIuQ3uaS7R3xtjgvR7n1V2Br5VbXWZuB2
         +hpP9xwR53p1PchiMBOouf0FBiGOgHxiwMkelrvha7CbAtK3VRLkrufc3NKlfAz+GhhF
         w/3A==
X-Gm-Message-State: APjAAAUKyunRtK/IshPZENOdT3cAkHPvTZxIWVUqRGdL3Ab0NJ48ktau
        BQxWeUvC/dI25G7fNhKzqfVQCNpOpPGvdyQhSPdHYg==
X-Google-Smtp-Source: APXvYqyD/zVkD/KsKt1cRJSy2Z57/rlzCyPRyodpEegh31zXluD3a/OFt1wjQuEeziXjQKeJ5PV4912fiFxOPxivXsE=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr4497199wrr.32.1575374066240;
 Tue, 03 Dec 2019 03:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com> <CACdnJus7nHdr4p4H1j5as9eB=FG-uX+wy_tjvTQ5ObErDJHdow@mail.gmail.com>
In-Reply-To: <CACdnJus7nHdr4p4H1j5as9eB=FG-uX+wy_tjvTQ5ObErDJHdow@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 3 Dec 2019 11:54:21 +0000
Message-ID: <CAKv+Gu8emrf7WbTyGc8QDykX_hZbrVtxJKkRVbGFhd8rd13yww@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Matthew Garrett <mjg59@google.com>,
        Laszlo Ersek <lersek@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Laszlo)

On Tue, 3 Dec 2019 at 00:43, Matthew Garrett <mjg59@google.com> wrote:
>
> On Mon, Dec 2, 2019 at 4:40 PM Matthew Garrett
> <matthewgarrett@google.com> wrote:
> >
> > Add an option to disable the busmaster bit in the control register on
> > all PCI bridges before calling ExitBootServices() and passing control to
> > the runtime kernel. System firmware may configure the IOMMU to prevent
> > malicious PCI devices from being able to attack the OS via DMA. However,
> > since firmware can't guarantee that the OS is IOMMU-aware, it will tear
> > down IOMMU configuration when ExitBootServices() is called. This leaves
> > a window between where a hostile device could still cause damage before
> > Linux configures the IOMMU again.
>
> I don't know enough about ARM to know if this makes sense there as well. Anyone?

There is no reason this shouldn't apply to ARM, but disabling bus
mastering like that before the drivers themselves get a chance to do
so is likely to cause trouble. Network devices or storage controllers
that are still running and have live descriptor rings in DMA memory
shouldn't get the rug pulled from under their feet like that by
blindly disabling the BM attribute on all root ports before their
drivers have had the opportunity to do this cleanly.

One trick we implemented in EDK2 for memory encryption was to do the
following (Laszlo, mind correcting me here if I am remembering this
wrong?)
- create an event X
- register an AtExitBootServices event that signals event X in its handler
- in the handler of event X, iterate over all PPBs to clear the bus
master attribute
- for bonus points, do the same for the PCIe devices themselves,
because root ports are known to exist that entirely ignore the BM
attribute

This way, event X should get handled after all the drivers' EBS event
handlers have been called.
