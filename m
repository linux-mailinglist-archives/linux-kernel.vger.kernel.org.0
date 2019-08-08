Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30BF786D71
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 00:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403940AbfHHWxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 18:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732375AbfHHWxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:53:09 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F37762173E;
        Thu,  8 Aug 2019 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565304788;
        bh=UDl7FH9qccKh/jy2kxm+7vEFoGqeFPVijVmq33g23+c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bi/78M6qbFJlefcTvFTsTLezgq2DnCTUQYOR6vyIORZBWg4CQ0BCw3oe4UdF3d/ow
         SomPXm6HdaGZwrFV01uftjCqpntfXpu5VmE+ISAGGudtXv163rgX/lAbZ+Ckwlb1B8
         scfMvmr3VG9osL7Xd195FCJF1Bu6jLcLX+xBWUjY=
Received: by mail-qk1-f174.google.com with SMTP id d79so70163807qke.11;
        Thu, 08 Aug 2019 15:53:07 -0700 (PDT)
X-Gm-Message-State: APjAAAXty+jrSwkPmnmpkpNYnZAOv3lso4ljnuJPaYuxHvLaq56oRzCa
        7OmUQ+gWx6wmHPgLN/+2ShDnvjJy0FSrSS3mrQ==
X-Google-Smtp-Source: APXvYqyU/kTW6gdeVEMYafTbUnx/nIzUaj84Avqg8qc37wlRfsJNN1u8HEG+RqvAQ2Z+Dk87rGVIawEEewvI80/Z1T8=
X-Received: by 2002:a37:d8f:: with SMTP id 137mr8830673qkn.254.1565304787197;
 Thu, 08 Aug 2019 15:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1908081545190.15649@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1908081545190.15649@viisi.sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 8 Aug 2019 16:52:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5ms_65sux=Xi=beyu-vD9Qh-ziTpvpLz-qrtwOaLoEw@mail.gmail.com>
Message-ID: <CAL_JsqK5ms_65sux=Xi=beyu-vD9Qh-ziTpvpLz-qrtwOaLoEw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: riscv: fix the schema compatible string for
 the HiFive Unleashed board
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 4:46 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
> The YAML binding document for SiFive boards has an incorrect
> compatible string for the HiFive Unleashed board.  Change it to match
> the name of the board on the SiFive web site:
>
>    https://www.sifive.com/boards/hifive-unleashed
>
> which also matches the contents of the board DT data file:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts#n13
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  Documentation/devicetree/bindings/riscv/sifive.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
