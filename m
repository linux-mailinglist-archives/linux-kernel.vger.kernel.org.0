Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7F01652B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 23:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBSWvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 17:51:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40857 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgBSWvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:51:49 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18so2126304ljo.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qF+TpbZHrOUGgQZVKOV7JZekNV17t91t70D78UaeuV8=;
        b=qE0lGCYEV/tXSremxFtO+b+1kn4LhCpKcL0pKd+sbzRFgl9GsEEDGGR2mBR7igtDgm
         8hVsj9f55arrsH3V4lKT7BeGkN2EPQrMlGnp+oqflal0Nx2+apHfIwyohwS/RWfEAZyR
         pYDsC2a0X2pJCRiiAOZPpnhbP8VG/bnBMxeVJOOZFHg3yUo1PKkkKAcOxfi5j5cslOk5
         AU75vS7GFewOBoyz1/NNBPlXp2seG/oVoDbDJDWC2eduZ8U4MD3T4ptt/32u/p3gvk2+
         fPemF52qrudx4/VNDAtZ9jDG8kYF5mlxjy7ySceAV0NUlXxM5WdvpTlDVlkM5yppHAeA
         NT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qF+TpbZHrOUGgQZVKOV7JZekNV17t91t70D78UaeuV8=;
        b=FNpoGng7SIs08qQmej4vN2FCx3OfLOamo+ye3bq/CyIa7dOf8fyNOztikbDmpefB6o
         N1G45aRcSGYXZ3A2v4MeFfkZ9/JmGkHacks25q8jjlzicJnngXfOtWfI/Phw04JmhOcJ
         s4OHGMLKXmuJWLwwvWtkbOaKv3Q9nz0FsbWtUMA5rFt6FU5Hmk1yGtfk155wvkExKF0Q
         Mz7J1sM5S4ZlH4g4yrdMZ7WQHxZaBsVnJhZuW9M6dXsVr2ME1rDH+0RCVPQwG5J0SiW1
         suf47tZzYNj/9MJwsb87uWQI2HrurkCyIGLQ8splehpN28of7vLZB8D4w74rCXpqn8Sg
         BxPQ==
X-Gm-Message-State: APjAAAXtWXXThrg83iTMhTxSRJiUcWae5jyeZG1DehWCfuggcwOfjYKR
        FIzZebi4Z+FFKOb9Ae9q2PuB54m/BFUQKhSiszHlzQ==
X-Google-Smtp-Source: APXvYqxzBylDBrYSY6Fo3SoinIImzJQsM7dJ2yDo7/RG1hZiJWszXYIePRhb84fn6Fc+TKHWfSqdrs8ymxAOohv4gaQ=
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr16119136ljj.206.1582152708042;
 Wed, 19 Feb 2020 14:51:48 -0800 (PST)
MIME-Version: 1.0
References: <20200217153145.13780-1-james.hughes@raspberrypi.com>
In-Reply-To: <20200217153145.13780-1-james.hughes@raspberrypi.com>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 19 Feb 2020 14:51:37 -0800
Message-ID: <CADaigPXfS4o-QQVPsp1axNz+hAATJqA-vzupC0VRWceJNEZNEg@mail.gmail.com>
Subject: Re: [PATCH] GPU: DRM: VC4/V3D Replace wait_for macros in to remove
 use of msleep
To:     James Hughes <james.hughes@raspberrypi.com>
Cc:     David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 7:41 AM James Hughes
<james.hughes@raspberrypi.com> wrote:
>
> The wait_for macro's for Broadcom VC4 and V3D drivers used msleep
> which is inappropriate due to its inaccuracy at low values (minimum
> wait time is about 30ms on the Raspberry Pi).
>
> This patch replaces the macro with the one from the Intel i915 version
> which uses usleep_range to provide more accurate waits.
>
> Signed-off-by: James Hughes <james.hughes@raspberrypi.com>

To apply this, we're going to want to split the patch up between v3d
(with a fixes tag to the introduction of the driver, since it's a
pretty critical fix) and vc4 (where it's used in KMS, and we're pretty
sure we want it but changing timing like this in KMS paths is risky so
we don't want to backport to stable).  And adjust the commit messages
to have consistent prefixes to the rest of the commits to those
drivers.

I've been fighting with the drm maintainer tools today to try to apply
the patch, with no luck.   I'll keep trying, and if I succeed, I'll
push it.
