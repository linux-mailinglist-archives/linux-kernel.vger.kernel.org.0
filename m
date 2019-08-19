Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3AE494B07
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 18:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfHSQ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 12:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHSQ5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:57:23 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD75722CEC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566233842;
        bh=Hy8n0lFRp7zty8ZWy4THs+if4S0VJnY7dlnn2BR9Vz8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z4oz4S9WVcCWFjUcS9mPBKI3fAGqQ0WbNNxkAP3iCz6cASA0MdQClIjXBEnCFPz5c
         5YhZVJz0tz7B8yKj43mwr+mEU9HvqhVEmpzphwTyI02HpXBBH4YApo1jrclaMBBok4
         5n8wi2vIuxWjLKhT8T6ENENrtP7EpRlyj476b48s=
Received: by mail-qk1-f173.google.com with SMTP id d23so2004616qko.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:57:22 -0700 (PDT)
X-Gm-Message-State: APjAAAVrbIRmmuyEsidDDKOkGthxFU7irfGDCnBhirMTAV1L+HkGUN8J
        J3y+iEQBZfadoQniOMsVYTqdfUAXdelv2/PnRQ==
X-Google-Smtp-Source: APXvYqyQ/HAYu6TofUCZQ74sjJGFs/1QvUeohTN3l/vDfdSATCDtm4dUpsdinkMlGSKuytE71MLMZdTYQe6ZITk79b4=
X-Received: by 2002:a37:a010:: with SMTP id j16mr22432191qke.152.1566233842018;
 Mon, 19 Aug 2019 09:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190816093107.30518-1-steven.price@arm.com>
In-Reply-To: <20190816093107.30518-1-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Aug 2019 11:57:10 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+F-QLJp_1hJz5_0GNLjYwDzkAs8Zg9RsaGiS90QGr_dQ@mail.gmail.com>
Message-ID: <CAL_Jsq+F-QLJp_1hJz5_0GNLjYwDzkAs8Zg9RsaGiS90QGr_dQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Enable devfreq to work without regulator
To:     Steven Price <steven.price@arm.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 4:31 AM Steven Price <steven.price@arm.com> wrote:
>
> If there is no regulator defined for the GPU then still control the
> frequency using the supplied clock.
>
> Some boards have clock control but no (direct) control of the regulator.
> For example the HiKey960 uses a mailbox protocol to a MCU to control
> frequencies and doesn't directly control the voltage. This patch allows
> frequency control of the GPU on this system.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied, thanks.

Rob
