Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85627FDEF7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 14:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfKONbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 08:31:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbfKONbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:31:45 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4037206D3;
        Fri, 15 Nov 2019 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573824704;
        bh=0mEy+vTE2NKp+0FpbmD77dCc1obSZTMQf07nHTB35X4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b+jqg4WGDuApN3mmoZ66wqccYiNLMXXggBPiKnocz71XvO3l9QtLDklSDtm+Uqykr
         +CTBdJno2bm/yzLh1fYOMVGinltDUSBOhoEB9DTSCO6rZabG3T+bCQBN5/OgQZaFjf
         oQ/wG9GnN4if+Ca+CpnUPmP8P1/sV8dP9X/jJ2jA=
Received: by mail-qk1-f174.google.com with SMTP id m4so8043303qke.9;
        Fri, 15 Nov 2019 05:31:44 -0800 (PST)
X-Gm-Message-State: APjAAAVTiXNyRqQ6P+lHDzD/BtaPjJiyfxBgJmXHg4yKEwxkFnIyunET
        c3qOyRCo4gi1lb7QOKXEBowA6gH2uOjgU5q92A==
X-Google-Smtp-Source: APXvYqzMPS3VKClIHmA0E8VehZ9+If+oxr1JeZ4huF9uwrJVhe9UxpXgWgnTse8IOpV5dfbE7pg3Dh5zmVck4EhBbJU=
X-Received: by 2002:a05:620a:205d:: with SMTP id d29mr12519950qka.152.1573824703941;
 Fri, 15 Nov 2019 05:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
 <20191111090230.3402-3-chunyan.zhang@unisoc.com> <CAAfSe-sCM7T2TZ25hgXSdqOCWzXN2J4qeoSRi8bveqnwGy3vBw@mail.gmail.com>
In-Reply-To: <CAAfSe-sCM7T2TZ25hgXSdqOCWzXN2J4qeoSRi8bveqnwGy3vBw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 15 Nov 2019 07:31:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJOC_b+urTESd4tLaacJ8gV3upyxHeGGngY2_3m0oJaLA@mail.gmail.com>
Message-ID: <CAL_JsqJOC_b+urTESd4tLaacJ8gV3upyxHeGGngY2_3m0oJaLA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: serial: Convert sprd-uart to json-schema
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 5:15 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> Hi Rob,
>
> On Mon, 11 Nov 2019 at 17:03, Chunyan Zhang <chunyan.zhang@unisoc.com> wrote:
>
> [cut]
>
> > +
> > +examples:
> > +  - |
> > +    serial@0 {
> > +      compatible = "sprd,sc9860-uart", "sprd,sc9836-uart";
> > +      reg = <0x0 0x100>;
> > +      interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
>
> Seems this setence cannot pass dt_binding_check, it need to be changed to:
> interrupts = <0 2 4>;
>
> Do you need me to send another patch, or you can help to fix that on
> your tree :)

I've fixed it up. You need the include file.

Rob
