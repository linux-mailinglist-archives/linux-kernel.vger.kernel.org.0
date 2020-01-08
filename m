Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 064771341DB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 13:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgAHMiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 07:38:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42484 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAHMiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:38:12 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so2406720edv.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 04:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RotMCjOJKktSIUBCGAb4BBJvwMzxDTEukuKk1C8nR/Y=;
        b=DVTb0EFtmqEPjuV03pnzZK8BsOoSGErBVKLIgk8UCu08OyrkYyp+HrCskvsX5sy5Ff
         7dgC90WFdqalh7qU8HwYisvMIeBkmy+stiyz7LUL0LjF2/5fICa+Z4jUYnRAwAV4kksQ
         7dZZUA2bit+LnZ4BIwweatxdmsnogHTuTJ2y1kqqYR2/oD1hUVcpiVL6nExK6EfOAQIE
         bqcVrcApy0/mju2Mt+SP/RFG4is3ocgdJpHtYhpE74dGn55SZ2FCKUSQmnx5qLeY5PyP
         qt9S8KPXnqjmbCkZ7ZHnvoc+ZArLCNgibMc4uWYw8FFqFFLTlLcbfckZ9XhF/1HEvSog
         eEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RotMCjOJKktSIUBCGAb4BBJvwMzxDTEukuKk1C8nR/Y=;
        b=goHJ1U266geJz1HLsmNgycW9uoVu747vObVWYWhorszv/GyYn1tobUkwm1lilT828h
         UxdPqeBHc9mw/wV1BRcHblvr4lBhfRAhI7LGNUWs1+fAcpjVIEAtVGxzRV4BCjVs23Yz
         ruYP5wMxxTZtl8FxU6NNF9tRexT0XplgCsyeK5Sz6AU8S5OxCfnsRmbQdOGlvDiytdYe
         RF0uTdsC6ym/EhDdBla1oBClalbOzIDr0Ibp+TDj5sEqNd5/R/QSfP/Qo9Xei6iFDsHb
         YgxExJJedpm6/oUUm/9kR6qWQrIvfzGKVJWRmlwnm5MY/PbvsrXqfsCqTcFqSw3SmGlt
         h6JQ==
X-Gm-Message-State: APjAAAVdILi+ROnq58W+lsYuNH1PtlobHESDH2J+1oJRZifGY9EA6yVH
        3ws0++ORudo1Hlk3c3J3vaFtd9SJWGTTlgaVQyFqLw==
X-Google-Smtp-Source: APXvYqzi0WPsidDDmVj1R0p4gUv6jfBMcq5h5l5TD4QO3F5rD/GE1j0AN/0+zT53es3eTRwo2dDerj4WmIdMbbc4SpY=
X-Received: by 2002:a17:906:1a50:: with SMTP id j16mr4721042ejf.106.1578487090894;
 Wed, 08 Jan 2020 04:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20200107230626.885451-1-martin.blumenstingl@googlemail.com>
 <20200107230626.885451-2-martin.blumenstingl@googlemail.com> <a85f2063-f412-9762-58d1-47fdffb24af9@arm.com>
In-Reply-To: <a85f2063-f412-9762-58d1-47fdffb24af9@arm.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 8 Jan 2020 13:38:00 +0100
Message-ID: <CAFBinCBYrNC+ULV6Y=77qogowkDZwM+H0bxOqPN4sT6q3krGfw@mail.gmail.com>
Subject: Re: [PATCH RFT v1 1/3] drm/panfrost: enable devfreq based the
 "operating-points-v2" property
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     dri-devel@lists.freedesktop.org, alyssa@rosenzweig.io,
        steven.price@arm.com, tomeu.vizoso@collabora.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Jan 8, 2020 at 12:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 07/01/2020 11:06 pm, Martin Blumenstingl wrote:
> > Decouple the check to see whether we want to enable devfreq for the GPU
> > from dev_pm_opp_set_regulators(). This is preparation work for adding
> > back support for regulator control (which means we need to call
> > dev_pm_opp_set_regulators() before dev_pm_opp_of_add_table(), which
> > means having a check for "is devfreq enabled" that is not tied to
> > dev_pm_opp_of_add_table() makes things easier).
>
> Hmm, what about cases like the SCMI DVFS protocol where the OPPs are
> dynamically discovered rather than statically defined in DT?
where can I find such an example (Amlogic SoCs use SCPI instead of
SCMI, so I don't think that I have any board with SCMI support) or
some documentation?
(I could only find SCPI clock and CPU DVFS implementations, but no
generic "OPPs for any device" implementation)


Martin
