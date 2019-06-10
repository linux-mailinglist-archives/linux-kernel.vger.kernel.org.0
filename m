Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0944C3BEE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 23:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389893AbfFJVrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 17:47:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387661AbfFJVrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:47:12 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D499212F5;
        Mon, 10 Jun 2019 21:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560203231;
        bh=A8TOGTJuwEvDUH/d1MVUsnWqz/0g/2fFNSmp+Wiv8QI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IcBndJBr6x/GrCfOf5zp8rcKfj/TR41OBRQ/gcrB4SrrMIDF1Ny94rr/y28vbhhpg
         Ey53NcaAnDuOIxsLaVnk5T4AaD3S6tpj0uSt1RrTIPZKX9oAZdoe1tCZB7GIVfDZPQ
         Jd/WGPKVhIWpLau+kcCay2XV9gLLZhXsQHT3Lvco=
Received: by mail-qt1-f181.google.com with SMTP id x2so11261378qtr.0;
        Mon, 10 Jun 2019 14:47:11 -0700 (PDT)
X-Gm-Message-State: APjAAAVD8GbsHMZ/bW947Mq5DVvHQ6+M3bkupGcyWqlk/4nMZ2Dx49bf
        1qkQMzjDyw105juR/V2BJCKknAzRjL6yrAry1Q==
X-Google-Smtp-Source: APXvYqw9ixaCWUtaCgRr6x7b/pNyEcY2V2n0Ntzbi7l3rhY966w4TpEXuCtCcBErZwa27WAPk/RTAG7YzipmNve+aho=
X-Received: by 2002:aed:3b33:: with SMTP id p48mr54298406qte.143.1560203230912;
 Mon, 10 Jun 2019 14:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190602080126.31075-1-paul.walmsley@sifive.com> <20190602080126.31075-4-paul.walmsley@sifive.com>
In-Reply-To: <20190602080126.31075-4-paul.walmsley@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Jun 2019 15:46:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJd6s6ta==AoxmNXdpzWL1RytSwR2P4MOfAFSEJavbt+w@mail.gmail.com>
Message-ID: <CAL_JsqJd6s6ta==AoxmNXdpzWL1RytSwR2P4MOfAFSEJavbt+w@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: riscv: convert cpu binding to json-schema
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Paul Walmsley <paul@pwsan.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 2, 2019 at 2:01 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> At Rob's request, we're starting to migrate our DT binding
> documentation to json-schema YAML format.  Start by converting our cpu
> binding documentation.  While doing so, document more properties and
> nodes.  This includes adding binding documentation support for the E51
> and U54 CPU cores ("harts") that are present on this SoC.  These cores
> are described in:
>
>     https://static.dev.sifive.com/FU540-C000-v1.0.pdf
>
> This cpus.yaml file is intended to be a starting point and to
> evolve over time.  It passes dt-doc-validate as of the yaml-bindings
> commit 4c79d42e9216.
>
> This patch was originally based on the ARM json-schema binding
> documentation as added by commit 672951cbd1b7 ("dt-bindings: arm: Convert
> cpu binding to json-schema").
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> ---
>  .../devicetree/bindings/riscv/cpus.yaml       | 168 ++++++++++++++++++
>  1 file changed, 168 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/cpus.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
