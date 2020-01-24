Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 019C914867F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 15:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390043AbgAXOEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 09:04:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:32988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387698AbgAXOEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:04:00 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A88A82071A;
        Fri, 24 Jan 2020 14:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579874639;
        bh=EmoC3saBU+pvM+zatEU9e1eFKaGsdFiXHvfsUFIX2/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zmCU+2nSNeoG0BOQIx2HgKudgPZO/y9lVwE/uegPyaDsdEeD7gADQslwU6Eeyfdqt
         p6hIoR4Cyg6ASVlnVlcPybdgbJD8ek5A3RCl3Zf9CFypAfya0MazzlPgzMM7O1hcH0
         fQoh4WxM/UP8bjMmcHSZrFBkjlPrIh0qc3WPejsQ=
Received: by mail-qk1-f180.google.com with SMTP id t204so1263221qke.7;
        Fri, 24 Jan 2020 06:03:59 -0800 (PST)
X-Gm-Message-State: APjAAAVabIL4iBeRGq9G1PaS7Ks5fo694OllIvrBiJO3w+2/zvCoRAbf
        zny4b/YKXZBs5JMHV9A57385stYzZSpBNzRFfw==
X-Google-Smtp-Source: APXvYqy5HLZ83xPew4yj0L30VTCwtdMFWYmbUs/IvA3nbdvnWnKHV3+zkH97cIu85Jh+L0yySOSBtrX9qUNvuAl1a+g=
X-Received: by 2002:a05:620a:9c7:: with SMTP id y7mr2583085qky.393.1579874638845;
 Fri, 24 Jan 2020 06:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20200124114914.27065-1-dafna.hirschfeld@collabora.com>
In-Reply-To: <20200124114914.27065-1-dafna.hirschfeld@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 24 Jan 2020 08:03:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKgNzY=KF8XzuGjw2NogBawfi0gh9ytrk_nw_Ewg2QDdg@mail.gmail.com>
Message-ID: <CAL_JsqKgNzY=KF8XzuGjw2NogBawfi0gh9ytrk_nw_Ewg2QDdg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: fix compilation error of the example in intel,lgm-emmc-phy.yaml
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>, dafna3@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 5:49 AM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
> Running:
> export DT_SCHEMA_FILES=Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> 'make dt_binding_check'
>
> gives a compilation error. This is because in the example there
> is the label 'emmc-phy' but labels are not allowed to have '-' sing.
> Replace the '-' with '_' to fix the error.
>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

There's a fix from the author, but you're first to get the fix correct, so:

Fixes: 5bc999108025 ("dt-bindings: phy: intel-emmc-phy: Add YAML
schema for LGM eMMC PHY")
Acked-by: Rob Herring <robh@kernel.org>

Kishon, Please apply these soon as linux-next is broken.

Rob
