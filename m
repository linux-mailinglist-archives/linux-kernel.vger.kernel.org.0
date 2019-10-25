Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A938E42B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 06:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392647AbfJYEwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 00:52:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36706 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732606AbfJYEwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 00:52:04 -0400
Received: by mail-lf1-f67.google.com with SMTP id u16so599166lfq.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 21:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmH4co9M+ZSsgCt8IZXd3+esyhYdCc0EXhkw0YqcSCs=;
        b=G1L77h5L6Hu8ngA1fW2Hs+AazniThA9Zqssrirkcm/tG7cam7B2ULQrQky8ApcCjQf
         BYDSeBr3KPlxNVkqMFhhcGM24x/rqgchiQZZ2AE9GRILdUzB+gC8f0/+PWXe+ATVR23O
         EVg6zZ4nQ/gWPmFKj1nG5S9NTbZuiQ0rQj7bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmH4co9M+ZSsgCt8IZXd3+esyhYdCc0EXhkw0YqcSCs=;
        b=UP8BRUgda2wCRinXn8skEHZraz8pEudEE0+gdDzzpBOeQI1lh0zBKz4Y2eJLPV7KoZ
         m48RCn/XSu/4lfIURtWN7I31iPfnfqDCilxvqbQkisrpIW9XGS+jcSCPXCj0ecJ8NZU1
         t4puEjgGLaBsjS4GH3UYuBErkpuupKRJFc70UcFx89IIxkE9npGNlMptxGDA7mkxDuUx
         nGSTs/xeS1/n8hHqxYnMs0HHWEld3V59BLHSIwnt/y3IT5DhxizaRx5NSZaW4KH8pYVY
         rsukdQTVg9kL3l0bouRYCyelL01xTjX+0suyU01wWH2WRkGejdf9xwFquHzlBbGMyklx
         /4nw==
X-Gm-Message-State: APjAAAXSW5x1uI0bJwMvAG4lnYjUOzdFwKvsuOVcT/yBrCGPo1v46w/W
        qKH3aZx3ced+mdBQyyLbAVArzmG1eMeN4c0s+OWumA==
X-Google-Smtp-Source: APXvYqyzvCADhCjLC3w+Kn5bN11jVlzo8YcU37wvGQvuo5kjy90lV4V+CZGv0RYVRJMOcXh1iwgKckj0ufBBjYpHf9Q=
X-Received: by 2002:ac2:4c38:: with SMTP id u24mr990839lfq.45.1571979122321;
 Thu, 24 Oct 2019 21:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <1569825869-30640-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <20191024185540.GF1870@kunai>
In-Reply-To: <20191024185540.GF1870@kunai>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Fri, 25 Oct 2019 10:21:51 +0530
Message-ID: <CAHO=5PGCZxBmbJ3rXM5WVLcRF3FecaLYFa7Rx3W=FeikpDHfuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] i2c: iproc: Add i2c repeated start capability
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Michael Cheng <ccheng@broadcom.com>,
        Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>,
        Lori Hikichi <lori.hikichi@broadcom.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Icarus Chau <icarus.chau@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Shivaraj Shetty <sshetty1@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 12:25 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Mon, Sep 30, 2019 at 12:14:29PM +0530, Rayagonda Kokatanur wrote:
> > From: Lori Hikichi <lori.hikichi@broadcom.com>
> >
> > Enable handling of i2c repeated start. The current code
> > handles a multi msg i2c transfer as separate i2c bus
> > transactions. This change will now handle this case
> > using the i2c repeated start protocol. The number of msgs
> > in a transfer is limited to two, and must be a write
> > followed by a read.
> >
> > Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
> > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > Signed-off-by: Icarus Chau <icarus.chau@broadcom.com>
> > Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> > Signed-off-by: Shivaraj Shetty <sshetty1@broadcom.com>
>
> Patch looks good but doesn't apply for me on top of v5.4-rc4? What was
> your base?
>
> Also, I will apply it to for-next (v5.5). If you want it for v5.4, then
> please add a Fixes tag.
>
thank you, please apply it to for-next (v5.5).
Do I need to resend patch again for you to apply it to v5.5 ?
