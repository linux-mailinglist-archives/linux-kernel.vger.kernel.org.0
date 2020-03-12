Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC55518276B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 04:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbgCLD0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 23:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730913AbgCLD0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 23:26:24 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B05620758;
        Thu, 12 Mar 2020 03:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583983584;
        bh=08jCRw8Qsj1MjgSuweg+nOPCezUdYX+IRjWXZqx9YBc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hzOFLFjg2PWhvcyUB4aLAMVeI5qLIAzUua4pwXOKzZYX3LXaGSyDcInJyq2cqMLc7
         g727Gnz9pK9osugdw1h3volU8+VAuoy6OqxBHXzluVRgzdeEge8s46jQiOnwPBXXDa
         R4Ck6zMNCMZHyzXyrA7idrS8QaOdpJi1ZJAovpoo=
Received: by mail-wm1-f52.google.com with SMTP id g62so4638174wme.1;
        Wed, 11 Mar 2020 20:26:23 -0700 (PDT)
X-Gm-Message-State: ANhLgQ03TDs59qYr0RPdWDkjUtDPskW+KCeJGkW2pl0DLl6EWewCskQL
        qWVH4TaWHwAiGvWBwWWVW68It9LWoEHw5ZViggw=
X-Google-Smtp-Source: ADFU+vv74O22275eZMI1PdvaJPZT0b+o0VzwOCB2XmgL16YTTbB4Y8QeGcErTTfFc2dfeiZjtHZvaLJaxKFiUACk2D0=
X-Received: by 2002:a7b:c118:: with SMTP id w24mr2114631wmi.77.1583983582122;
 Wed, 11 Mar 2020 20:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200310174709.24174-1-wens@kernel.org> <20200310181003.wgryf373em5zwlvb@gilmour.lan>
In-Reply-To: <20200310181003.wgryf373em5zwlvb@gilmour.lan>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Thu, 12 Mar 2020 11:26:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v64MeW-qNLa9-ffCvRRYV9sa7FbM9R+c-8z40GW=FajOtQ@mail.gmail.com>
Message-ID: <CAGb2v64MeW-qNLa9-ffCvRRYV9sa7FbM9R+c-8z40GW=FajOtQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: dts: sun8i: r40: fix SPI address and reorder nodes
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 2:10 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Wed, Mar 11, 2020 at 01:47:06AM +0800, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > Hi,
> >
> > Here are some fixes for the R40 device tree for v5.6. The base addresses
> > for SPI2 and SPI3 were incorrect and are fixed. I also found some nodes
> > were not added in the proper order, possibly because git matched the
> > incorrect place when applying the patch. These are fixed as well.
> >
> > ChenYu
>
> Acked-by: Maxime Ripard <mripard@kernel.org>

Merged all three for v5.6 with Andre's Reviewed-by and a reported-by
for the SPI address base patch.
