Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A4312F3F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 06:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgACFFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 00:05:10 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:42104 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgACFFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 00:05:09 -0500
Received: by mail-oi1-f170.google.com with SMTP id 18so13258014oin.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 21:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9z+Xzh18caeqiaZuMDsgdyqgwWP0TZb4axKxH7OLyGI=;
        b=A1/1WUmuXTjd1yXdCfALo+wxGXEPLsLX+BAYn8/BNRFmxZvl8Z33gbvQXfPkFFqtCB
         F6j56ow0/9o5S0g8poVP3xTsTp14m4SUci5oo37DTXnA3Ob4OGO590q6CVsa4MAqotMY
         UGjGYNMn4JNVSaTaNx+ftQqgJKCvfpHGbQa9QWs+UFcGNoODigf8g725Nww9cEGFSRzR
         UQGmgBySDa6SYXeU9NK3ZfLtwfqSkpq82YyClO6nwW0TqWcO7wvEDrgpL0CywqwcQeLo
         y1yxT7t6U8h3LrbaoNk0fBqzvJ5SFbID/WO9Hk9IRWZYLgvYbw4LJ2pNOP0h26qgPwIj
         owyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9z+Xzh18caeqiaZuMDsgdyqgwWP0TZb4axKxH7OLyGI=;
        b=A7IvXE+HPYg+iioHel2CNnErOCZvXND3nAQkEqhdu4FM7D4LftSWSzHmAKnG8ErjUF
         CkW/iowaHJk77r4WmVlOFYg4rTw0c1oNHsPTDSOX4PltPgQC7CjsFEk3ByvN1uTaAUDH
         pbP88tFDtIl7nCYsXZOa2/uguB3B9TOTSpFH5+FknGS8xKoSxvHZ9lyVsYgcSH1JNP62
         l8JxNHU7zkFObp0B/MyWF6Nq2dnL5zQCrGYgyftwFX/ziWXvTwOdrNYY4Y++4I3rm5p3
         KkUUwyQUXdcP7yBpmwPM5BtVHCNc0ZZz/gowQWEX+hZKYrcO8pTmumuRyXHYb1MEMTjJ
         y7HA==
X-Gm-Message-State: APjAAAUExp4HysOKwpA+f3jXLuyewnkaIVCAOwYS+w3RRS8fWGXRWB+W
        TuMrEeSNC2NOPKcbBENaBIaFrPDInfEY04xdt9725w==
X-Google-Smtp-Source: APXvYqzNOBkuvb5Fm5vxCtZHUw/FW+/U6qZiPfzK9FMkum2L7VYmYLpZXlRDt2PKWLQIY3UYuhZboTNxMXP8ohFlBCc=
X-Received: by 2002:aca:4c9:: with SMTP id 192mr3954800oie.105.1578027908725;
 Thu, 02 Jan 2020 21:05:08 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
 <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
 <20191228151526.GA6971@linux.intel.com> <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
 <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
 <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
 <20191231010256.kymv4shwmx5jcmey@cantor> <20191231155944.GA4790@linux.intel.com>
 <be07a1e4-c290-4185-8c23-d97050279564@www.fastmail.com> <20200102171922.GA20989@linux.intel.com>
 <CAPcyv4hXwujZ-+8f-5q2UthNOSszeHfNQxxjNVPQjOWeT0KDQg@mail.gmail.com>
In-Reply-To: <CAPcyv4hXwujZ-+8f-5q2UthNOSszeHfNQxxjNVPQjOWeT0KDQg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 2 Jan 2020 21:04:57 -0800
Message-ID: <CAPcyv4gPEu+D+hRqG4HOU24+6xGpZsOb4Po8V+asvvFU-hk6ng@mail.gmail.com>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Christian Bundy <christianbundy@fraction.io>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 2, 2020 at 11:20 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Jan 2, 2020 at 9:21 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Tue, Dec 31, 2019 at 11:47:37AM -0800, Christian Bundy wrote:
> > > > Christian, were you having any issues with interrupts? You system was going
> > > > into this code as well.
> > >
> > > Unfortunately I'm now unable to test, sorry for the trouble. I replaced my BIOS
> > > with UEFI firmware and the problem has disappeared. Please let me know if there
> > > is anything else I can do to help.
> > >
> > > Christian
> >
> > Takashi wrote yesterday [*]:
> >
> > "I'm building a test kernel package based on 5.5-rc4 with Jarkko's revert
> > patches"
>
> Nice, I also built one of those. Just waiting for access to the system
> again to gather results.

Ok, it looks good.

Tested-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Xiaoping Zhou <xiaoping.zhou@intel.com>

It does report:

[    2.546660] tpm_tis IFX0740:00: 2.0 TPM (device-id 0x1B, rev-id 16)
[    2.546823] tpm tpm0: tpm_try_transmit: send(): error -5
[    2.546824] tpm tpm0: [Firmware Bug]: TPM interrupt not working,
polling instead

...at boot, but tpm2_nvlist works ok.
