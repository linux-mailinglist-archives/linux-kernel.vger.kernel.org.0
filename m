Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 209EF9C872
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 06:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfHZEiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 00:38:09 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:45445 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfHZEiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 00:38:09 -0400
Received: by mail-io1-f50.google.com with SMTP id t3so34089003ioj.12;
        Sun, 25 Aug 2019 21:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1exAYWMUyyRgKmul096n+B+OJhwM6f4sJVMKQ8yVO4=;
        b=sNQY2SpHNTmIlNk/wEGcudVnHQM83F7hQaS1ETEjI79e15eMZ/xtylyHzPmznM+1R6
         1IA03XGhcgR92W7/4Jezb2kbTUHRHGW4TRqQTKB7ssDi1YSl+eQvvPiSk3hy/aOjFHc+
         3l1PR0QAE2VQsmxiOJwbV6clUiMsSCrMoAcb72aw4cNsQZWt/c844lUQLo4RLaFZmuNi
         iLMbl/Ggw7uLD7MVLEMbeww3FeArGoHVn/PyZG/gcn8HH+sZTalWC8u4742g1hxkd9Zp
         01oU8R2vwCiRvGUawpE99qLI/drjYNbfoEH6BEkNM6s/tm0vknYY9BWV/PKXQKn18hW1
         Orig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1exAYWMUyyRgKmul096n+B+OJhwM6f4sJVMKQ8yVO4=;
        b=JkkGGgBFD8+7nOmkF31wxPEpksMnHpxw9ZBTZlR/Ofcl4UsTEPXggJiv+fVLxi4sqx
         ES7FHeKm6rhgEM7NTokFcVXQyLtRnESfFriCpDZorMG3hwmMlgLx3PcBYIPhsqAlwCN/
         ncCMgSWNvV67f480K2/5GBieZWSJs3hBLxNOLwtBZdpYxzdvKKAra0a149S5UsWq1i4V
         s/YOoQ+ZJLTsaih58YvblXFXlEiNjTPTRHSbzecQeeeWVMGG2yqPZ4vnVTSUfWkVS7vS
         8dZ1axtgQFIR4Pmq5paFW4K8MH1rL46ThHV1gpYx72hXKoLPa4Xla54Ch91DeomymO+7
         JfQw==
X-Gm-Message-State: APjAAAXlhoUvasUYCCEOYXTNlBJg3N0bXPOmUhGZFzLrhibB0k1H2uGM
        WItosdvuYU8zG8JDHxm2MertFghYRPOEepU/p+k=
X-Google-Smtp-Source: APXvYqwEEY4HsG8gz1jj+r6ZLb2rp/DiM2S4ZMAN7B0+HDDxv6FuAymB/Jnl0NRYtaRzdacjMIKfIX+oi2ihc+NiIOE=
X-Received: by 2002:a6b:4409:: with SMTP id r9mr22335208ioa.75.1566794288499;
 Sun, 25 Aug 2019 21:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190824184912.795-1-linux.amoon@gmail.com> <CAFBinCCkEE8==-Sqqj_=Ofnx7_H-970dETwEmEPohs74806ZMw@mail.gmail.com>
In-Reply-To: <CAFBinCCkEE8==-Sqqj_=Ofnx7_H-970dETwEmEPohs74806ZMw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 26 Aug 2019 10:08:01 +0530
Message-ID: <CANAwSgTsua_x6fi7NzC2XjcV19OJcN3NhOT_niKXN4RR4X+qVQ@mail.gmail.com>
Subject: Re: [PATCHv4 0/3] Odroid c2 usb fixs
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Sun, 25 Aug 2019 at 02:48, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> thank you for the patches
>
> On Sat, Aug 24, 2019 at 8:49 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > Anand Moon (3):
> >   arm64: dts: meson: odroid-c2: p5v0 is the main 5V power input
> >   arm64: dts: meson: odroid-c2: Add missing linking regulator to usb bus
> >   arm64: dts: meson: odroid-c2: Disable usb_otg bus to avoid power
> >     failed warning
> this whole series is:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thanks, I have some more patch in line for this board.

Best Regards
-Anand
