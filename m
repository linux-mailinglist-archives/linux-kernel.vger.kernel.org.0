Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89E412EA46
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 20:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgABTUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 14:20:54 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33654 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgABTUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 14:20:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so36487903otp.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 11:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZqKvWnAKAnUHDdWDL055ta9riXjjQ7G3Yhhe5UVKWcg=;
        b=NNew7eZMj8M9yrGKepAUtT/iOSuBKZDGg3MyG0xlazC6GFzaLCvvJUpjsmv5QrgUzL
         VpbgDZxtLBpYaukZJLXv1ouDAkwrvpjUr/Klq5m3hQ1tZ0a53DFxxt04K//M7MQoInsc
         8TUQnMyJgocuFfOsqIcUeNqWVvYYvOU2cZ2lfDX+5Hy7nzEwQEyiuOl5itMZqCVu/ZEd
         S8ANJj2uTu6l4GWW8qiAQV5BfhlkkFeSsLCXwzbUPQAh4oYaOv8aAFmFPgcRO9xTKLqb
         hSRhNEU4kLNBeRCqX3ep6+d1APeBHMBmfkrAyzsyfNPX8bNq1QkAEdUVLS5KEg5gf2AR
         Th1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqKvWnAKAnUHDdWDL055ta9riXjjQ7G3Yhhe5UVKWcg=;
        b=Z6zZRj3sDVifN4RfZtSf5+THxYblts9FQAPzAIkL3Nhrg8TUV32dU/SAQOJwlcpPcJ
         EcFONwlqxyLtjWbDRKYdCJ3NMOVl9aWIOC+MNxFGgNsUBKhSiNDItr252WNAGcKMkWo1
         08xwdPee3aKeOxSZXMzEHDNbwpxdQneA3vLrjKpExsAb7wHVvtAbruhJHmww9RmiJ78W
         h3UwdupSXpXucFxm/t1otDzKwcnrmWPzkQw3t0trPB8jklFT6NqQZ7w7fL0ciGW5ym4+
         gv8JssWR64W1ny8OvbBTU3H0uAVgaBxWuLwgvW014JAHX4DP/urIy33URNM/iTg7ONdc
         d00A==
X-Gm-Message-State: APjAAAUM275NoC4KPjM156gz/bLpI9BkoQNen7hZJogTLjkA16NubcgE
        rkye2IftMc7dB/UGnlQdCj4gEeHBWnjgNHFvCDHYCQ==
X-Google-Smtp-Source: APXvYqxcBl843E3QPguiI+5pjsRPKHVOrzoS+gc+PeW7Nbe0zSzrQwoEWXL/LoP6SkbRnnwmASzUANLGYn0+IQ4r9A4=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr96377392otk.363.1577992852790;
 Thu, 02 Jan 2020 11:20:52 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
 <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
 <20191228151526.GA6971@linux.intel.com> <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
 <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
 <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
 <20191231010256.kymv4shwmx5jcmey@cantor> <20191231155944.GA4790@linux.intel.com>
 <be07a1e4-c290-4185-8c23-d97050279564@www.fastmail.com> <20200102171922.GA20989@linux.intel.com>
In-Reply-To: <20200102171922.GA20989@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 2 Jan 2020 11:20:41 -0800
Message-ID: <CAPcyv4hXwujZ-+8f-5q2UthNOSszeHfNQxxjNVPQjOWeT0KDQg@mail.gmail.com>
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

On Thu, Jan 2, 2020 at 9:21 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Dec 31, 2019 at 11:47:37AM -0800, Christian Bundy wrote:
> > > Christian, were you having any issues with interrupts? You system was going
> > > into this code as well.
> >
> > Unfortunately I'm now unable to test, sorry for the trouble. I replaced my BIOS
> > with UEFI firmware and the problem has disappeared. Please let me know if there
> > is anything else I can do to help.
> >
> > Christian
>
> Takashi wrote yesterday [*]:
>
> "I'm building a test kernel package based on 5.5-rc4 with Jarkko's revert
> patches"

Nice, I also built one of those. Just waiting for access to the system
again to gather results.

>
> [*] https://bugzilla.kernel.org/show_bug.cgi?id=205935
>
> /Jarkko
