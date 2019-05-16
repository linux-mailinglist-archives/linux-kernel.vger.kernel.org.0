Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E342209DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 16:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfEPOhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 10:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfEPOhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:37:18 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D040C20862;
        Thu, 16 May 2019 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558017437;
        bh=UPgAsUc79XNtfoQLrq5V7qKL0/VATYvYljrh0Yj6lC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n2o986utdwrt65N1HHcVbGub2fHvrq6Z4LEqkZ2qoBktiT2y2DVRtZPHi7RdF9M4b
         PLRCHV1s+1ZaAkWT+a8kBvyFVXzVXKww0djxYygi+d8bTb7bkSpZ003Bw0TIqndGt2
         waogEKjp45WBd1mx5k4syT9ImPuVR90FaHySr/x8=
Received: by mail-qt1-f171.google.com with SMTP id y22so4124656qtn.8;
        Thu, 16 May 2019 07:37:17 -0700 (PDT)
X-Gm-Message-State: APjAAAWYKF4x1IS1n0KLvQxaIxWrF4lpfYhIMYN8LdImu7mK6A4QWPc2
        +K479C24tmlqPVR82OYdgZOQK4Bt/JRqILipBg==
X-Google-Smtp-Source: APXvYqxjn8+Q/tX6w4aHOCCOy/nwGU1dlgV2FSFLkzU2uNxOFA2xYDsfkDw8xIChp0sA+l8ZLuw1WIIccuhOM18Sefw=
X-Received: by 2002:a0c:87cd:: with SMTP id 13mr13711355qvk.218.1558017437078;
 Thu, 16 May 2019 07:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102817.188519-1-hsinyi@chromium.org> <20190516102817.188519-2-hsinyi@chromium.org>
In-Reply-To: <20190516102817.188519-2-hsinyi@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 May 2019 09:37:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLx1UdjCnZ69aQm0GU_uOdd7tTdD_oM=D7yhDANoQ0fEA@mail.gmail.com>
Message-ID: <CAL_JsqLx1UdjCnZ69aQm0GU_uOdd7tTdD_oM=D7yhDANoQ0fEA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: implement update_fdt_pgprot()
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 5:28 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Basically does similar things like __fixmap_remap_fdt(). It's supposed
> to be called after fixmap_remap_fdt() is called at least once, so region
> checking can be skipped. Since it needs to know dt physical address, make
> a copy of the value of __fdt_pointer.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  arch/arm64/kernel/setup.c |  2 ++
>  arch/arm64/mm/mmu.c       | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)

Why not just map the FDT R/W at the start and change it to RO just
before calling unflatten_device_tree? Then all the FDT scanning
functions or any future fixups we need can just assume R/W. That is
essentially what Stephen suggested. However, there's no need for a
weak function as it can all be done within the arch code.

However, I'm still wondering why the FDT needs to be RO in the first place.

Rob
