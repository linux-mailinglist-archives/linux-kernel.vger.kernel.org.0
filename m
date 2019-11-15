Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2602DFE19F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 16:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfKOPim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 10:38:42 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:54192 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727540AbfKOPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:38:41 -0500
Received: (qmail 1740 invoked by uid 2102); 15 Nov 2019 10:38:40 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Nov 2019 10:38:40 -0500
Date:   Fri, 15 Nov 2019 10:38:40 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     linux-usb@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Felipe Balbi <balbi@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v2 1/1] usb: gadget: add raw-gadget interface
In-Reply-To: <92f5a2a1ba986f149aecec02d6ffe110d11dcdfd.1573824989.git.andreyknvl@google.com>
Message-ID: <Pine.LNX.4.44L0.1911151036310.1527-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019, Andrey Konovalov wrote:

> USB Raw Gadget is a kernel module that provides a userspace interface for
> the USB Gadget subsystem. Essentially it allows to emulate USB devices
> from userspace. Enabled with CONFIG_USB_RAW_GADGET. Raw Gadget is
> currently a strictly debugging feature and shouldn't be used in
> production.
> 
> Raw Gadget is similar to GadgetFS, but provides a more low-level and
> direct access to the USB Gadget layer for the userspace. The key
> differences are:
> 
> 1. Every USB request is passed to the userspace to get a response, while
>    GadgetFS responds to some USB requests internally based on the provided
>    descriptors. However note, that the UDC driver might respond to some
>    requests on its own and never forward them to the Gadget layer.
> 
> 2. GadgetFS performs some sanity checks on the provided USB descriptors,
>    while Raw Gadget allows you to provide arbitrary data as responses to
>    USB requests.
> 
> 3. Raw Gadget provides a way to select a UDC device/driver to bind to,
>    while GadgetFS currently binds to the first available UDC.
> 
> 4. Raw Gadget uses predictable endpoint names (handles) across different
>    UDCs (as long as UDCs have enough endpoints of each required transfer
>    type).
> 
> 5. Raw Gadget has ioctl-based interface instead of a filesystem-based one.

...

> --- /dev/null
> +++ b/Documentation/usb/raw-gadget.rst

> +Userspace interface
> +~~~~~~~~~~~~~~~~~~~
> +
> +To create a Raw Gadget instance open /sys/kernel/debug/usb/raw-gadget
> +(debugfs should be enabled and mounted). Multiple raw-gadget instances

Looks like the documentation hasn't kept up with the more recent 
changes to the driver.

> --- /dev/null
> +++ b/drivers/usb/gadget/legacy/raw.c
> @@ -0,0 +1,1057 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * USB Raw Gadget driver.
> + * See Documentation/usb/raw-gadget.rst for more details.
> + *
> + * Andrey Konovalov <andreyknvl@gmail.com>
> + */
> +
> +#define pr_fmt(fmt) "raw: %s: " fmt, __func__

This macro isn't used anywhere now.

Alan Stern

