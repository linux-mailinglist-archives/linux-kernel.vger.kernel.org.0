Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6090418FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 01:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408179AbfFKXfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 19:35:01 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37055 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405380AbfFKXfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:35:00 -0400
Received: by mail-it1-f193.google.com with SMTP id x22so7703874itl.2;
        Tue, 11 Jun 2019 16:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m12BEF6aoD8sKKRDjXmfbkhom6wFfuNMaUfEfaPontI=;
        b=XY0rO2QwWDGXv8VVnDhHhvdSjjvbZijD/ov9NKzOKMub0OeJJCX9/bSZuY9+/qN6/y
         TqtZX8bPgOv25p0uXyW6mlEgXwgB8BpRHkwp5Gq3ec1PJwgj0sGgCfX7cKNtTUNMqDMb
         th742GGwBdnUr9TbLgmXe7asWtUE+TnrEG5Ay9ukVxO+qtGhQakkOMFB9SRVccxxz1T4
         3zytVj7MQ+pT34uh7iZhocD8fv8yLPyK4k87ADndWLalQvC/8Kh9wXTbtrbKIN91ZvU+
         yMkfUu41g/Tj78vV/EriqJMDQ0OIJ2fge5WNFDwguOSeWH014BXACcNIrnObrKToMo1X
         71cw==
X-Gm-Message-State: APjAAAVtZURezix/FJ+P86mISyFSyjY6SfeM+pKGBNWS/lK3Qy82dtJm
        RE/3DJz5DWIbqRqWwzY39A==
X-Google-Smtp-Source: APXvYqye7O0X80ue+IvTi1olrle0IaMnhZvFUdN3Pu38l2XXIz46k5UuwXpGJfD3KkSIfO+KTcA/TQ==
X-Received: by 2002:a24:4754:: with SMTP id t81mr21499151itb.106.1560296099482;
        Tue, 11 Jun 2019 16:34:59 -0700 (PDT)
Received: from localhost (ip-174-149-252-64.englco.spcsdns.net. [174.149.252.64])
        by smtp.gmail.com with ESMTPSA id q79sm2082456itb.15.2019.06.11.16.34.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 16:34:58 -0700 (PDT)
Date:   Tue, 11 Jun 2019 17:34:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
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
        Kees Cook <keescook@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v5 2/3] fdt: add support for rng-seed
Message-ID: <20190611233453.GA14130@bogus>
References: <20190527043336.112854-1-hsinyi@chromium.org>
 <20190527043336.112854-2-hsinyi@chromium.org>
 <5ced598d.1c69fb81.dabd8.339d@mx.google.com>
 <CAJMQK-i0z1EHCMK3eTya+SmK6GD_C4Ljvb7BHvsaMWLDxxmwMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMQK-i0z1EHCMK3eTya+SmK6GD_C4Ljvb7BHvsaMWLDxxmwMg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 06:59:11PM +0800, Hsin-Yi Wang wrote:
> On Tue, May 28, 2019 at 11:53 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Hsin-Yi Wang (2019-05-26 21:33:35)
> > > Introducing a chosen node, rng-seed, which is an entropy that can be
> > > passed to kernel called very early to increase initial device
> > > randomness. Bootloader should provide this entropy and the value is
> > > read from /chosen/rng-seed in DT.
> > >
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > ---
> >
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> >
> 
> Hi Rob,
> 
> Is this series accepted? Or is there any other related concern?
> 
> If it's fine, I also have sent a patch for updating
> schemas/chosen.yaml document.

The kernel change is fine, but please put the documentation change into 
the schema doc (in github.com/devicetree-org/dt-schema) and don't modify 
chosen.txt.

Rob
