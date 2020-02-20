Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16DF016678B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 20:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgBTTwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 14:52:05 -0500
Received: from muru.com ([72.249.23.125]:56502 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgBTTwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:52:05 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 133708080;
        Thu, 20 Feb 2020 19:52:49 +0000 (UTC)
Date:   Thu, 20 Feb 2020 11:52:02 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mfd: motmdm: Add Motorola TS 27.010 serdev modem
 driver for droid4
Message-ID: <20200220195202.GV37466@atomide.com>
References: <20200219170106.38543-1-tony@atomide.com>
 <20200219170106.38543-3-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219170106.38543-3-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [700101 00:00]:
> +static int motmdm_register_dlci(struct device *dev,
> +				struct motmdm_dlci *mot_dlci)
> +{
> +	struct motmdm *ddata;
> +	struct gsm_serdev *gsd;
> +	struct gsm_serdev_dlci *gsm_dlci;
> +	int err;
> +
> +	if (!dev || !mot_dlci || !mot_dlci->line)
> +		return -EINVAL;
> +
> +	err = pm_runtime_get_sync(dev);
> +	if ((err != -EINPROGRESS) && err < 0) {
> +		pm_runtime_put_noidle(dev);
> +
> +		return err;
> +	}
> +
> +	ddata = gsm_serdev_get_drvdata(dev);
> +	gsd = &ddata->gsd;
> +	gsm_dlci = &mot_dlci->gsm_dlci;
> +	INIT_LIST_HEAD(&mot_dlci->list);
> +	init_waitqueue_head(&mot_dlci->read_queue);
> +	gsm_dlci->line = mot_dlci->line;
> +	gsm_dlci->receive_buf = motmdm_dlci_receive_buf;
> +
> +	err = gsm_serdev_register_dlci(gsd, gsm_dlci);
> +	if (err) {
> +		dev_warn(dev, "error registering dlci%i: %i\n",
> +			 mot_dlci->line, err);
> +		kfifo_free(&mot_dlci->read_fifo);
> +		memset(gsm_dlci, 0, sizeof(*gsm_dlci));
> +	} else {
> +		mot_dlci->privdata = ddata;
> +	}

Here we want mot_dlci->privdata initialized before
gsm_serdev_register_dlci, otherwise we may get an interrupt
between gsm_serdev_register_dlci and setting mot_dlci->privdata.

So I'll be sending out v4 series.

Regards,

Tony
