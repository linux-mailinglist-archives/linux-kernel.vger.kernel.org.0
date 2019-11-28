Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6DD310C216
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 03:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfK1CB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 21:01:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbfK1CB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 21:01:57 -0500
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84BAB215E5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 02:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574906516;
        bh=NYRqSSSflb/7R2PJYKZYTmTZFfY5niNm/0KywUUvxio=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d3/F8gLLnZ4/ZaTDrULqhfAEOTrK5hqoj33SGcB2N+2GtEUIvYIk6ocWtm87pfr9E
         fUhRI1eKjGKcugyl//SD6UsJK2es6aB/IA0F3t4aovNbxWgN3HwLOLVg24lfD+oKsf
         y8gaKQpLRcHJsItyhqnQyg5roURrSg5Rcz0O6mDY=
Received: by mail-lf1-f48.google.com with SMTP id r14so2470394lfm.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 18:01:56 -0800 (PST)
X-Gm-Message-State: APjAAAXlTm55gINp3e3Uq7EKxU2dgHsV4sI3P6DSR8EuzC02qggz9C0r
        4OS251dFxGzHsCAmqDf7fxutNcK24gCxtsKo4+s=
X-Google-Smtp-Source: APXvYqwf0FBRz8oMYpv9971Qt4D0VHSAYNJ0z+XlnxTZwRI2xCRXhL3jA4u6airlbfQp9bZ+tt2Vn7X/XcURdrJGA2M=
X-Received: by 2002:ac2:4469:: with SMTP id y9mr31061502lfl.33.1574906514716;
 Wed, 27 Nov 2019 18:01:54 -0800 (PST)
MIME-Version: 1.0
References: <20191121132919.29430-1-krzk@kernel.org> <87k17lo41g.fsf@intel.com>
In-Reply-To: <87k17lo41g.fsf@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 28 Nov 2019 10:01:43 +0800
X-Gmail-Original-Message-ID: <CAJKOXPdCXFgZyF8tgLmOOoVgtC++RQGSSN8LT4twEXKz=+589Q@mail.gmail.com>
Message-ID: <CAJKOXPdCXFgZyF8tgLmOOoVgtC++RQGSSN8LT4twEXKz=+589Q@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: Fix Kconfig indentation
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2019 at 21:14, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Thu, 21 Nov 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Adjust indentation from spaces to tab (+optional two spaces) as in
> > coding style with command like:
> >       $ sed -e 's/^        /\t/' -i */Kconfig
>
> Btw have you updated checkpatch.pl to try to keep the Kconfigs from
> bitrotting back to having different indentation? Or the config tools?

Perl is not my domain but I can try. Let's see...

Best regards,
Krzysztof
