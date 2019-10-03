Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76FA1CAFBE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 22:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388044AbfJCUGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 16:06:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46486 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732388AbfJCUGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:06:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id d1so4112257ljl.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEA75etlk7NiXbXyR0ghlUacDozX8MA9940JKyvobjU=;
        b=V/h4B6JCZ6ilgfNMZTduLlvS9k5p+x4R6V1TQS2L17knzQhesftgg0+U01Ux905oTZ
         6lBX/rMiBIE3aYhm+u5EaMQsEE5Jd1Sg2TD8a+2T3r/y5YGBu20HJCkzr4N3woGGGEIl
         C4/4tIoHtKlIy+8Mr5HsOSaPMUpT2zTpCGNRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEA75etlk7NiXbXyR0ghlUacDozX8MA9940JKyvobjU=;
        b=swrXV19Uw7Re0+0jOr0p8xbSyCG3E5pSXRDTPf+01nceecUNZtpxLV6LNm0QdGFpad
         b0KdUlZh/P+i1Ds+FW6Rfbgh9YeS5RPNNL6busS2LkNQqxFo4uW6A9/ioCWAT0u3KG61
         x9kOYqOam48wj2cGHYKhqKJB0B05fVb4x7z4Lh3GG6WEMi8frZf2SL66QfXFED1/bkLS
         RNf1pzfjfoaeQiTSqVnenJ8YnFTgsNxFC18CIokP02QOJowznnbaZIR9AkpVv3ADSkRh
         cqt7XvWyz9SPQtjGDWAVmFNlsCGC9SKe9VWJ4ttv+Iaf/H9MmPG7L8Iga/Rez+6200E9
         cq9g==
X-Gm-Message-State: APjAAAULR8eWMYbyzkv9fC4R4QUumzWGDg/T1dKq7tE1QbZ15oAiQYDh
        jZO+LCpx1AQRYWMnrle78DIu0+nZsN8=
X-Google-Smtp-Source: APXvYqycNH1AxGsn4bu3Zbmkap4IgONGOy9+8jCFPurd44hWwK5cjFhjx2AcNVmnaYuKwODTHQD9qA==
X-Received: by 2002:a2e:7a04:: with SMTP id v4mr7251980ljc.237.1570133192092;
        Thu, 03 Oct 2019 13:06:32 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t6sm743601ljd.102.2019.10.03.13.06.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 13:06:30 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id y127so2821282lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:06:30 -0700 (PDT)
X-Received: by 2002:a19:711e:: with SMTP id m30mr6833427lfc.63.1570133189870;
 Thu, 03 Oct 2019 13:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190910160903.65694-1-swboyd@chromium.org> <20190910160903.65694-4-swboyd@chromium.org>
 <CAE=gft6YdNszcJV67CwcY2gOgPHrJ1+SnKMLr63f2bix2aZXXA@mail.gmail.com> <5d964444.1c69fb81.121ce.d43b@mx.google.com>
In-Reply-To: <5d964444.1c69fb81.121ce.d43b@mx.google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 3 Oct 2019 13:05:53 -0700
X-Gmail-Original-Message-ID: <CAE=gft47g-mR0o5C=LG6b-OcVT=JDeNCfBH6R+CgPhLMnZpC=A@mail.gmail.com>
Message-ID: <CAE=gft47g-mR0o5C=LG6b-OcVT=JDeNCfBH6R+CgPhLMnZpC=A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] memremap: Add support for read-only memory mappings
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 11:56 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Evan Green (2019-09-18 12:37:34)
> > On Tue, Sep 10, 2019 at 9:09 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > @@ -53,6 +60,9 @@ static void *try_ram_remap(resource_size_t offset, size_t size,
> > >   * mapping types will be attempted in the order listed below until one of
> > >   * them succeeds.
> > >   *
> > > + * MEMREMAP_RO - establish a mapping whereby writes are ignored/rejected.
> > > + * Attempts to map System RAM with this mapping type will fail.
> >
> > Why should attempts to map RAM with this flag fail? MEMREMAP_WB will
> > allow RAM and quietly give you back the direct mapping, so it seems
> > like at least some values in this function allow RAM.
> >
> > Oh, I see a comment below about "Enforce that this mapping is not
> > aliasing System RAM". I guess this is worried about cache coloring?
> > But is that a problem with RO mappings? I guess the RO mappings could
> > get partially stale, so if the memory were being updated out from
> > under you, you might see some updates but not others. Was that the
> > rationale?
>
> Will Deacon, Dan Williams, and I talked about this RO flag at LPC and I
> believe we decided to mostly get rid of the flags argument to this
> function. The vast majority of callers pass MEMREMAP_WB, so I'll just
> make that be the implementation default and support the flags for
> encrpytion (MEMREMAP_ENC and MEMREMAP_DEC). There are a few callers that
> pass MEMREMAP_WC or MEMREMAP_WT (and one that passes all of them), but I
> believe those can be changed to MEMREMAP_WB and not care. There's also
> the efi framebuffer code that matches the memory attributes in the EFI
> memory map. I'm not sure what to do with that one to be quite honest.
> Maybe EFI shouldn't care and just use whatever is already there in the
> mapping?

I would guess that the folks mapping things like framebuffers would
care if their write-combined memory were changed to writeback. But I
suppose the better authorities on that are already here, so if they
think it's fine, I guess it's all good.

Whatever logic is used to defend that would likely apply equally well
to the EFI mappings.

>
> Either way, I'll introduce a memremap_ro() API that maps memory as read
> only if possible and return a const void pointer as well. I'm debating
> making that API fallback to memremap() if RO isn't supported for some
> reason or can't work because we're remapping system memory but that
> seems a little too nice when the caller could just as well decide to
> fail if memory can't be mapped as read only.

Sounds good. My small vote would be for the nicer fallback to
memremap(). I can't think of a case where someone would rather not
have their memory mapped at all than have it mapped writeable.
-Evan
