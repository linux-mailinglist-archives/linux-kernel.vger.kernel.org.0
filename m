Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 875A294B01
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 18:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfHSQ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 12:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfHSQ5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:57:07 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CE9C22CED;
        Mon, 19 Aug 2019 16:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566233826;
        bh=J9Qn/aVNhFBb93Jqnzfg6I63rHYdO74sYQm4uyr9my0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aQsWow5e9kjAe5ypPL1Rm+4zrlD7JRZi9a2g8a2c3/W81hO6g0OYrWr0i1RhdsQ2t
         QFlzS8V5cXL8XRC4P3byVp31RfrFy9Xyvypk/14/hPyanl94SayeU3PjN8I4FNbv1T
         uFPK6bh29Vj6Kt1H0sJUac39L+wmG+zwM6hu18Ac=
Received: by mail-qk1-f171.google.com with SMTP id 125so2003051qkl.6;
        Mon, 19 Aug 2019 09:57:06 -0700 (PDT)
X-Gm-Message-State: APjAAAXvTuUfcK6LwCX153kA+mMaUEr+x91DJ19ZurcuuYXsvDLpdYjV
        1r3xHCRUoUj0THtrfKWCKnDov0LZc9pPzLy8cg==
X-Google-Smtp-Source: APXvYqwyhVlHcIl2LSHoMRx34pbpzeBY+xCk/huOncGRal9Z7YkSOH9Kh4xBNYxtoK3PB7VAUcXiqzLAuT5UcSFiTx8=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr22456622qke.223.1566233825565;
 Mon, 19 Aug 2019 09:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190814044814.102294-1-weiyongjun1@huawei.com>
In-Reply-To: <20190814044814.102294-1-weiyongjun1@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Aug 2019 11:56:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJA5kZo5_uJPJdgdPyLL5FwBDjcV9EWzPotef2=LrSNHQ@mail.gmail.com>
Message-ID: <CAL_JsqJA5kZo5_uJPJdgdPyLL5FwBDjcV9EWzPotef2=LrSNHQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/panfrost: Fix missing unlock on error in panfrost_mmu_map_fault_addr()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 11:44 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> Add the missing unlock before return from function panfrost_mmu_map_fault_addr()
> in the error handling case.
>
> Fixes: 187d2929206e ("drm/panfrost: Add support for GPU heap allocations")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

Rob
