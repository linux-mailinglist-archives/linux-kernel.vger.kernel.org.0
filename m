Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30DA63554
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 14:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfGIMCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 08:02:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43579 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfGIMCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:02:55 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hkopX-0002Pm-WB; Tue, 09 Jul 2019 14:02:44 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hkopV-0000bc-V9; Tue, 09 Jul 2019 14:02:41 +0200
Date:   Tue, 9 Jul 2019 14:02:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] firmware: imx: Add DSP IPC protocol interface
Message-ID: <20190709120241.nlzy7o6etucn5udk@pengutronix.de>
References: <20190627081205.22065-1-daniel.baluta@nxp.com>
 <20190627081205.22065-2-daniel.baluta@nxp.com>
 <CAEnQRZAGTdMpsnH-F_Xoaae0+nX8WTqYOrMJUjeQ6vhWvZ1y1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZAGTdMpsnH-F_Xoaae0+nX8WTqYOrMJUjeQ6vhWvZ1y1Q@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:01:24 up 52 days, 18:19, 51 users,  load average: 0.42, 0.18,
 0.06
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 08:48:20AM +0300, Daniel Baluta wrote:
> Hi Oleksij,
> 
> Any comments on this?

Looks good for me. All my suggestions was fixed.

Reviewed-by: <o.rempel@pengutronix.de>

> On Thu, Jun 27, 2019 at 11:14 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >
> > Some of i.MX8 processors (e.g i.MX8QM, i.MX8QXP) contain
> > the Tensilica HiFi4 DSP for advanced pre- and post-audio
> > processing.
> >
> > The communication between Host CPU and DSP firmware is
> > taking place using a shared memory area for message passing
> > and a dedicated Messaging Unit for notifications.
> >
> > DSP IPC protocol driver offers a doorbell interface using
> > imx-mailbox API.
> >
> > We use 4 MU channels (2 x TXDB, 2 x RXDB) to implement a
> > request-reply protocol.
> >
> > Connection 0 (txdb0, rxdb0):
> >         - Host writes messasge to shared memory [SHMEM]
> >         - Host sends a request [MU]
> >         - DSP handles request [SHMEM]
> >         - DSP sends reply [MU]
> >
> > Connection 1 (txdb1, rxdb1):
> >         - DSP writes a message to shared memory [SHMEM]
> >         - DSP sends a request [MU]
> >         - Host handles request [SHMEM]
> >         - Host sends reply [MU]
> >
> > The protocol driver will be used by a Host client to
> > communicate with the DSP. First client will be the i.MX8
> > part from Sound Open Firmware infrastructure.
> >
> > The protocol drivers offers the following interface:
> >
> > On Tx:
> >    - imx_dsp_ring_doorbell, will be called to notify the DSP
> >    that it needs to handle a request.
> >
> > On Rx:
> >    - clients need to provide two callbacks:
> >         .handle_reply
> >         .handle_request
> >   - the callbacks will be used by the protocol driver on
> >     notification arrival from DSP.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  drivers/firmware/imx/Kconfig     |  11 +++
> >  drivers/firmware/imx/Makefile    |   1 +
> >  drivers/firmware/imx/imx-dsp.c   | 142 +++++++++++++++++++++++++++++++
> >  include/linux/firmware/imx/dsp.h |  67 +++++++++++++++
> >  4 files changed, 221 insertions(+)
> >  create mode 100644 drivers/firmware/imx/imx-dsp.c
> >  create mode 100644 include/linux/firmware/imx/dsp.h
> >
> > diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
> > index 42b566f8903f..ddb241708c31 100644
> > --- a/drivers/firmware/imx/Kconfig
> > +++ b/drivers/firmware/imx/Kconfig
> > @@ -1,4 +1,15 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +config IMX_DSP
> > +       bool "IMX DSP Protocol driver"
> > +       depends on IMX_MBOX
> > +       help
> > +         This enables DSP IPC protocol between host CPU (Linux)
> > +         and the firmware running on DSP.
> > +         DSP exists on some i.MX8 processors (e.g i.MX8QM, i.MX8QXP).
> > +
> > +         It acts like a doorbell. Client might use shared memory to
> > +         exchange information with DSP side.
> > +
> >  config IMX_SCU
> >         bool "IMX SCU Protocol driver"
> >         depends on IMX_MBOX
> > diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> > index 802c4ad8e8f9..08bc9ddfbdfb 100644
> > --- a/drivers/firmware/imx/Makefile
> > +++ b/drivers/firmware/imx/Makefile
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > +obj-$(CONFIG_IMX_DSP)          += imx-dsp.o
> >  obj-$(CONFIG_IMX_SCU)          += imx-scu.o misc.o imx-scu-irq.o
> >  obj-$(CONFIG_IMX_SCU_PD)       += scu-pd.o
> > diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
> > new file mode 100644
> > index 000000000000..c4d34a2fbff3
> > --- /dev/null
> > +++ b/drivers/firmware/imx/imx-dsp.c
> > @@ -0,0 +1,142 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2019 NXP
> > + *  Author: Daniel Baluta <daniel.baluta@nxp.com>
> > + *
> > + * Implementation of the DSP IPC interface (host side)
> > + */
> > +
> > +#include <linux/firmware/imx/dsp.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mailbox_client.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +/*
> > + * imx_dsp_ring_doorbell - triggers an interrupt on the other side (DSP)
> > + *
> > + * @dsp: DSP IPC handle
> > + * @chan_idx: index of the channel where to trigger the interrupt
> > + *
> > + * Returns non-negative value for success, negative value for error
> > + */
> > +int imx_dsp_ring_doorbell(struct imx_dsp_ipc *ipc, unsigned int idx)
> > +{
> > +       int ret;
> > +       struct imx_dsp_chan *dsp_chan;
> > +
> > +       if (idx >= DSP_MU_CHAN_NUM)
> > +               return -EINVAL;
> > +
> > +       dsp_chan = &ipc->chans[idx];
> > +       ret = mbox_send_message(dsp_chan->ch, NULL);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL(imx_dsp_ring_doorbell);
> > +
> > +/*
> > + * imx_dsp_handle_rx - rx callback used by imx mailbox
> > + *
> > + * @c: mbox client
> > + * @msg: message received
> > + *
> > + * Users of DSP IPC will need to privde handle_reply and handle_request
> > + * callbacks.
> > + */
> > +static void imx_dsp_handle_rx(struct mbox_client *c, void *msg)
> > +{
> > +       struct imx_dsp_chan *chan = container_of(c, struct imx_dsp_chan, cl);
> > +
> > +       if (chan->idx == 0) {
> > +               chan->ipc->ops->handle_reply(chan->ipc);
> > +       } else {
> > +               chan->ipc->ops->handle_request(chan->ipc);
> > +               imx_dsp_ring_doorbell(chan->ipc, 1);
> > +       }
> > +}
> > +
> > +static int imx_dsp_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct imx_dsp_ipc *dsp_ipc;
> > +       struct imx_dsp_chan *dsp_chan;
> > +       struct mbox_client *cl;
> > +       char *chan_name;
> > +       int ret;
> > +       int i, j;
> > +
> > +       dsp_ipc = devm_kzalloc(dev, sizeof(*dsp_ipc), GFP_KERNEL);
> > +       if (!dsp_ipc)
> > +               return -ENOMEM;
> > +
> > +       for (i = 0; i < DSP_MU_CHAN_NUM; i++) {
> > +               if (i < 2)
> > +                       chan_name = kasprintf(GFP_KERNEL, "txdb%d", i);
> > +               else
> > +                       chan_name = kasprintf(GFP_KERNEL, "rxdb%d", i - 2);
> > +
> > +               if (!chan_name)
> > +                       return -ENOMEM;
> > +
> > +               dsp_chan = &dsp_ipc->chans[i];
> > +               cl = &dsp_chan->cl;
> > +               cl->dev = dev;
> > +               cl->tx_block = false;
> > +               cl->knows_txdone = true;
> > +               cl->rx_callback = imx_dsp_handle_rx;
> > +
> > +               dsp_chan->ipc = dsp_ipc;
> > +               dsp_chan->idx = i % 2;
> > +               dsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
> > +               if (IS_ERR(dsp_chan->ch)) {
> > +                       ret = PTR_ERR(dsp_chan->ch);
> > +                       if (ret != -EPROBE_DEFER)
> > +                               dev_err(dev, "Failed to request mbox chan %s ret %d\n",
> > +                                       chan_name, ret);
> > +                       goto out;
> > +               }
> > +
> > +               dev_dbg(dev, "request mbox chan %s\n", chan_name);
> > +               /* chan_name is not used anymore by framework */
> > +               kfree(chan_name);
> > +       }
> > +
> > +       dsp_ipc->dev = dev;
> > +
> > +       dev_set_drvdata(dev, dsp_ipc);
> > +
> > +       dev_info(dev, "NXP i.MX DSP IPC initialized\n");
> > +
> > +       return devm_of_platform_populate(dev);
> > +out:
> > +       kfree(chan_name);
> > +       for (j = 0; j < i; j++) {
> > +               dsp_chan = &dsp_ipc->chans[j];
> > +               mbox_free_channel(dsp_chan->ch);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct of_device_id imx_dsp_match[] = {
> > +       { .compatible = "fsl,imx8qxp-dsp", },
> > +       { /* Sentinel */ }
> > +};
> > +
> > +static struct platform_driver imx_dsp_driver = {
> > +       .driver = {
> > +               .name = "imx-dsp",
> > +               .of_match_table = imx_dsp_match,
> > +       },
> > +       .probe = imx_dsp_probe,
> > +};
> > +builtin_platform_driver(imx_dsp_driver);
> > +
> > +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@nxp.com>");
> > +MODULE_DESCRIPTION("IMX DSP IPC protocol driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/firmware/imx/dsp.h b/include/linux/firmware/imx/dsp.h
> > new file mode 100644
> > index 000000000000..7562099c9e46
> > --- /dev/null
> > +++ b/include/linux/firmware/imx/dsp.h
> > @@ -0,0 +1,67 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2019 NXP
> > + *
> > + * Header file for the DSP IPC implementation
> > + */
> > +
> > +#ifndef _IMX_DSP_IPC_H
> > +#define _IMX_DSP_IPC_H
> > +
> > +#include <linux/device.h>
> > +#include <linux/types.h>
> > +#include <linux/mailbox_client.h>
> > +
> > +#define DSP_MU_CHAN_NUM                4
> > +
> > +struct imx_dsp_chan {
> > +       struct imx_dsp_ipc *ipc;
> > +       struct mbox_client cl;
> > +       struct mbox_chan *ch;
> > +       char *name;
> > +       int idx;
> > +};
> > +
> > +struct imx_dsp_ops {
> > +       void (*handle_reply)(struct imx_dsp_ipc *ipc);
> > +       void (*handle_request)(struct imx_dsp_ipc *ipc);
> > +};
> > +
> > +struct imx_dsp_ipc {
> > +       /* Host <-> DSP communication uses 2 txdb and 2 rxdb channels */
> > +       struct imx_dsp_chan chans[DSP_MU_CHAN_NUM];
> > +       struct device *dev;
> > +       struct imx_dsp_ops *ops;
> > +       void *private_data;
> > +};
> > +
> > +static inline void imx_dsp_set_data(struct imx_dsp_ipc *ipc, void *data)
> > +{
> > +       if (!ipc)
> > +               return;
> > +
> > +       ipc->private_data = data;
> > +}
> > +
> > +static inline void *imx_dsp_get_data(struct imx_dsp_ipc *ipc)
> > +{
> > +       if (!ipc)
> > +               return NULL;
> > +
> > +       return ipc->private_data;
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_IMX_DSP)
> > +
> > +int imx_dsp_ring_doorbell(struct imx_dsp_ipc *dsp, unsigned int chan_idx);
> > +
> > +#else
> > +
> > +static inline int imx_dsp_ring_doorbell(struct imx_dsp_ipc *ipc,
> > +                                       unsigned int chan_idx)
> > +{
> > +       return -ENOTSUPP;
> > +}
> > +
> > +#endif
> > +#endif /* _IMX_DSP_IPC_H */
> > --
> > 2.17.1
> >
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
