Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C2BA981A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 03:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfIEBr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 21:47:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45890 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIEBr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 21:47:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id g16so493409otp.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 18:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mF+PyrayTBs+6EUlPi/FAPHJkbrkGOC+w4HZRZC21uU=;
        b=M7JS3jemmcLHmPAmZdRLNxGVYKx189Xz9ebu92+yMQkAxd//lI5cNhBH0TqbIc7BNQ
         3gjtXAoJkxCvVNRJvLK9aYYif0Eq716kvLoCpa+osdu4qYHI+HZrO6uJy+q2PXNY4cD5
         T+sSVnSAIB/9QQQN0wB9e+jpnAg13NkQZVDXK9SM3UI1XFsFyW4aj2fQfmPp7wXZEjUo
         sFRlqrFOVfuCqVP6xgP1NYmB6ZDz5iL16dIzVGTycywbsihFstFdSU3z+hRCQIP1D3os
         QdVqmy0f5ojxsi3On6b5n10lJiirCTEa0zJ3tv0RESaEjA1fISNlIOgeB3ySyuEfYTrY
         1WFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mF+PyrayTBs+6EUlPi/FAPHJkbrkGOC+w4HZRZC21uU=;
        b=HU5uPCq/vEYhH27TIp8/1xH0+mv5+poOPsD7hfG+qJvexVsXprDc0DxVws13WBAJAM
         H+hL40kT8wc/bix60zXnRPUXcNqqVugHPo7bjTkKWYkUftTwPSKEuCwpdoLwdMkHBdHO
         K2fHoQpr5/rdQKFpewGg8yrkDmmVyLqQzl527aTzWtsXvAEPc4x+yyuEx/PRfrRaH7Tb
         aLn6/5ThqioRhQJhXRPkSXjyZb9dq79Plbvw2KI8poKv9099jt+kpypQS+euCPLGhNRw
         RFge2HgrHfILCxFVAW1QR93+VaW4FUigJSUimw4dhwNwNJ3Y7Hxffp6GNY/OWSlh5ZwB
         okhQ==
X-Gm-Message-State: APjAAAWZtECxRtAo3JsQ5feYNrVrZEUwSnB8KdH08Bx+JepIDGILebTH
        byaUtdwWq1UvyJbme3MsjVJhdtRMz+fOH18dow6D3w==
X-Google-Smtp-Source: APXvYqw43p/uYYgAzSOozahZlzXabTMhHozC8Zwyus/oNppIbh7rBcXv72c6Tdb6xRr2QOo+h6G4HCVuoBawOfrM7jc=
X-Received: by 2002:a9d:6304:: with SMTP id q4mr437483otk.269.1567648045565;
 Wed, 04 Sep 2019 18:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567492316.git.baolin.wang@linaro.org> <5723d9006de706582fb46f9e1e3eb8ce168c2126.1567492316.git.baolin.wang@linaro.org>
 <20190904172548.GA10973@kroah.com>
In-Reply-To: <20190904172548.GA10973@kroah.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 5 Sep 2019 09:47:14 +0800
Message-ID: <CAMz4kuJWPgqSyyn_-Qxq6SCY8Vps5SnA9W6_d1w-3TwgTPM+WA@mail.gmail.com>
Subject: Re: [BACKPORT 4.14.y 1/8] drm/i915/fbdev: Actually configure untiled displays
To:     Greg KH <greg@kroah.com>
Cc:     "# 3.4.x" <stable@vger.kernel.org>, chris@chris-wilson.co.uk,
        airlied@linux.ie, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019 at 01:25, Greg KH <greg@kroah.com> wrote:
>
> On Tue, Sep 03, 2019 at 02:55:26PM +0800, Baolin Wang wrote:
> > From: Chris Wilson <chris@chris-wilson.co.uk>
> >
> > If we skipped all the connectors that were not part of a tile, we would
> > leave conn_seq=0 and conn_configured=0, convincing ourselves that we
> > had stagnated in our configuration attempts. Avoid this situation by
> > starting conn_seq=ALL_CONNECTORS, and repeating until we find no more
> > connectors to configure.
> >
> > Fixes: 754a76591b12 ("drm/i915/fbdev: Stop repeating tile configuration on stagnation")
> > Reported-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Link: https://patchwork.freedesktop.org/patch/msgid/20190215123019.32283-1-chris@chris-wilson.co.uk
> > Cc: <stable@vger.kernel.org> # v3.19+
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/gpu/drm/i915/intel_fbdev.c |   12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
>
> What is the git commit id of this patch in Linus's tree?

The commit id is: d9b308b1f8a1acc0c3279f443d4fe0f9f663252e

>
> Can you please add that as the first line of the changelog like is done
> with all other stable patches?  That way I can verify that what you
> posted here is the correct one.
>
> Please fix the up for all of these and resend.

Sure. Thanks.

-- 
Baolin Wang
Best Regards
