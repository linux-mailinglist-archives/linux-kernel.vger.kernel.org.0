Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2ADBE01D0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 12:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbfJVKPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 06:15:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50636 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731778AbfJVKPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:15:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id q13so6496394wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 03:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bs4FuisA7tS9+U8xJf8/W529cyeyrvU2aBJyOthDVWw=;
        b=PN5rfyxjT7AapqUMB+Y7mgH5VSyCVdj5Jn9Slj8OyW8taLbYV2jYyrTmViNLP9cC03
         tVgLKPkNPWkehyPE26++c9DZRVajd6Us3QrOAH2+GJqXd5vVSL7TTct/qBS13QHEw0LS
         Pkp6lpvnqugLw3cBBics6hufuqH/xur5gqhK3ijhqwGTp0pGjDbbzDI4R9mdKyINFLOA
         2DDa0c0U3RGF2UhrLeUICJa9i5o0BEvM+AnH2fCHQw6B7beSrg+peyiwvtLZDirbwZlK
         EPN/oSUG2rTIYSyOpo8xuv8x8DGvmP7bcBK7m8OJXtM40TDw6JckyeJWCMfmhDY1DwIq
         eKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bs4FuisA7tS9+U8xJf8/W529cyeyrvU2aBJyOthDVWw=;
        b=mwjKSaO/0xWn+3HKmuaCH8NMu8Bz30Lspwi4hvd5X0UUUHZqLz3pewz9cbBtuj2SQQ
         CZ22mDHLxAoQc7RIzXHZSB4gLGWv92JM2kbmE/Um9hQjQgU5tl0rAYshC+pi8ylIreXl
         h3MsB02VzUojVuHmrAmjb5pjT78plrgoy5BJSGeW09/G6OkSPF/Opeusi9D3titZ88GQ
         UIxor15vaAQ5f1zBGABfsAmRaezJznTdPQPLqHCk5YZYQmcER/Yhalmfh+puXg2rgNKE
         h8nmMOLkTq054alOSFKbr7s3zceTunBgVzv5FHxRWIB7iDr/oNBljTLOorTNwv1hw8y/
         +mnA==
X-Gm-Message-State: APjAAAVLVY9OS4SpUniHIiXZahXFAeqdny/d+Kj7jWGEeLtXjkGDNzlS
        iAJaoMZ03a3Zh25YBeolUj7tHSPU4KNVOAozOrgMrA==
X-Google-Smtp-Source: APXvYqzASurI4j7z0wMJJau3KlGT38dQAA5aGGhbhkHPR/X3cn+65+QRDlPiVrWQ7I94OJmtZ/ghi2t5pjMzNjCQikA=
X-Received: by 2002:a7b:c925:: with SMTP id h5mr2062160wml.61.1571739318364;
 Tue, 22 Oct 2019 03:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191017093020.28658-1-kasong@redhat.com> <CAKv+Gu8nJ0uDn0G9s5N1ZM=FE4JB5c2Kjs=mKpatTFkwF0WaaQ@mail.gmail.com>
 <20191022074422.GA31700@zn.tnic>
In-Reply-To: <20191022074422.GA31700@zn.tnic>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 22 Oct 2019 12:15:12 +0200
Message-ID: <CAKv+Gu_GxP+83D0cOT=0UgDrxunm2CuKpAfK1SnVkVqV=E0Ozw@mail.gmail.com>
Subject: Re: [PATCH v4] x86, efi: never relocate kernel below lowest
 acceptable address
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kairui Song <kasong@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 at 09:45, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Oct 22, 2019 at 08:13:56AM +0200, Ard Biesheuvel wrote:
> > On Thu, 17 Oct 2019 at 11:30, Kairui Song <kasong@redhat.com> wrote:
> > >
> > > Currently, kernel fails to boot on some HyperV VMs when using EFI.
> > > And it's a potential issue on all platforms.
> > >
> > > It's caused by broken kernel relocation on EFI systems, when below three
> > > conditions are met:
> > >
> > > 1. Kernel image is not loaded to the default address (LOAD_PHYSICAL_ADDR)
> > >    by the loader.
> > > 2. There isn't enough room to contain the kernel, starting from the
> > >    default load address (eg. something else occupied part the region).
> > > 3. In the memmap provided by EFI firmware, there is a memory region
> > >    starts below LOAD_PHYSICAL_ADDR, and suitable for containing the
> > >    kernel.
> > >
> > > EFI stub will perform a kernel relocation when condition 1 is met. But
> > > due to condition 2, EFI stub can't relocate kernel to the preferred
> > > address, so it fallback to ask EFI firmware to alloc lowest usable memory
> > > region, got the low region mentioned in condition 3, and relocated
> > > kernel there.
> > >
> > > It's incorrect to relocate the kernel below LOAD_PHYSICAL_ADDR. This
> > > is the lowest acceptable kernel relocation address.
> > >
> > > The first thing goes wrong is in arch/x86/boot/compressed/head_64.S.
> > > Kernel decompression will force use LOAD_PHYSICAL_ADDR as the output
> > > address if kernel is located below it. Then the relocation before
> > > decompression, which move kernel to the end of the decompression buffer,
> > > will overwrite other memory region, as there is no enough memory there.
> > >
> > > To fix it, just don't let EFI stub relocate the kernel to any address
> > > lower than lowest acceptable address.
> > >
> > > Signed-off-by: Kairui Song <kasong@redhat.com>
> > > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > >
> >
> > Ingo, Boris, could you please comment on this?
>
> Yah, the commit message makes more sense now.
>


Thanks Boris.

Kairui, I will apply the requested changes myself - no need to spin a v5
