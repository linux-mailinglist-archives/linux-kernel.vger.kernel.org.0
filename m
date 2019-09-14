Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 980EAB2A59
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 09:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfINHuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Sep 2019 03:50:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:35640 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfINHuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 03:50:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9E15E378;
        Sat, 14 Sep 2019 07:50:22 +0000 (UTC)
Date:   Sat, 14 Sep 2019 01:50:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        kernel@collabora.com, krisman@collabora.com
Subject: Re: [PATCH v2 4/4] coding-style: add explanation about pr_fmt macro
Message-ID: <20190914015018.4fa90f28@lwn.net>
In-Reply-To: <20190913220300.422869-5-andrealmeid@collabora.com>
References: <20190913220300.422869-1-andrealmeid@collabora.com>
        <20190913220300.422869-5-andrealmeid@collabora.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2019 19:03:00 -0300
André Almeida <andrealmeid@collabora.com> wrote:

> The pr_fmt macro is useful to format log messages printed by pr_XXXX()
> functions. Add text to explain the purpose of it, how to use and an
> example.

So I've finally had a chance to take a real look at this...

> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index f4a2198187f9..1a33a933fbd3 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -819,7 +819,15 @@ which you should use to make sure messages are matched to the right device
>  and driver, and are tagged with the right level:  dev_err(), dev_warn(),
>  dev_info(), and so forth.  For messages that aren't associated with a
>  particular device, <linux/printk.h> defines pr_notice(), pr_info(),
> -pr_warn(), pr_err(), etc.
> +pr_warn(), pr_err(), etc. It's possible to format pr_XXX() messages using the
> +macro pr_fmt() to prevent rewriting the style of messages. It should be
> +defined before ``#include <linux/kernel.h>``, to avoid compiler warning about
> +redefinitions, or just use ``#undef pr_fmt``. This is particularly useful for
> +adding the name of the module at the beginning of the message, for instance:
> +
> +.. code-block:: c
> +
> +        #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Honestly, I think that this is out of scope for a document on coding
style.  That document is already far too long for most people to read, I
don't think we should load it down with more stuff that isn't directly
style related.

That said, the information can be useful.  I wanted to say that it should
go with the documentation of the pr_* macros but ... well ... um ... we
don't seem to have a whole lot of that.  Figures.

I suspect this is more than you wanted to sign up for, but...IMO, the right
thing to do is to fill printk.h with a nice set of kerneldoc comments
describing how this stuff should be used, then to pull that information
into the core-api manual, somewhere near our extensive discussion of printk
formats.  It's amazing that we lack docs for something so basic.

Thanks,

jon
