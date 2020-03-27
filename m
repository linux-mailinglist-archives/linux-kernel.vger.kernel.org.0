Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F8E194DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 01:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgC0ANu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 20:13:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35924 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgC0ANt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 20:13:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id g12so8445424ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 17:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWL8ZSPmJAiTPJ9JjQW1j0bE8X/JpNZikw6inrx3YQI=;
        b=NF52MK0PSlUZLDII9gyz0ifyNpp+j4BfKlYt4/XYvcsq/F4CYzlG/eu4r9j94+PpNJ
         hs97iUKCE+zNoq9ZfdDg26kpdiiEk3q5ik+SmcihoAeyK88CnY534dCGxNjVD5tyECex
         HKTILpbONOMGNIOIYyRDBDM7Fd7DDehT6OnDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWL8ZSPmJAiTPJ9JjQW1j0bE8X/JpNZikw6inrx3YQI=;
        b=V9Aad+FFmAmDYV1CW3oVmpjWLDgMBDSRt/DVC7ibhrvnAYeHYjahmqBJElgWQmR3ce
         aEydnMLE94SVkZbYGFvkTWPuTV1NtIltJvP/kLq1p/yUSeXUwh/CWQptBjk2Dh0ysQRT
         +WJT1aetFDvMC3chTlcAoivpQ/d20TDE1G5CKm0N9aWPy/e1RU9MWjcjg0cT8eVESVAX
         D29TahoY9HixeaGX/VLlw2L85p6K32sLlIeK4/JkPgQ6ta4HVBtDbYWPUIxMahvUmfgJ
         ssINuOIGUFQDy9D3n6BpQsH1aKbrpQbuXAZQBXqqGFQ78ns4P0VMECXiNpeNxLJRdouQ
         NrhA==
X-Gm-Message-State: ANhLgQ1BrumiuYrTWSWR1/0JoKuA519Y0KceFAJ1gTiC92KiknkpwXhM
        I5D7TZQLVAkiaaFCxn3R3ee9hHxXMIadSnPqF6KNtw==
X-Google-Smtp-Source: APiQypLZZN1Wtl3gwV5mELpsM2qhhqZ5leW/rlMatp78zM7+LnJ5TdE1codyNmtsIAOipZ4iyk3U+CiOz4xZhRZZUog=
X-Received: by 2002:a2e:83cf:: with SMTP id s15mr6529050ljh.36.1585268027186;
 Thu, 26 Mar 2020 17:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200326075938.65053-1-mcchou@chromium.org> <20200326005931.v3.1.I0e975833a6789e8acc74be7756cd54afde6ba98c@changeid>
 <ADF19483-721C-4263-8CA8-CF4587E79BA4@holtmann.org>
In-Reply-To: <ADF19483-721C-4263-8CA8-CF4587E79BA4@holtmann.org>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Thu, 26 Mar 2020 17:13:36 -0700
Message-ID: <CABmPvSG3ML=GDHbM-k1g9-K3rxAYewNwfPrYA96aZE+MQ-KVVg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: btusb: Indicate Microsoft vendor
 extension for Intel 9460/9560 and 9160/9260
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 2:01 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Miao-chen,
>
> > This adds a bit mask of driver_info for Microsoft vendor extension and
> > indicates the support for Intel 9460/9560 and 9160/9260. See
> > https://docs.microsoft.com/en-us/windows-hardware/drivers/bluetooth/
> > microsoft-defined-bluetooth-hci-commands-and-events for more information
> > about the extension. This was verified with Intel ThunderPeak BT controller
> > where msft_vnd_ext_opcode is 0xFC1E.
> >
> > Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Create net/bluetooth/msft.c with struct msft_vnd_ext defined internally
> > and change the hdev->msft_ext field to void*.
> > - Define and expose msft_vnd_ext_set_opcode() for btusb use.
> > - Init hdev->msft_ext in hci_alloc_dev() and deinit it in hci_free_dev().
>
> so I spent some cycles on thinking about on how we can have this nice and cleanly without putting too much into the core stack or hci_dev. I took your patches and converted them a little bit into how I would do it. Please have a look.
Thanks for brainstorming the framework. I will address your suggestion
in v4 shortly.

Regards,
Miao
