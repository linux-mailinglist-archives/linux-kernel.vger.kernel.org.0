Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7F378BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 14:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfG2Mod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 08:44:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43778 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfG2Moc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:44:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17so33879738ljk.10;
        Mon, 29 Jul 2019 05:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=34NpLTsZ4fkze92bTwE7oYizxOiII+3mNHvu5YPrwQg=;
        b=sYWUT19w6mWSpEmhGoBMOWboPYVB9J0MDKyqrioJdXqtxpf7sB7qUMxlAIkIiiLBbb
         dYN2IpfMFp+OmfzibZz3tF+nIjnsU84VMRwecVQcTfXxYMd40fz9NqGcrL5TqvCs5Glg
         iElbOsHTgv+Rljh9Oaf2231snOJGThWreDmS2J0c8bvh1xDCqVAYTLAEmsNAFYEatg2g
         iN4zeq/1f9OyOsNOTZ237pzi26aGDlXADfPpEtHaBfye5deRxxTuyl1SOO+uwMc7TIFx
         zjWx18xaessRQ7usazf/aUfK9cIePQ3/4vbaypmKsYNicaqqo9/zGYvN/2fwH39Aj5qJ
         orWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=34NpLTsZ4fkze92bTwE7oYizxOiII+3mNHvu5YPrwQg=;
        b=p6usJm4mIzWERZiYzTEyR3QyrKbP6y7SJ9vg1Il910gR95s1C1VMh4+Tpjp2WwZN8x
         QGtaY/3ew26++xcd+Dm6G9BYNKSEQ5Ogg8AenaSOOLWoneokqG9ZI6Zl6BMCyuiu4ZbL
         4rXUeLO4Ucf04Do/8RH+hjw6FpL7v1pQM3Vnzp/Zrl34RpYVKsuIoUGFAfC/RuAg3oty
         1CbSb8YLqCaYlFMwj047X16dO0BreuRl9NeuCQB+IoaEHsW+I/roBX7MV/bsHdFiDQeh
         RIU2PqkMlBn98YTfNcg3K2NSZ8N4IS8W2oPQ7lVaNb+X17LzcjDqtAFDgGn4mwGIBar0
         7amQ==
X-Gm-Message-State: APjAAAWVcABMU5HWqutgXogOJTte9r4kBPxdDxqzgaN6qdnKveJMOWw0
        Iy6V3jL6EbFK8/6DElQo1sWgmO5hv0/gsPVBXJlFrB/75Tk=
X-Google-Smtp-Source: APXvYqyO+TyjwyPaTfWOn5ewv+w97iOZ0+hIanfcE3fCvIC4X4IqnxP2a/MdyOwFlyZDuUKM2tWcYs1d8BOOrkB9t9c=
X-Received: by 2002:a2e:5d1:: with SMTP id 200mr58267429ljf.10.1564404270408;
 Mon, 29 Jul 2019 05:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <35f999387bca037731dd963a5901909d6e6d0a17.1564226824.git.agx@sigxcpu.org>
In-Reply-To: <35f999387bca037731dd963a5901909d6e6d0a17.1564226824.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 29 Jul 2019 09:44:34 -0300
Message-ID: <CAOMZO5DDgPJvWtqO9fboSWeHcaqYFTeVd5zzDDdnMxG8uPUqEQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: imx: i.MX8MN: Use space instead of tab
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Sat, Jul 27, 2019 at 8:29 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> This fixes 'make dt_binding_check'
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>

Thanks for the patch, but Anson has already submitted a fix for this issue:
https://patchwork.kernel.org/patch/11057815/
