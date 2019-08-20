Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 161F296ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 22:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfHTUiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 16:38:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45348 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTUiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:38:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id v12so5173507oic.12;
        Tue, 20 Aug 2019 13:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7VmI4UR9rm/Jfd08uHYSrv3Ihas2nSA2EW/A7sAlzUk=;
        b=NZz+Q/nQp5XIJDHqOuZKxrlqHsz7DlKqAGfPwQw+ZIWoVvVirJzUdKy0D3SePNTrbi
         oXJX70Ubh1xaczVNx+RqFnM4ehZhrWqs6cyhbFGPJYkfP+9qkx8d2UAX4YrkB5+wZu3A
         4yw2J4s1M6UaUjgkRsTWqHXrKW42tpKV8kYRmUiMdOwuiQ7ZZqHiK0JvRZN6ZL4Gpkly
         f1JsPfx180hyjBqpXHSZ5AyYsVvXw6SBTUshGwLW+4f9koeQjhk5poS15zAmTPQnKdDj
         x/Iwnd1YkEaOFvt+MhMNZRoFS46Q8sT6d1sqjO+j9Kjcr/OBkkm29odhltz1HBO/suVP
         5NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VmI4UR9rm/Jfd08uHYSrv3Ihas2nSA2EW/A7sAlzUk=;
        b=E99JNDHaioKtJ7cpLvIYt4LFYBjoiinPeu7zmMrW/LmQrtr0WcHVL2nnNE8EzrMBrZ
         VefOSN4pmysh9gvFmgg1AjzE4GxsFH8U11ef5sd4dOfI1uxpaniHCBSFa3ePi/XleOfw
         EyKBiekm9Pv9RF6tWSuvnSwItxnTchBtN5kFRnkd99aQJ/Cn57JpHUXFpSQTSGShWRIv
         PWrC1gj06NABUTadxA0QL83xlz0LhYX2WO9kOPhNtvZwdqPoFR5al3YcHJ+aNjWnKqob
         Ru8Fav69+ctaG97B6UK9N75sRZjzvUNx7Tyh+xatespf4ZNsJS3GhdDyxxPlMkZJDoty
         EwDQ==
X-Gm-Message-State: APjAAAUwTgq1+1RwwCy/OCrnjDqHK32/HyuhEnUQ7z+PguBbPaIRGe17
        yM429ugQl+fpUvXbEgaCFyWyshSMPIVVgnaMHaMe7g==
X-Google-Smtp-Source: APXvYqxrzFrQ+g2QEmNNouNemvPcTmQHcQR4X6WXqzrbCBDuYyrd6w2oQ7citF3f2pm6VSFkWc7jHwI34ndZ7LUVb4I=
X-Received: by 2002:a05:6808:b14:: with SMTP id s20mr1380498oij.15.1566333504047;
 Tue, 20 Aug 2019 13:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190814142918.11636-1-narmstrong@baylibre.com> <20190814142918.11636-9-narmstrong@baylibre.com>
In-Reply-To: <20190814142918.11636-9-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Aug 2019 22:38:13 +0200
Message-ID: <CAFBinCAyhfk1wq0ejXazTWQ=eNqDROauB_Kbc80+ekPQ7oB9Ww@mail.gmail.com>
Subject: Re: [PATCH 08/14] arm64: dts: meson-gxl: fix internal phy compatible
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adding Jerome

On Wed, Aug 14, 2019 at 4:31 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This fixes the following DT schemas check errors:
> meson-gxl-s805x-libretech-ac.dt.yaml: ethernet-phy@8: compatible: ['ethernet-phy-id0181.4400', 'ethernet-phy-ieee802.3-c22'] is not valid under any of the given schemas
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> index ee1ecdbcc958..43eb158bee24 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> @@ -709,7 +709,7 @@
>                         #size-cells = <0>;
>
>                         internal_phy: ethernet-phy@8 {
> -                               compatible = "ethernet-phy-id0181.4400", "ethernet-phy-ieee802.3-c22";
> +                               compatible = "ethernet-phy-id0181.4400";
on G12A there was a specific reason (iirc it was because the PHY ID
can be any arbitrary value programmed into some register) why we added
it with a compatible string
Jerome, do we have the same situation on GXL/GXM as well?

if not I prefer to drop the compatible string because it's probably
from a time where the PHY dt-bindings stated "add the PHY ID
compatible string if you know it" while the actual suggestion was
"only add it if reading the ID doesn't work for some reason"


Martin
