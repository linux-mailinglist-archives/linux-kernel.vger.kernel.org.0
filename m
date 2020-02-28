Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7EF17432D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 00:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgB1Xdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 18:33:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36504 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB1Xdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:33:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so5215312ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkOrGQTUil2jVBBDqFqKrlwpeqHUXILYxK5e31tvxS0=;
        b=jgpmxZ9fGsCQjwNW/xYZU8NzhYJJRQsRKUYM60FMiBWYpPSsA7yiWqy2cNQkzN6eMn
         1dvuYUIwF+XcZvWePefIMwMv/yGaE/mALxU/IQ5K74qLNwittf9Rx8wYiHQA8BYMvz3P
         xeebvZyWyYsSE6tTbgxclyjnPm92OscKGM6g8pLz8T1eXbaHkxG2RR+x0Sjb6FrZXKe4
         gJ3/p62lkJV/+eUgMnbkrxPoKaKzyrrBSx55VoFnx9K/tywC/s1NU6eAtdGg3PIY5d8k
         s7or8Wbym9H0j3o8BbmZURm+e9xD9cNkQFBtD0UTkC4dVqrErAH2fDnaSqWXZ3hvIJ+V
         s77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkOrGQTUil2jVBBDqFqKrlwpeqHUXILYxK5e31tvxS0=;
        b=FnvJHDm5tDHqvVEDUdho+rTOYKnzJzMYgJbBI3Ss7t48NYjR+jXoc27jHACft8phLW
         MLtylpy+7IZ8mt06olAcE21EVXePIKPyeuFxBUMUfj93i9tPtLDdRR9l1IswEMGXSXlt
         /RhUGVGB8SgyYW4hE1jlWxV37GcBBS88vcuf4Ix+ipvC6NXfkta1OatBDpFG6AnY37No
         blK4/HVHrzI8vzT4a/rv6WG6ESQCI0PAiTXIRVcmbspd9Q3ZCO4/ejqXFuo6E305q4kC
         eT/XYkUe54wBzJfsuOYLQEB553qGtTsc8cT/XXG/7PBke+cuNYiMqWnmVU+oDJNu1kEF
         H1DA==
X-Gm-Message-State: ANhLgQ0IswquvVLdw4ExYe4FhGsssOj097o9K3hqtGgfk8xCcW90I/DW
        MRqrvhT78oh1P79uaInR7Cz5EAjbi/7wyiSF47ODrpJn
X-Google-Smtp-Source: ADFU+vseh+q+xB7V/6baLcFSo2HlPLM1fgbxWyxaT5jZNfkfHPqWAPnupzICk6ekXwCKX2Bh6JPOGDJ3BbU5Mc+I5Kk=
X-Received: by 2002:a05:651c:2c7:: with SMTP id f7mr4259493ljo.125.1582932820144;
 Fri, 28 Feb 2020 15:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20200228154142.13860-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20200228154142.13860-1-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 29 Feb 2020 00:33:29 +0100
Message-ID: <CACRpkdYF5y7jYCczEkdLuECfiJNdp92xafgq1-GV-N2aF=3phA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: core: Remove extra kref_get which blocks hogs
 being freed
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     ext Tony Lindgren <tony@atomide.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 4:41 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> kref_init starts with the reference count at 1, which will be balanced
> by the pinctrl_put in pinctrl_unregister. The additional kref_get in
> pinctrl_claim_hogs will increase this count to 2 and cause the hogs to
> not get freed when pinctrl_unregister is called.
>
> Fixes: 6118714275f0 ("pinctrl: core: Fix pinctrl_register_and_init() with pinctrl_enable()")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Patch applied for fixes.

Yours,
Linus Walleij
