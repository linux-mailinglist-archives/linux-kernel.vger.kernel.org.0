Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138876D366
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 20:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390984AbfGRSAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 14:00:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43279 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390368AbfGRSAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:00:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so12970863pfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=1vjr89rXvmdf0wB/WdMQsMyhKQE9yJLVmO3GYLtPVv8=;
        b=k/fa1LPxqJnclVt5GEioxr9RW7EbyJfYV5piMXPIZSTxtcvwm46SxOoXf6cZQjrbY6
         bca4y1KZQKYwRAbFL7TF/0F3GjkjQ40o8BsRAOQWVUU2JLRYfaXohx1zuUR6O0+L0yQF
         jjMXcPRZYvsl4H0NfBYJirfflhQ5+wTsGrZMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=1vjr89rXvmdf0wB/WdMQsMyhKQE9yJLVmO3GYLtPVv8=;
        b=V0kc8ZLUHoKdb15Yc36xYEJDG/ZNcVIp8RrndIvKJja51/J+wJKQkfALy6rqG1Glm0
         Fm984GxTafMsM+fJtK87e8Jv82lTGAW6/xVn31kVQPk5Ac2mohCiyBNma5fyTtTwESMm
         dBDjIWduQ1R3+n61a2S/IxCh1ICh59VudMbnH8Q0zUXI6MUEAvEv71lxlMW4CRHCSx37
         oHWOxhBWOo/skOxW+iktmJ2Go4F+CGT8P8Q5q0inYz21t/SgEcONCx2rMGyYwMErwCPy
         dZ19ppiaHmJIvty+mbD9nSQcy/hTgMU5Ey9HaLJUOVLEABSbLecw1PT3CvvPRC23FHSW
         gYaA==
X-Gm-Message-State: APjAAAWxlpQTYjbhhptQ/WgDq3m85ExyVsC/lXlMGBUNLU54XVj7gfQ/
        9MwgX7jd4BX/pY/OEzdjmE0aSw==
X-Google-Smtp-Source: APXvYqxv3xo0LgfN2UblAdH0u++DeJ6HbfKAf0knXIKRJ+c6voucqKn+e+cPziHQVF1JO9OzN+TkJA==
X-Received: by 2002:a63:eb51:: with SMTP id b17mr47673373pgk.384.1563472809305;
        Thu, 18 Jul 2019 11:00:09 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d2sm25585057pjs.21.2019.07.18.11.00.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 11:00:08 -0700 (PDT)
Message-ID: <5d30b3a8.1c69fb81.8c54.63a6@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190710141433.7ama3gncss3y6dcx@willie-the-truck>
References: <20190614203717.75479-1-swboyd@chromium.org> <20190614203717.75479-4-swboyd@chromium.org> <20190710141433.7ama3gncss3y6dcx@willie-the-truck>
Subject: Re: [PATCH v2 3/5] memremap: Add support for read-only memory mappings
To:     Will Deacon <will@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 18 Jul 2019 11:00:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Will Deacon (2019-07-10 07:14:34)
> On Fri, Jun 14, 2019 at 01:37:15PM -0700, Stephen Boyd wrote:
> > @@ -84,7 +91,10 @@ void *memremap(resource_size_t offset, size_t size, =
unsigned long flags)
> >       }
> > =20
> >       /* Try all mapping types requested until one returns non-NULL */
> > -     if (flags & MEMREMAP_WB) {
> > +     if ((flags & MEMREMAP_RO) && is_ram !=3D REGION_INTERSECTS)
> > +             addr =3D arch_memremap_ro(offset, size);
> > +
> > +     if (!addr && (flags & MEMREMAP_WB)) {
> >               /*
> >                * MEMREMAP_WB is special in that it can be satisfied
> >                * from the direct map.  Some archs depend on the
> > @@ -103,7 +113,8 @@ void *memremap(resource_size_t offset, size_t size,=
 unsigned long flags)
> >        * address mapping.  Enforce that this mapping is not aliasing
> >        * System RAM.
> >        */
> > -     if (!addr && is_ram =3D=3D REGION_INTERSECTS && flags !=3D MEMREM=
AP_WB) {
> > +     if (!addr && is_ram =3D=3D REGION_INTERSECTS &&
> > +         (flags !=3D MEMREMAP_WB || flags !=3D MEMREMAP_RO)) {
> >               WARN_ONCE(1, "memremap attempted on ram %pa size: %#lx\n",
> >                               &offset, (unsigned long) size);
> >               return NULL;
>=20
> This function seems a little confused about whether 'flags' is really a
> bitmap of flags, or whether it is equal to exactly one entry in the enum.
> Given that I think it's sensible for somebody to specify 'MEMREMAP_RO |
> MEMREMAP_WT', then we probably need to start checking these things a bit
> more thoroughly so we can reject unsupported combinations at the very lea=
st.
>=20

I'm also confused about the same thing. I thought it was a "getting
worse via best effort" type of thing based on the comment above the
function.

 * In the case of multiple flags, the different
 * mapping types will be attempted in the order listed below until one of
 * them succeeds.

(I now realize I should have documented the new flag so that this order
would be known. I'll resend this series again with the documentation
fix.)

I also thought that the combination of read-only and write through would
be OK because the flags are more of a best effort approach to making a
mapping. Given that, is there anything to reject? Or do we just keep
trying until we can't try anymore?

