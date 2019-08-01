Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF907D8DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 11:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbfHAJyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 05:54:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44949 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHAJyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:54:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so68530603edr.11;
        Thu, 01 Aug 2019 02:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=HDwRl6vMRhD30oswVwKGH6WeVMSf2INQif24SRGDP2c=;
        b=ncXE6zvNqssYaSBtVz2o73i4+Sauc+WG9+Qt1Z+IPy1qvlhJFNeo8oO8GHW8e+1VFV
         Nq/OzDI1sqgVUkpDFiDx2LywcM81QcJXDJYqJhFsZ3qcRY9TNsxCbrTtZ29Q8AFoNJBw
         KYcl1W6SI9/PsVoumuGvEYYXk1+C/sLzc36APO3UNG/lXGO7wAmuWblzog1JJdFeUiSS
         90a4oJfhtG2IYddrTIU1eDtpp1sOiiVB8Afbm6do4AgYmfJv7s/u4jWNNNJ0SiX9s4TX
         vaxTmD3XBQaIGme9cgpgHOoCJNHS57qmkZ/vNB0GThBMXDYDmrF1BNTwVapG1QNEkuPb
         6CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=HDwRl6vMRhD30oswVwKGH6WeVMSf2INQif24SRGDP2c=;
        b=X3fbM5/3vFDG+M1XVsnZvZ7gEwODbuL6gP48vTTD5agzrKpq215K4dyS3CAeuY3VG6
         2bESwcikuPuSXhjzfEc9iYZ4Md000j2lJ9V4ZlROJYBCbEyM5PV9lg6aMU4p0R6fRuvD
         TFQOnbdJt/sa9nZYLIyhkEr55SZ/SIey9GLoTNxr8QWmTgft2cAUswXCO360tQpWlrNE
         brVq51Yme/96W3dxAmDDauJjaHv1XBysR6c22YFlkLzkU9wEpLEG5td21p+r98DsfGXP
         /3MMhPdZxV7tesl0c38SlYdOGfV6wcJSP6mmdMZ+mWNAu21dd30sERTUy31NBHUoDGBf
         MlBQ==
X-Gm-Message-State: APjAAAXjVfjxSgdkVkGc5qhwne/zaRzqgXSFGBs+8ZDiv8VXSR+MqAsQ
        MO1rnfXxWiEy/b6pNiiR9OCCX0WuW0DtkNTnWmA=
X-Google-Smtp-Source: APXvYqyVJSqfyVqgaEvKLfpb0FBbq10+iVMF8OkohUZJ6bEAFux1rtQ7UrYXuRH18vBGfWc4mQKsoq/T73utJe2PJvA=
X-Received: by 2002:a17:906:81cb:: with SMTP id e11mr97605549ejx.37.1564653241450;
 Thu, 01 Aug 2019 02:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <1564306219-17439-1-git-send-email-bmeng.cn@gmail.com> <1564306219-17439-2-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1564306219-17439-2-git-send-email-bmeng.cn@gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 1 Aug 2019 17:53:50 +0800
Message-ID: <CAEUhbmVjELVPKwW6R+W+V2hQbZ_Zj_5j2ogjnTsuCwnK1pT-og@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: pci: pci-msi: Correct the unit-address
 of the pci node name
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 5:30 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> The unit-address must match the first address specified in the
> reg property of the node.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
>  Documentation/devicetree/bindings/pci/pci-msi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/pci-msi.txt b/Documentation/devicetree/bindings/pci/pci-msi.txt
> index 9b3cc81..b73d839 100644
> --- a/Documentation/devicetree/bindings/pci/pci-msi.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-msi.txt
> @@ -201,7 +201,7 @@ Example (5)
>                 #msi-cells = <1>;
>         };
>
> -       pci: pci@c {
> +       pci: pci@f {
>                 reg = <0xf 0x1>;
>                 compatible = "vendor,pcie-root-complex";
>                 device_type = "pci";
> --

Ping?
