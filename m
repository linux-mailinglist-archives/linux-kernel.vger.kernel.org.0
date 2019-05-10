Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B35819787
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 06:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfEJE1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 00:27:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34992 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfEJE13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 00:27:29 -0400
Received: by mail-qt1-f196.google.com with SMTP id a39so4343567qtk.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 21:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngq08Wlyg2H31lwwSV/j8xQrFKwzvO2qP6ztkd7Nr28=;
        b=fuMNIjVG7c7hl9TqmLZaCgk9uw8zCqNkHPHTQf2dgfrBbILw0WaZg9/92di/69XTYw
         mEL0Bk2U3l/9dTL8S03K1TeKwNrvGPhaqPYYhh6U9R3UWp9e00qH5XiAYyvKTbK2nCU3
         sS43C8EHGgEYjTPYiSnIPhJod4FG7Rk+TYhGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngq08Wlyg2H31lwwSV/j8xQrFKwzvO2qP6ztkd7Nr28=;
        b=mSRcN6fclEy/t45Dn928KX+4kPI7RtKDgHHzyO80pG07rdmdny+wblTNBbmBYnWFnv
         UoLwkeqqcgwwMrGVQH7dCgzYruVoS0k9FBEp9lHl7TYpXxfRPWZMxgFIBtLOpriI0lji
         YGSidzp2d49C8bFJl5K3kS7ST16URXRuKUqJ2iHuQam2uxDsCsEE3QQgCbyI8PNOenuN
         Ma8BSrLHQEL/76Q8ISLNv0N/SLJj6F3dcB02PHY2PbdeeMQTJ0C+RB9H9SNfIsV2Dy2l
         Ze4mM4HntubbNytroodEVtm9kr81/Y1uqK9YyvEGP4/ffHExcMf4N9GO61PjY49lo04A
         UTMA==
X-Gm-Message-State: APjAAAWStOs4jO2CVAGnpsqPTyQaP+H7bCghZAzHoeJdzwvU5wf0rCgA
        utaO6c2cYXDGZ1AEIJVtaStrHbrIMkSzX4UScefaOw==
X-Google-Smtp-Source: APXvYqwwzIn/YJ/0P0Vb+0s8M37PUufsc0Gp9hafSnPJ9qzKi2oOspaUm7VkSvnkEjICaSYyxOJsDM038OFvfuU0Nho=
X-Received: by 2002:a0c:d985:: with SMTP id y5mr7230641qvj.80.1557462448871;
 Thu, 09 May 2019 21:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190507045433.542-1-hsinyi@chromium.org> <CAL_Jsq+rGeFKAPVmPvv_Z+G=BppKUK-tEUphBajZVxFtbRBJvQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+rGeFKAPVmPvv_Z+G=BppKUK-tEUphBajZVxFtbRBJvQ@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 10 May 2019 12:27:02 +0800
Message-ID: <CAJMQK-i-0RgdQEniqaKubdjF-dpd1JOCWy7DOPDfN33EqgL5iA@mail.gmail.com>
Subject: Re: [PATCH] arm64: add support for rng-seed
To:     Rob Herring <robh+dt@kernel.org>
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

On Wed, May 8, 2019 at 3:47 AM Rob Herring <robh+dt@kernel.org> wrote:

> >  Documentation/devicetree/bindings/chosen.txt | 14 +++++++++
>
> Actually, this file has been converted to json-schema and lives
> here[1]. I need to remove this one (or leave it with a reference to
> the new one).
>

Hi Rob,
I can't find where the new document is. Can you help point it again? Thanks.
