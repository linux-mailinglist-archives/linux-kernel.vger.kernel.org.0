Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41022A0CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 23:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404462AbfEXV6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 17:58:40 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41988 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404259AbfEXV6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:58:40 -0400
Received: by mail-oi1-f194.google.com with SMTP id w9so8097552oic.9;
        Fri, 24 May 2019 14:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FX0nAAQKdK8gCwAelke8YNA0bB3X71pjYoDs2aHxEiE=;
        b=LkKY2TLTIBDLMpOFtQjVSNEgz9+tvvxbpPSUvIPuNIFG/QSM1YLLoeWVh4/XyYRkeM
         o1kmkcGqKs21KdG8jNKs3mBUp4p8E90rumR2cc+zxOdKWmXBomsVnH26gJJDxAOFgCns
         XNh3fL3r9xErE5A4ZqQ7PVsWSKjeSkW9gp4/u9y5J/QImkVBCOUmMJdMHeLgcB1K8cgo
         u/5lDHBN4YSLRV6ANjTAxsdGkc2Gxu2AR0e7xdWuIk2aZJdqk18E5p8ehclN/ZgB+4Gz
         tOPQgo01IYdAV1UcR+LTgKV8T/RuOlxrLj5eWUjs/NTtGCZljMveDXH41E9fLgJDwrCU
         6u+A==
X-Gm-Message-State: APjAAAUBjlP6BwfqCDbha/CQVpGpDC4yY6LpdNU/2R38JGXoMzox8YPm
        6M3FXnYMEuQl8jPTuEZnqA==
X-Google-Smtp-Source: APXvYqytH+9RhKlZb9pctda4btXYaKYVWztG+4GxfJz4UGzSbQyRu3Kkka4gSAaGipt9f8+8R7wEFg==
X-Received: by 2002:aca:4bd2:: with SMTP id y201mr7159994oia.12.1558735119348;
        Fri, 24 May 2019 14:58:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x72sm1442794oif.50.2019.05.24.14.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 14:58:38 -0700 (PDT)
Date:   Fri, 24 May 2019 16:58:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 1/3] amr64: map FDT as RW for early_init_dt_scan()
Message-ID: <20190524215838.GA16271@bogus>
References: <20190519160446.320-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190519160446.320-1-hsinyi@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 12:04:44AM +0800, Hsin-Yi Wang wrote:
> Currently in arm64, FDT is mapped to RO before it's passed to
> early_init_dt_scan(). However, there might be some code that needs
> to modify FDT during init. Map FDT to RW until unflatten DT.

typo in the subject.

Otherwise, this one seems fine to me.

> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> change log v2->v4:
> * v3 abandoned
> * add an arg pgprot_t to fixmap_remap_fdt()
> ---
>  arch/arm64/include/asm/mmu.h | 2 +-
>  arch/arm64/kernel/setup.c    | 5 ++++-
>  arch/arm64/mm/mmu.c          | 4 ++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
