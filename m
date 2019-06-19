Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB6C4B9B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfFSNVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 09:21:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36500 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFSNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:21:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so3254887ljj.3;
        Wed, 19 Jun 2019 06:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g18058N/C2pjcBGgjgbat4LbXOhva175NVhezQY00XQ=;
        b=tjPmzkP70fAsA26NOsSJclg4L+TUZI/ysTww8TpmgX4bSxFk0ASk0tUeVxZuNORPdX
         CaTllXz7jbARzX1I+8qPEuPUZEOsjB+KDB3Jb+fLCml0fPsBUa/FuOxzBwydfY2JK1Kp
         r0PZhb5pEycAT29k5T34UFbUu18o+yFJN9b4J52B+vPAdP0nKwcLyrjY7GjDMTFsycmT
         N9GdVXdkfxSFregeODQs8CG4BXAH6S4P610UDPJvTkt+UbskAb69T4eA/Df8KacxurAF
         dDgMS2W8C2xv7HdoziJtd0uFWbPc1TJnRsgByjPlGasOqZiTdNTyIhJ51E1YWvH8+B2z
         TEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g18058N/C2pjcBGgjgbat4LbXOhva175NVhezQY00XQ=;
        b=jkoV5sI/8R/qokOYvkk/VM0KcoqRvgS8fFW2OfJEdVWeeeM3xRtgaKugCwqXkcOKX3
         oLCz/csOZFw5XirBopbdeOz8MIbIX/xI7osv1BYsjbDpQqK6E2uctcKZjhQqS+5uh2wF
         aN3Vp267d4SJOrHF4mF5d4TJLqeTh7vIGXQecoFPaS5bx18y/vPryhE7iq47vY2cR0ln
         PZD2vbLoCjWxDMTHw4JDLSxVYg5ZZzEEoxU9uGBkOJ+pbNad/IkIF2SvQl5qLqT0HB28
         HJNiGRxETSetMye2UxijsYEDio2nURPB8VAJX/ITJoX2bEegCP1VjNJzA4c+yooIgjb5
         PIqA==
X-Gm-Message-State: APjAAAXYYBtZMBoddQj3Ue+tbit5NCdiQO/vU47uK/Gia61j+FVOiSbU
        /GJKMJijxjADC6i75ehEAndksUEwQKU+cZj+BF8=
X-Google-Smtp-Source: APXvYqyAMgmk6ys/VsOTesM/6z0KH2z75G1WFcyJbVadMJ+QdScEq8u41WtyiImcwlE2f5Aw7kaHsoWTLJ1vAaQzsSs=
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr26636418ljs.44.1560950476875;
 Wed, 19 Jun 2019 06:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <1560864646-1468-1-git-send-email-robert.chiras@nxp.com> <1560864646-1468-2-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1560864646-1468-2-git-send-email-robert.chiras@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Jun 2019 10:21:29 -0300
Message-ID: <CAOMZO5DwwL5+V4Eifskk=pKzpceRmk5bvdXNeCzZfU3jVwEhEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add support for
 Raydium RM67191 panel
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Tue, Jun 18, 2019 at 10:33 AM Robert Chiras <robert.chiras@nxp.com> wrote:

> +Optional properties:
> +- reset-gpios:         a GPIO spec for the RST_B GPIO pin
> +- pinctrl-0            phandle to the pin settings for the reset pin
> +- width-mm:            physical panel width [mm]
> +- height-mm:           physical panel height [mm]
> +- display-timings:     timings for the connected panel according to [1]

Still not convinced we need the 'display-timings' property, even as an
optional property. My understanding is that passing display timings in
the devicetree is not encouraged.

Last time you said you need to pass ''display-timings' to workaround
the problem of connecting this panel to mx8m DCSS or eLCDIF.

The panel timings come from the LCD manufacturer and it is agnostic to
what display controller interface it is connected to.

So I suggest making sure the timings passed in the driver are correct
as per the vendor datasheet. If they are correct and one specific
interface is not able to drive it, then probably it is a bug in this
specific display controller interface or in the SoC clock driver.
