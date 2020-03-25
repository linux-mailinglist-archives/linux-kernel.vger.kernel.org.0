Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56AD7193044
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 19:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgCYSWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 14:22:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33419 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgCYSWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 14:22:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id f20so3627200ljm.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPEwoG8h8S1R2qD5G1vi3PmrfSIyBn4GCofQ1P+96TY=;
        b=bjjDI15fX5OfC9EvM95oIn099GLW2riIR04uc/r3bFa2EX0vzKwDcme6+6ijOen6KC
         B3zgVp3+BguQT/ljs+opJ5Gv9LGlZU/SxZm0I+7WhOC6ej/QCIDWAiejy1kuo1ccZFDu
         GlBOpSprrxkWI7PZcOwQ8HzuDAODZzETbE55NEe4bidlV+37+1xTFVURnOQ2AjSpO0h1
         frNOeGOG8s6BOUKwg9yG14Ieo1mix0uibwn/73fHdS6UbAUl6MXY+4InTuyfBquUPol7
         63zIbY9xWn0m8W9faKs+FWXiyZAnFCzoh28IzpGjEZfBxr1rpXFq/Zi0ignVLzNd534b
         7Meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPEwoG8h8S1R2qD5G1vi3PmrfSIyBn4GCofQ1P+96TY=;
        b=XVUqDnU7Na+Dqkk9x7g/DL5mNcl/0NulFLTS/YV9T8y41if1t6RZL22QXphBp9gka5
         lWStqrM68r0N0kYpw4idjNIPxeivyfFwg7ulVXacnPhWa+CI16tKL60shQl7yFAMFRBx
         xBlJyMLvDlsvL4FJZe4b4wqalLfJwSMQfksVSUkhbXshpKB6JpLhUkC9o9ozbFig5zDg
         wTmkHueKq35SWQXqyYGK1I9C3K6kJFx2aGVcmbmgxn1of8bh+w4y/UDi/VOlhQF/Rsb5
         ItOlQ3mF6/plnG0nWxT45d4roo9bPfo7vTTM9RKS4b6elVhWkQ1pLwpJxbQbcDTE5lYd
         G7gg==
X-Gm-Message-State: AGi0PuY32W/gWau3D+0NPXkPx4kCAEbBrgpJYiITs5z3rue8EU2L75H/
        OPKjJvYn6ce4YqoWIo9nEr8e7OcA/25iXZ8i2BduCg==
X-Google-Smtp-Source: APiQypKVZrii6IStHL3Grb+eBBEVmGuZZh7m/j7oep8YfvuA/rqJ7TEpH3/0lY8o35IAi3YXb6+sd4XSNsNC+DByPzM=
X-Received: by 2002:a2e:82d0:: with SMTP id n16mr2812152ljh.174.1585160548238;
 Wed, 25 Mar 2020 11:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200312185629.141280-1-rajatja@google.com>
In-Reply-To: <20200312185629.141280-1-rajatja@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 25 Mar 2020 11:21:50 -0700
Message-ID: <CACK8Z6E==7DFGkT+9+EEvojiLCx5Jg4rq=DPGZGr99TBc5bz9w@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] drm/i915 Support for integrated privacy screen
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mat King <mathewk@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        Sean Paul <seanpaul@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Nitin Joshi1 <njoshi1@lenovo.com>,
        Sugumaran Lacshiminarayanan <slacshiminar@lenovo.com>,
        Tomoki Maruichi <maruichit@lenovo.com>
Cc:     Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

On Thu, Mar 12, 2020 at 11:56 AM Rajat Jain <rajatja@google.com> wrote:
>
> This patchset adds support for integrated privacy screen on some laptops
> using the ACPI methods to detect and control the feature.
>
> Rajat Jain (5):
>   intel_acpi: Rename drm_dev local variable to dev
>   drm/connector: Add support for privacy-screen property
>   drm/i915: Lookup and attach ACPI device node for connectors
>   drm/i915: Add helper code for ACPI privacy screen
>   drm/i915: Enable support for integrated privacy screen

Just checking to see if you got a chance to look at this latest
patchset. This takes care of all your review comments.

Thanks & Best Regards,

Rajat

>
>  drivers/gpu/drm/drm_atomic_uapi.c             |   4 +
>  drivers/gpu/drm/drm_connector.c               |  51 +++++
>  drivers/gpu/drm/i915/Makefile                 |   3 +-
>  drivers/gpu/drm/i915/display/intel_acpi.c     |  30 ++-
>  drivers/gpu/drm/i915/display/intel_atomic.c   |   2 +
>  drivers/gpu/drm/i915/display/intel_ddi.c      |   1 +
>  .../drm/i915/display/intel_display_types.h    |   5 +
>  drivers/gpu/drm/i915/display/intel_dp.c       |  48 ++++-
>  drivers/gpu/drm/i915/display/intel_dp.h       |   5 +
>  .../drm/i915/display/intel_privacy_screen.c   | 184 ++++++++++++++++++
>  .../drm/i915/display/intel_privacy_screen.h   |  27 +++
>  drivers/gpu/drm/i915/i915_drv.h               |   2 +
>  include/drm/drm_connector.h                   |  24 +++
>  13 files changed, 382 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.c
>  create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.h
>
> --
> 2.25.1.481.gfbce0eb801-goog
>
