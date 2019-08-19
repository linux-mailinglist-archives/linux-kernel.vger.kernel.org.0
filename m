Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D50A94B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 18:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfHSQ5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 12:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHSQ5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:57:41 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E9822CE9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566233860;
        bh=l4QVQkxBDVy3v7/roCr2nUc/HtWfXFXDYL4lHli64Mc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B82UDk9Nq20WIdfzLZ7RcJ9c7uCGngxVmppGprB8ZUWdD6dzDJRmQCpRPdJa3Kpsq
         ZqhW5u4bzzbu7TbM9iQEdTizEYb3/vxr7ohRLv3cy2K5fhPI6DUTqk+GfHUXJYBXts
         zy/N8YNj2GCtAyeSYV5JWLDTePyUfqsBMsmf3Y7k=
Received: by mail-qt1-f172.google.com with SMTP id j15so2629127qtl.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:57:40 -0700 (PDT)
X-Gm-Message-State: APjAAAVifHwKdSfNo/k1dR1dhi+LwqSHv33MUOmYPbT4egHxSUaerzyj
        VVWCRbMaMkpv3IFWOvyx3kHZaR53+3NbNHajOg==
X-Google-Smtp-Source: APXvYqwhMCdqCBoZ+XmoP5Pq16HzVdXGPk1IUhU4swPt9wGX4UfkdCEv2p/5mPE5rto+CIOhnelr6+OIE0FWo+844Yo=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr21758524qtc.143.1566233859680;
 Mon, 19 Aug 2019 09:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190816093107.30518-3-steven.price@arm.com>
In-Reply-To: <20190816093107.30518-3-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Aug 2019 11:57:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL4xc6AnjC2j62X3DPrPOVMvQ2q__9h_BqQoSs45ADMRg@mail.gmail.com>
Message-ID: <CAL_JsqL4xc6AnjC2j62X3DPrPOVMvQ2q__9h_BqQoSs45ADMRg@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Remove opp table when unloading
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
> The devfreq opp table needs to be removed when unloading the driver to
> free the memory associated with it.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 6 ++++++
>  drivers/gpu/drm/panfrost/panfrost_devfreq.h | 1 +
>  drivers/gpu/drm/panfrost/panfrost_drv.c     | 5 ++++-
>  3 files changed, 11 insertions(+), 1 deletion(-)

Applied, thanks.

Rob
