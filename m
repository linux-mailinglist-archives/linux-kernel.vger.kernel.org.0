Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF321A087
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 17:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfEJPvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 11:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfEJPvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:51:46 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF5320881;
        Fri, 10 May 2019 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557503505;
        bh=jjJN9MCI2/bJQYJD0A6H8bv3bdJi3Q/PurxoIoi1bLc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LFbRHLkQumOEJR0QML+NE/Dlx3jQ6C6mXckZ6o/H18WK018Tm7s1TH9ZiRjkY6qxC
         AvIQg21IbE7EAgEdM3O+kbiHPqqnhHQW7WuXCaEPtJ5nDJlnMMqS+fkyrgHNjngC+W
         V79pPqZ162SsEPoNUPJia0lru3wFAdbrvl66Xn2A=
Received: by mail-qt1-f182.google.com with SMTP id j53so7104703qta.9;
        Fri, 10 May 2019 08:51:45 -0700 (PDT)
X-Gm-Message-State: APjAAAU2Ln94eWk3ajQkjWtO+vcr3GHq8pA/9kJaXe6BlXXakeCx/wz5
        cY/sivEAh4itksZMztT+ZexDqgEF8Tr9pRSxBQ==
X-Google-Smtp-Source: APXvYqzCtiDrvSidyJ1Y6HHqXiZAob0e8QJkkwye5sqCJHrQXA7SekK8d+4LASnRxReen63o7QlSe27+zyjO89A4fJs=
X-Received: by 2002:a0c:fe65:: with SMTP id b5mr9797177qvv.106.1557503504974;
 Fri, 10 May 2019 08:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190507045433.542-1-hsinyi@chromium.org> <CAL_Jsq+rGeFKAPVmPvv_Z+G=BppKUK-tEUphBajZVxFtbRBJvQ@mail.gmail.com>
 <CAJMQK-i-0RgdQEniqaKubdjF-dpd1JOCWy7DOPDfN33EqgL5iA@mail.gmail.com>
In-Reply-To: <CAJMQK-i-0RgdQEniqaKubdjF-dpd1JOCWy7DOPDfN33EqgL5iA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 10 May 2019 10:51:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLHGobOQg-j=8e=ivCBWh6f+xy43zTzdXBQ-U86AOg-6w@mail.gmail.com>
Message-ID: <CAL_JsqLHGobOQg-j=8e=ivCBWh6f+xy43zTzdXBQ-U86AOg-6w@mail.gmail.com>
Subject: Re: [PATCH] arm64: add support for rng-seed
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 11:27 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Wed, May 8, 2019 at 3:47 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> > >  Documentation/devicetree/bindings/chosen.txt | 14 +++++++++
> >
> > Actually, this file has been converted to json-schema and lives
> > here[1]. I need to remove this one (or leave it with a reference to
> > the new one).
> >
>
> Hi Rob,
> I can't find where the new document is. Can you help point it again? Thanks.

Sorry, forgot to add that:

https://github.com/devicetree-org/dt-schema/blob/master/schemas/chosen.yaml

Rob
