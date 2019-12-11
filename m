Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C964711AD6C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 15:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfLKO12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 09:27:28 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37179 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbfLKO12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:27:28 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so22835194ioc.4;
        Wed, 11 Dec 2019 06:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Faypt5jJbaNtCoHXofsWRZ8YINuZgK4fs840LJrVspY=;
        b=Z2KBVcOsCkR47+VmQPOkiHjj7vFKRPOwy8osTvnKM5r/Tg62TU0sG4hmG5auAO9PZe
         mT3KzbzHQZKrbW7H1sBHn51ECGZQXzKZ6DswDgLHURVFuKGX0g7bBcZnzTtUZYNkvZ8x
         QXSt91qZVnoaJYMbx7l7ka77oIwQHZygkf3v1c3dyplmmWAEnvf4xeHjhaFvYq3UI38b
         gCSLKK8Kg220Qm1z/EFRy0ZgQ6rwpu+IfjUWOhxaOFdVBfZoQ01vbMst+Vb0yFXnLBjW
         eJQx6reBYP4mBhH+XKM3CdRjGPxu05kHF2l4cRFsA5M47SwLRxr36WDyLnhB+dhQb7vU
         aIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Faypt5jJbaNtCoHXofsWRZ8YINuZgK4fs840LJrVspY=;
        b=TGMl6gLfTKBFr8HVUqjAj6f+W2dL7d0BEYhFyATDIXWcutugEFjTxpxFrR0zIN0qcG
         +/tzFX4Lsn9eP47nlfsBofjrg/Gl025I3qTYeLLcZgdIMPekFA7T+GWxlWB7PQnX+o+U
         czLMzM0jUSKnmi7opYRSWZtv30YZguWFb9Z7HQar5hs8GLwSwTBXwsMWXqTRT7xsJX6P
         dNGJmjpBenK/V2a/dxc9HdAeRGcVMgtZUf/EY0fkg2P32hPiLsILuyX0u9tKpKcU+A+p
         yPk/ditykfuMHnImhkYUOfqBwdnRXJd0NwCJ/rV2XLbmkox3HGOhavycjJevrT57m6lc
         AEig==
X-Gm-Message-State: APjAAAXsIQwty6Hem9W7qwHYV60ma0ZTnyQmzZ36ZSMFxDEmVsq0rxlF
        TKrMPf7Lqa7VQjn7X923NDGQPDcQgeAhyhLTyss=
X-Google-Smtp-Source: APXvYqx25zJakF+83vcjU/NrLZyb4Iyh7/msBEZNeWy88VfcZLcy4mMeUD6cBebcI8aP42hW4L9Hbh1Z30BrvhjsLXQ=
X-Received: by 2002:a6b:c9ca:: with SMTP id z193mr2766932iof.276.1576074446612;
 Wed, 11 Dec 2019 06:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20191130225153.30111-1-aford173@gmail.com> <e8e429dd-4508-9835-fd01-825d2de8871e@kontron.de>
 <CAHCN7xLkV1WC=9ACj1Mi8+uE8kRCEjCEe+Y36pXwkNeNrgrNVg@mail.gmail.com>
 <VI1PR0402MB34857B8C5560B912B34674AB985B0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <d82428e3-326b-db80-2e40-4ef1bdbca060@kontron.de>
In-Reply-To: <d82428e3-326b-db80-2e40-4ef1bdbca060@kontron.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 11 Dec 2019 08:27:16 -0600
Message-ID: <CAHCN7xKUSQQeGt984L9FXmXw7XFMqUvR+9RFqn-zv9q-zQdSSg@mail.gmail.com>
Subject: Re: [PATCH 1/2] crypto: caam: Change the i.MX8MQ check support all
 i.MX8M variants
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 8:23 AM Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:
>
> On 10.12.19 08:56, Horia Geanta wrote:
> > On 12/6/2019 9:55 PM, Adam Ford wrote:
> >> On Wed, Dec 4, 2019 at 5:38 AM Schrempf Frieder
> >> <frieder.schrempf@kontron.de> wrote:
> >>>
> >>> Hi Adam,
> >>>
> >>> On 30.11.19 23:51, Adam Ford wrote:
> >>>> The i.MX8M Mini uses the same crypto engine as the i.MX8MQ, but
> >>>> the driver is restricting the check to just the i.MX8MQ.
> >>>>
> >>>> This patch lets the driver support all i.MX8M Variants if enabled.
> >>>>
> >>>> Signed-off-by: Adam Ford <aford173@gmail.com>
> >>>
> >>> What about the following lines in run_descriptor_deco0()? Does this
> >>> condition also apply to i.MX8MM?
> >>
> >> I think that's a question for NXP.  I am not seeing that in the NXP
> >> Linux Release, and I don't have an 8MQ to compare.
> >>
> > IIRC the i.MX BSP releases use the JRI for initializing the RNG,
> > and not the DECO register interface.
> >
> >> I was able to get the driver working on the i.MXMM with the patch.
> >>
> > You are probably using a newer U-boot, which includes
> > commit dfaec76029f2 ("crypto/fsl: instantiate all rng state handles")
> >
> >> NXP  Team,
> >>
> >> Do you have any opinions on this?
> >>
> > Since current U-boot initializes both RNG state handles, practically
> > instantiate_rng() is a no-op.
> >
> > A simple experiment is to "lie" about the state_handle_mask, to exercise
> > the DECO acquire code (or, as mentioned above, to run with an older U-boot):
> >
> > @@ -268,12 +272,19 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
> >          struct caam_ctrl __iomem *ctrl;
> >          u32 *desc, status = 0, rdsta_val;
> >          int ret = 0, sh_idx;
> > +       static int force_init = 1;
> >
> >          ctrl = (struct caam_ctrl __iomem *)ctrlpriv->ctrl;
> >          desc = kmalloc(CAAM_CMD_SZ * 7, GFP_KERNEL);
> >          if (!desc)
> >                  return -ENOMEM;
> >
> > +       if (force_init && (state_handle_mask == 0x3)) {
> > +               dev_err(ctrldev, "Forcing reinit of RNG state handle 0!\n");
> > +               force_init = 0;
> > +               state_handle_mask = 0x2;
> > +       }
> > +
> >          for (sh_idx = 0; sh_idx < RNG4_MAX_HANDLES; sh_idx++) {
> >                  /*
> >                   * If the corresponding bit is set, this state handle
> >
> > In this case boot log confirms the DECO cannot be acquired:
> > [    2.137101] caam 30900000.crypto: Forcing reinit of RNG state handle 0!
> > [    2.172293] caam 30900000.crypto: failed to acquire DECO 0
> > [    2.177786] caam 30900000.crypto: failed to instantiate RNG
> >
> > To sum up, writing to DECORSR is mandatory.
>
> Thanks Horia for providing the details.

I appreciate it too.

>
> Adam, can you update your patch to enable the code in
> run_descriptor_deco0() for i.MX8MM?

I will work on that.  I have been trying to get the mainline U-Boot to
start correctly, because I wanted to see if/how this interacted. I'll
try to get a V2 pushed today.

>
> If I understand this correctly, this is necessary to have the RNG
> initialize correctly no matter what version of U-Boot is used.

That makes sense based on Horia's feedback.  With the holidays this
month, my spare time and weekends have been full.

adam
>
> Thanks,
> Frieder
