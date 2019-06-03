Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45ED433B7E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 00:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFCWjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 18:39:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46917 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfFCWjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:39:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so5778153pls.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=d0pHGkFAzud1LXVO2y8qggIx+lZyQUhfT9A6e9r7pVo=;
        b=FgCBDPY6CRCXcPfk8fTafoSLnOLpuZSDUFRvAWxACU0zQWMF3HJ7nn6TkRRcn0oixU
         Yko0WDBIyDpE/d1snVSEuha+BomUaa+tnm8tbvNOMhhAmF0GCeqqJ32D5nJTkNxwZz+z
         brMiHfKbm88zFuyU7H97WwSZbpI1x1r0yFw7PisVxJm5Z8oIuRu/a3zbsjgotxcktI0e
         cqAHx9nLyf4QC/CpWQafjMf/+xNq7n9G4FScYwN5xpRtE8p7bIyP0I+6lk0xFOkSDaKm
         AG6X3oEgcDW55aCXpS181mxbF1IgPy6WMNlk5KAC7fDrOBSYg0NUOztcKNkac6oP3DcG
         aa+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=d0pHGkFAzud1LXVO2y8qggIx+lZyQUhfT9A6e9r7pVo=;
        b=TwsMcySh+u7bIuF1eRiCaxQ1E/nhbTyxcy9fe+PLsh7jzkfKC4PL8oaXenChuar/VO
         q+XDcEe26T9ujrpZCRgS7nACY3AbsJvHXfnNSVv7Y0l8eW9PXo31mj2SCxb46HGWG8Mq
         8tT4ZhuwMfQCoaUMhmuN8x/pGTAObhA6SmZOM+pjVBVVexGdCBpQ6RY+ZG2WEHzDKH2D
         vh6ZKKuwbTnyBtzLxzOopz6kYSLFQqu3aix28cBUIlRo09w7kCsTN5kQw1Uh2rnNB8l+
         zet6ah3J9edDlqDx+kml0dwHXAS8HCYE28xecnWG8hgKAsihxDVfm+0EATBfotVks0Th
         a/bw==
X-Gm-Message-State: APjAAAXtXv2gUCN2Re3ZQlaVxOL+AgJPDzLZKKSAM8TK0QQ8SUhV/59m
        +5JpZdf9MpavIyxDUgo1a/R4NA==
X-Google-Smtp-Source: APXvYqwudy03I5p10WfbvIimwqVrr2QjqJjMVmggzEI1EiREVUvMw5spyMDtTF/kgJ3WUmnjkQt/rQ==
X-Received: by 2002:a17:902:163:: with SMTP id 90mr33158196plb.212.1559601592730;
        Mon, 03 Jun 2019 15:39:52 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id j97sm15138949pje.5.2019.06.03.15.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 15:39:52 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 10/10] ARM: mach-meson: update with SPDX Licence identifier
In-Reply-To: <20190527133857.30108-11-narmstrong@baylibre.com>
References: <20190527133857.30108-1-narmstrong@baylibre.com> <20190527133857.30108-11-narmstrong@baylibre.com>
Date:   Mon, 03 Jun 2019 15:39:51 -0700
Message-ID: <7h8suii98o.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/mach-meson/meson.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-meson/meson.c b/arch/arm/mach-meson/meson.c
> index c8d99df32f9b..04ae414d88c9 100644
> --- a/arch/arm/mach-meson/meson.c
> +++ b/arch/arm/mach-meson/meson.c
> @@ -1,16 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Copyright (C) 2014 Carlo Caione <carlo@caione.org>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - *
>   */

I dropped this one since it conflicts with one that was already applied
to mainline in the treewide cleanup of SPDX headers.

The rest of the series is queued for v5.3,

Thanks,

Kevin
