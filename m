Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E35D130BDE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 02:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgAFBqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 20:46:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37689 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgAFBqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:46:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so35363835lfc.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 17:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cBUgTPb89F+0Xgjc2bYmszGmbAUBQT8GVtHX+HgXxYg=;
        b=Zi/zZ1RSWPDHW4MGNn3zhptY3SIZyBaTIhgbYtlcFoQ6b/+Exu36QqDt6QJAAlMtuL
         PAw3PvWZoNzskddA90QLwJ05LAHuaNQzyblxjhIFvpT0TmD0Y6qoiuCEmWgWn0h8ZUze
         6KmJzd9EHjT9gpgID/Lx/7UyU0V05RhqRIe9hYb2PLybZg9xsYlJARgvdsSFyGxl2Ur4
         tLCy8Vz2LlHSBPwpewDcdNI8BI9mVMfmzUgZ9wgMLszh2OVtOFxTrXoODyd5aRNQ76nN
         npunbSuUqTckNmxVRLW33zzoyI2T667Drsw/qY8jeY46d5II/DLhai8YrAAPV2vhvoR3
         4pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBUgTPb89F+0Xgjc2bYmszGmbAUBQT8GVtHX+HgXxYg=;
        b=pTBone4FDuRBhz3TodqfCutxdjYPR8JrIyhXM+ysv/vHjJjdbTnwmudFhc+DLyjF7y
         gIepxam5jcS0fYXbGSaXUej1UazxHamy93N+hcLBhdodIzOtPgeZSJ2fuNl/L6m9X5XN
         DJaW7PtNMfhO0QG8trxfHm/x9WZKojcahSkEWkaGoTZLX66CInHLyHEBG8xe3+1tzIsP
         hyZw4OjbflDvl0xfCtWEqdi2BKgLNeVVoMlBUm/2h1DyA2BCrKqDGFC22KINtHuJkEwE
         SgbXwNNx+C2NnELMZ4Pe12YpbyNOMTH8sFAtfpO+l+8CtqJW0k+rhlVcqUrhg7yh9NtP
         d1Pw==
X-Gm-Message-State: APjAAAW0foVDrlbn5LleHPXxbHANU84XmYGE42z36Mmumw26OtsOhTFY
        oJvmWtHv8S339pl9PLQEOpP9yYfryBoMzyA0BOZgSg==
X-Google-Smtp-Source: APXvYqyYC/pOkPUPX49HfCOe8pIi/7RiUp78ieHupatukpmA4+EBSle3tUienxjhbZjK1FVDssCxXscRiMC1SmeP4z0=
X-Received: by 2002:ac2:55a8:: with SMTP id y8mr54853667lfg.117.1578275164250;
 Sun, 05 Jan 2020 17:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20200102233445.12764-1-f.fainelli@gmail.com>
In-Reply-To: <20200102233445.12764-1-f.fainelli@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Jan 2020 02:45:52 +0100
Message-ID: <CACRpkdZdgExGX33=CKhZe3EwLV_PoJ=BSkH91DGAK_JQF4tJKA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: vsc73xx: Remove dependency on CONFIG_OF
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev <netdev@vger.kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 12:34 AM Florian Fainelli <f.fainelli@gmail.com> wrote:

> There is no build time dependency on CONFIG_OF, but we do need to make
> sure we gate the initialization of the gpio_chip::of_node member with a
> proper check on CONFIG_OF_GPIO. This enables the driver to build on
> platforms that do not have CONFIG_OF enabled.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

It's nice if some non-DT users need to use this driver, like
some board file. Thanks!

Yours,
Linus Walleij
