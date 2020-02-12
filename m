Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1EF15ADC7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 17:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgBLQzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 11:55:55 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45286 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgBLQzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:55:53 -0500
Received: by mail-oi1-f195.google.com with SMTP id v19so2640362oic.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 08:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZkG/VJ0lY45qdF4MZ2qq6J5mSSjviuZtICqPeqXG708=;
        b=Vv2ffK4Tn6ryJ3u0zImgBE+lv/0R7s5t+mw+3Te7EpAzd38xjmIPEqZyXrxi/WIGy3
         PuP7b09q/I+873zyJbKPBdUJISC3i0ZaeEme5R8OeHbU564OvTTGCOfC87gouXmzQdaw
         JPauOP9XAQprQjVpwRu27CWvJ0prmMrhvAP79aPDCJ+oyMriUldZKW2AClI04zeM9N4U
         QHr76ARNFeJEehxVx6CHopb36awgrqyU2zJg+acUmAJh5Z1rnxMsGT0hqUpaq0ku5nI0
         z2W33+sMe+iZzh14V6TZ/Ma+B/fRWBKuaDN+cgOhYrN5ulNGzWC7KF4XsnMtmy3PpkmX
         hOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZkG/VJ0lY45qdF4MZ2qq6J5mSSjviuZtICqPeqXG708=;
        b=YZUmhG70M5UWI1o5i4AstW80Mfd7duKGz9T9c90gpr6OqoXZtrvlTTc/kXOXcSddrJ
         QdWWmaZlqR4EtT5jY12NvZ6z8G0DfR/oVTfEuVi4pywrRBtUwcoPy5jja9T9CfH393Z4
         g6mwO0hPgewSf/t+cT0Oh3RvdxgpRRbIDtFPM6hPSxf/s9kQsAsIdAm9LxiHjPTPDtkw
         js/uii7OFqNZDdqADwWbddHXmpbbjOLePeSmDM710AYMfKY2EV4GuhLjdxmC/AwlEMGb
         kbLj64jSzMPCpMOlaBdp8nNbsrRvkF6IiIV0F2Osr/L9W8byNTBVGIxknHCgY1T4DYvn
         nd9w==
X-Gm-Message-State: APjAAAXNDfMt/P+jEPu14wpCy4bGWSdjVjdxPGfpxpR4yUYIqcvP7dhs
        QVXJmOrL2ll78qU/RoaQmdkP+cGhLv8j21bzFxlRdA==
X-Google-Smtp-Source: APXvYqzYAb+EoIZD6mRgbOzS6nvLilEz5kbsemDCZy3GCG2u6vymyRgjxZkbkDxYxSLDxkHcfqO1vFSxU1iqnnTcdXs=
X-Received: by 2002:aca:4e02:: with SMTP id c2mr7056666oib.142.1581526551075;
 Wed, 12 Feb 2020 08:55:51 -0800 (PST)
MIME-Version: 1.0
References: <1581108026-28170-1-git-send-email-tharvey@gateworks.com> <20200207210209.GD19213@lunn.ch>
In-Reply-To: <20200207210209.GD19213@lunn.ch>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 12 Feb 2020 08:55:39 -0800
Message-ID: <CAJ+vNU0LV7EquWXfBKfYYLzagXiVHtvqMtx5hiM1zxXQWVgWrA@mail.gmail.com>
Subject: Re: [PATCH] net: thunderx: use proper interface type for RGMII
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, rrichter@marvell.com,
        linux-arm-kernel@lists.infradead.org,
        David Miller <davem@davemloft.net>, sgoutham@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 7, 2020 at 1:02 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Feb 07, 2020 at 12:40:26PM -0800, Tim Harvey wrote:
> > The configuration of the OCTEONTX XCV_DLL_CTL register via
> > xcv_init_hw() is such that the RGMII RX delay is bypassed
> > leaving the RGMII TX delay enabled in the MAC:
> >
> >       /* Configure DLL - enable or bypass
> >        * TX no bypass, RX bypass
> >        */
> >       cfg = readq_relaxed(xcv->reg_base + XCV_DLL_CTL);
> >       cfg &= ~0xFF03;
> >       cfg |= CLKRX_BYP;
> >       writeq_relaxed(cfg, xcv->reg_base + XCV_DLL_CTL);
> >
> > This would coorespond to a interface type of PHY_INTERFACE_MODE_RGMII_RXID
> > and not PHY_INTERFACE_MODE_RGMII.
> >
> > Fixing this allows RGMII PHY drivers to do the right thing (enable
> > RX delay in the PHY) instead of erroneously enabling both delays in the
> > PHY.
>
> Hi Tim
>
> This seems correct. But how has it worked in the past? Does this
> suggest there is PHY driver out there which is doing the wrong thing
> when passed PHY_INTERFACE_MODE_RGMII?
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>

Andrew,

Yes, the DP83867 phy driver used on the Gateworks Newport boards would
configure the delay in an incompatible way when enabled.

Tim
