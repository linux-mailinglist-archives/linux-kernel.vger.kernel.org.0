Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7EB113E77
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 10:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfLEJpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 04:45:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52396 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfLEJpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:45:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so2881241wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 01:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IAHAPcfNyYPZewTfBhsG7qwba+YQCk2356CRIqll3K8=;
        b=A/uquqn7fzUQpqmYGO+PEXKF1NoPRxYMZ0y2sW+aDKN2NiVkv7K16K/R63JFJt3fdo
         PAqzhlml/ixjVKxynF0FGEbQBpjyn/orMffUA7RtohOKEsDFu0I2e/m4o3RSxCMcHRPl
         WxFBf9N9tp3la/OS19JL1VNiHJKI3y4h+yBPMpEsRQkJuXKF10bWuSYlx8+xHkw3mGwu
         CgsV630jVK1HXVfmmOrNxjhvEIF/6CNZuTECWJ6ux4arJzFKOk9C+ztBFKrFZ5gFiQkG
         qHjrP2okiVzBNHwpyOOJH+7tZvfC46DiMArQ1geFD4nelFOWtjAoXRxpDUIjaPrhLngI
         kI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAHAPcfNyYPZewTfBhsG7qwba+YQCk2356CRIqll3K8=;
        b=Mjw//Wz0a4Gr0BPMk8uVtx/2tud0sYvHCko4j0HBSgoomPg6QzBScdUK2/e2cqJVYT
         nq/iqEKRhInevEdulPMc9ELE8NDTqtzRQZUdcH5Gc0uH64TR+JgpnNPE5Fe3TevOWv5m
         3hxiQaIL+AZjYjKNhj/nzmrGPxAxRRuXLs5fwOLXGhLDtm4sbjNOySy5Urx27FbZfuCu
         hJyEfy1PXPBqumHCVXjTyfvSexrqBqoJ1JCOXLrNuqTxFTJUMaMFBry3ozuAkn5jU727
         APwRsKOPxb2+HhMUduulElE4rCEIfMmiXFl2nLA6MD8MFwiWjgU70plqPQvsAnxRCfug
         Cbzg==
X-Gm-Message-State: APjAAAXF0rzgzJxpLNwiEA1RHVy5d/QWgfXGlWRxZh1FdiGCDhp1mzY1
        kTBr38YQMQVpha3H1IWwnGagMiKlbHjIB6VLKQw=
X-Google-Smtp-Source: APXvYqwcYRc0fuaLRFVleqfgSmiyl3I2fPNK6AKFa5K8/dfNSEFtx+axt8WpebIoZlIVYXmSl6OmkUOLn9wJyytUYes=
X-Received: by 2002:a1c:4944:: with SMTP id w65mr4047032wma.39.1575539141872;
 Thu, 05 Dec 2019 01:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20191128223802.18228-1-michael@walle.cc> <CAEnQRZCnQAUVowOJw5aPe9rYWU5DKR4bFbmQLYV2BzYqOhRJmQ@mail.gmail.com>
 <a5accae02f840f7e25099c2ccd7b02ff@walle.cc>
In-Reply-To: <a5accae02f840f7e25099c2ccd7b02ff@walle.cc>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 5 Dec 2019 11:45:30 +0200
Message-ID: <CAEnQRZBm2=BrQ2VQW6ZNYSshNi_90-RdHKCYbtXi0=u3oxG3SA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: add IRQF_SHARED
To:     Michael Walle <michael@walle.cc>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 11:18 AM Michael Walle <michael@walle.cc> wrote:
>
> Hi Daniel,
>
> Am 2019-12-05 09:43, schrieb Daniel Baluta:
> > On Fri, Nov 29, 2019 at 12:40 AM Michael Walle <michael@walle.cc>
> > wrote:
> >>
> >> The LS1028A SoC uses the same interrupt line for adjacent SAIs. Use
> >> IRQF_SHARED to be able to use these SAIs simultaneously.
> >
> > Hi Michael,
> >
> > Thanks for the patch. We have a similar change inside our internal tree
> > (it is on my long TODO list to upstream :D).
> >
> > We add the shared flag conditionally on a dts property.
> >
> > Do you think it is a good idea to always add shared flag? I'm thinking
> > on SAI IP integrations where the interrupt is edge triggered.
>
> Mhh, I don't really get the point to make the flag conditionally. If
> there is only one user, the flag won't hurt, correct?
>
> If there are two users, we need the flag anyway.
>
> > AFAIK edge triggered interrupts do not get along very well
> > with sharing an interrupt line.
>
> So in that case you shouldn't use shared edge triggered interrupts in
> the
> SoC in the first place, I guess.

I think you make a good point. I was thinking that it would hurt the single
user case. But it is fine.

Thanks for the patch.

Acked-by: Daniel Baluta <daniel.baluta@nxp.com>
