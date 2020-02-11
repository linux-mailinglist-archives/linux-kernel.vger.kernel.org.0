Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDAD1159A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 21:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbgBKUjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 15:39:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38557 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgBKUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:39:39 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so11543563oth.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 12:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FkiL+nwntyVL1Depk52x54ARrFLNbJ/q2cGreWUpoIY=;
        b=guvCAd2UOUpE5ajI+DyZuXuN5tRzCg1lxnzXs01Bvu2MlthWaB0XogL0T0x015uMCv
         0Nvd5+Ig7erzbpig7CWn1Kiws8zHYl44P3bOkicvZaw2f51Qe4Ml6z6VRCQrCpJq24EY
         DR4ynLgVuwECElLR2xmeFY2msAViOtRDcH1POsBv6CnnIHmPgLjAvG1MkNVIFWcMD8Te
         UQDPiEB+WG1wY2ilnvK8g2oK/a8t9J2lFGd1pqTUbTOmoXak/wg6m63A9+dH4OIwsiJJ
         RpARQc1c+3yEtHkG8gD7JGSh/lnpYuRTLockpE32Egd1RdTirJy3ErA0i2yfaNgW3aBD
         rM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FkiL+nwntyVL1Depk52x54ARrFLNbJ/q2cGreWUpoIY=;
        b=ED4SPRZiUUnv1eZuDwkYdeLbTPSgKnMetlThqGPosfgE6gfklkV9t81J0fHUGRay3a
         0SAXMb4BzsTrq74J1kpSqC+EogFQyree5QZC0L54EHI/Gzy8sfK5HAlWqNWKPJfoIHn8
         t5m79e4EYO+u0v8kX/WICSo0OLA8tXHXsrHTbXxU1TxnrNAJ/00+z7geFlbJOVI7r3Do
         OjVxqhfdDqdFLvOSbtYeH558VmOYQMyrtOurFBYAMJSevJOhaGXNbH4di7Ix0ZDY24B4
         Zu2FNxodbaOiG4U59uxMvVkJOBZWbA/YznCYftN1RAXffKYszZE5WKmOnpA/No8zRIDG
         KPkg==
X-Gm-Message-State: APjAAAX7JdW7tYY5CRFHBGSNKfjdooMVb1p+u6CHSH9aNCGQhjKYX9zN
        Y4qoFyL34DWSddPV0nNEqZgIHTAWvC4=
X-Google-Smtp-Source: APXvYqyRcLhd1pYN0o8cVbwvTHy9UM43N0APlTdoi5+8CTIzfL2EpJ/miK1zSlKVRAdQyxB4Sxva+g==
X-Received: by 2002:a9d:64ca:: with SMTP id n10mr6692357otl.325.1581453577909;
        Tue, 11 Feb 2020 12:39:37 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id w8sm1537795ote.80.2020.02.11.12.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 12:39:37 -0800 (PST)
Date:   Tue, 11 Feb 2020 13:39:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        clang-built-linux@googlegroups.com,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/i915: Disable
 -Wtautological-constant-out-of-range-compare
Message-ID: <20200211203935.GA16176@ubuntu-m2-xlarge-x86>
References: <20200211050808.29463-1-natechancellor@gmail.com>
 <20200211061338.23666-1-natechancellor@gmail.com>
 <4c806435-f32d-1559-9563-ffe3fa69f0d1@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c806435-f32d-1559-9563-ffe3fa69f0d1@daenzer.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 10:41:48AM +0100, Michel Dänzer wrote:
> On 2020-02-11 7:13 a.m., Nathan Chancellor wrote:
> > A recent commit in clang added -Wtautological-compare to -Wall, which is
> > enabled for i915 so we see the following warning:
> > 
> > ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1485:22: warning:
> > result of comparison of constant 576460752303423487 with expression of
> > type 'unsigned int' is always false
> > [-Wtautological-constant-out-of-range-compare]
> >         if (unlikely(remain > N_RELOC(ULONG_MAX)))
> >             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> > 
> > This warning only happens on x86_64 but that check is relevant for
> > 32-bit x86 so we cannot remove it.
> 
> That's suprising. AFAICT N_RELOC(ULONG_MAX) works out to the same value
> in both cases, and remain is a 32-bit value in both cases. How can it be
> larger than N_RELOC(ULONG_MAX) on 32-bit (but not on 64-bit)?
> 

Hi Michel,

Can't this condition be true when UINT_MAX == ULONG_MAX? clang does not
warn on a 32-bit x86 build from what I remember. Honestly, my
understanding of overflow is pretty shoddy, this is mostly based on what
I have heard from others.

I sent a patch trying to remove that check but had it rejected:

https://lore.kernel.org/lkml/20191123195321.41305-1-natechancellor@gmail.com/

Cheers,
Nathan
