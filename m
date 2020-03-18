Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2999189DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 15:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCROXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 10:23:23 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37079 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgCROXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:23:23 -0400
Received: by mail-pj1-f68.google.com with SMTP id ca13so1279297pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/T6Y7h4lX7inlKg7h1ZYZmyzFUnZ0vGOlBmL/m1r4QI=;
        b=rNM5E8pI1J3xm47Ba8VqNjFoG2gnRO5BtbAPP4Ohc51ZQpqC34vJEMwFIVRd7PpfNr
         HbrZ2XBbTjhwgaDUCHmKrPxSAYrOHPq/mwn3DrplkCDUnOsx+LZTXpSWL1a51xRTGzt8
         JLl4ZWIsyKpKcJIv+JBr5heSZf8KPcqpldoUz7DUE5uMaOS6UhmYzfHd98NbaUkn2DnX
         IUALMKhIz5QyyzbvvzdfUALCGXrX9W8y3JyLy4HnfMQ9RRvTFSpo2VE4KiqCuyOgNqLV
         DRteSNqo1oHA6Bii9cXcGnwumMJ3SSsTzFoRKQ+K6J1sFmdHtHhTKXIZf660fx5Zhx4d
         zbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/T6Y7h4lX7inlKg7h1ZYZmyzFUnZ0vGOlBmL/m1r4QI=;
        b=RMy0XFYRZTZwCkcd+yIaP6WJfObsB13Q0FKKkvebdJ+1ZmCs2SlXtv3nkJxEBMUE+0
         Pgen9HzD26XYA8MDzCOpzon+dOj+uJ2WYTqDAP+6xajTlzGEJoP7/cQbGx8M09UEXt4H
         dSRhy0a4FsoDatK+P5bbDi2jIAUOJagJmaNRDXduLZ6p26pljm3esKWpemH8gfXNTxIv
         9yP03ZqrkvZzSlCSydmcVUZKVJ8+ry135l6zU3DlFJvxQDBFBacr1P5hYCGfy50OFNxf
         JTvOVBOubZP4JwdSt7wJnzobXtxdPi67dMzNXJTrBH9RXdr3IvEuGAjxlF31U86d9KE7
         KhYA==
X-Gm-Message-State: ANhLgQ0YDTutWnYTtWLMYTyH5Za5Ac4KnLMdtTDbw5E5is/OcpYVLoGl
        fn/+W+cVVt+oD87EQKLlK3TVxvmWgfOg
X-Google-Smtp-Source: ADFU+vtDszy0j7N2rzdI1e8yHt2dLBIdy2IO9X3/YRy65VX/2kEymarNolNavbXW/1wUQnyxj+ImFA==
X-Received: by 2002:a17:90b:30d3:: with SMTP id hi19mr4864232pjb.52.1584541401290;
        Wed, 18 Mar 2020 07:23:21 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:199:25eb:1005:91b8:c500:d4b4])
        by smtp.gmail.com with ESMTPSA id y22sm7130105pfr.68.2020.03.18.07.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 07:23:20 -0700 (PDT)
Date:   Wed, 18 Mar 2020 19:53:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>, arnd@arndb.de,
        smohanad@codeaurora.org, kvalo@codeaurora.org,
        bjorn.andersson@linaro.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/16] bus: mhi: core: Add support for registering MHI
 client drivers
Message-ID: <20200318142312.GA11494@Mani-XPS-13-9360>
References: <20200220095854.4804-1-manivannan.sadhasivam@linaro.org>
 <20200220095854.4804-4-manivannan.sadhasivam@linaro.org>
 <20200318133626.GA2801580@kroah.com>
 <db612e12-0033-31cc-60fc-62e45dda4342@codeaurora.org>
 <20200318140034.GA2805201@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318140034.GA2805201@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Mar 18, 2020 at 03:00:34PM +0100, Greg KH wrote:
> On Wed, Mar 18, 2020 at 07:54:30AM -0600, Jeffrey Hugo wrote:
> > On 3/18/2020 7:36 AM, Greg KH wrote:
> > > On Thu, Feb 20, 2020 at 03:28:41PM +0530, Manivannan Sadhasivam wrote:
> > > > This commit adds support for registering MHI client drivers with the
> > > > MHI stack. MHI client drivers binds to one or more MHI devices inorder
> > > > to sends and receive the upper-layer protocol packets like IP packets,
> > > > modem control messages, and diagnostics messages over MHI bus.
> > > > 
> > > > This is based on the patch submitted by Sujeev Dias:
> > > > https://lkml.org/lkml/2018/7/9/987
> > > > 
> > > > Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
> > > > Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > > > [mani: splitted and cleaned up for upstream]
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
> > > > Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
> > > > ---
> > > >   drivers/bus/mhi/core/init.c | 149 ++++++++++++++++++++++++++++++++++++
> > > >   include/linux/mhi.h         |  39 ++++++++++
> > > >   2 files changed, 188 insertions(+)
> > > > 
> > > > diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> > > > index 6f24c21284ec..12e386862b3f 100644
> > > > --- a/drivers/bus/mhi/core/init.c
> > > > +++ b/drivers/bus/mhi/core/init.c
> > > > @@ -374,8 +374,157 @@ struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl)
> > > >   	return mhi_dev;
> > > >   }
> > > > +static int mhi_driver_probe(struct device *dev)
> > > > +{
> > > > +	struct mhi_device *mhi_dev = to_mhi_device(dev);
> > > > +	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> > > > +	struct device_driver *drv = dev->driver;
> > > > +	struct mhi_driver *mhi_drv = to_mhi_driver(drv);
> > > > +	struct mhi_event *mhi_event;
> > > > +	struct mhi_chan *ul_chan = mhi_dev->ul_chan;
> > > > +	struct mhi_chan *dl_chan = mhi_dev->dl_chan;
> > > > +
> > > > +	if (ul_chan) {
> > > > +		/*
> > > > +		 * If channel supports LPM notifications then status_cb should
> > > > +		 * be provided
> > > > +		 */
> > > > +		if (ul_chan->lpm_notify && !mhi_drv->status_cb)
> > > > +			return -EINVAL;
> > > > +
> > > > +		/* For non-offload channels then xfer_cb should be provided */
> > > > +		if (!ul_chan->offload_ch && !mhi_drv->ul_xfer_cb)
> > > > +			return -EINVAL;
> > > > +
> > > > +		ul_chan->xfer_cb = mhi_drv->ul_xfer_cb;
> > > > +	}
> > > > +
> > > > +	if (dl_chan) {
> > > > +		/*
> > > > +		 * If channel supports LPM notifications then status_cb should
> > > > +		 * be provided
> > > > +		 */
> > > > +		if (dl_chan->lpm_notify && !mhi_drv->status_cb)
> > > > +			return -EINVAL;
> > > > +
> > > > +		/* For non-offload channels then xfer_cb should be provided */
> > > > +		if (!dl_chan->offload_ch && !mhi_drv->dl_xfer_cb)
> > > > +			return -EINVAL;
> > > > +
> > > > +		mhi_event = &mhi_cntrl->mhi_event[dl_chan->er_index];
> > > > +
> > > > +		/*
> > > > +		 * If the channel event ring is managed by client, then
> > > > +		 * status_cb must be provided so that the framework can
> > > > +		 * notify pending data
> > > > +		 */
> > > > +		if (mhi_event->cl_manage && !mhi_drv->status_cb)
> > > > +			return -EINVAL;
> > > > +
> > > > +		dl_chan->xfer_cb = mhi_drv->dl_xfer_cb;
> > > > +	}
> > > > +
> > > > +	/* Call the user provided probe function */
> > > > +	return mhi_drv->probe(mhi_dev, mhi_dev->id);
> > > > +}
> > > > +
> > > > +static int mhi_driver_remove(struct device *dev)
> > > > +{
> > > > +	struct mhi_device *mhi_dev = to_mhi_device(dev);
> > > > +	struct mhi_driver *mhi_drv = to_mhi_driver(dev->driver);
> > > > +	struct mhi_chan *mhi_chan;
> > > > +	enum mhi_ch_state ch_state[] = {
> > > > +		MHI_CH_STATE_DISABLED,
> > > > +		MHI_CH_STATE_DISABLED
> > > > +	};
> > > > +	int dir;
> > > > +
> > > > +	/* Skip if it is a controller device */
> > > > +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
> > > > +		return 0;
> > > > +
> > > > +	/* Reset both channels */
> > > > +	for (dir = 0; dir < 2; dir++) {
> > > > +		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
> > > > +
> > > > +		if (!mhi_chan)
> > > > +			continue;
> > > > +
> > > > +		/* Wake all threads waiting for completion */
> > > > +		write_lock_irq(&mhi_chan->lock);
> > > > +		mhi_chan->ccs = MHI_EV_CC_INVALID;
> > > > +		complete_all(&mhi_chan->completion);
> > > > +		write_unlock_irq(&mhi_chan->lock);
> > > > +
> > > > +		/* Set the channel state to disabled */
> > > > +		mutex_lock(&mhi_chan->mutex);
> > > > +		write_lock_irq(&mhi_chan->lock);
> > > > +		ch_state[dir] = mhi_chan->ch_state;
> > > > +		mhi_chan->ch_state = MHI_CH_STATE_SUSPENDED;
> > > > +		write_unlock_irq(&mhi_chan->lock);
> > > > +
> > > > +		mutex_unlock(&mhi_chan->mutex);
> > > > +	}
> > > > +
> > > > +	mhi_drv->remove(mhi_dev);
> > > > +
> > > > +	/* De-init channel if it was enabled */
> > > > +	for (dir = 0; dir < 2; dir++) {
> > > > +		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
> > > > +
> > > > +		if (!mhi_chan)
> > > > +			continue;
> > > > +
> > > > +		mutex_lock(&mhi_chan->mutex);
> > > > +
> > > > +		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
> > > > +
> > > > +		mutex_unlock(&mhi_chan->mutex);
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +int mhi_driver_register(struct mhi_driver *mhi_drv)
> > > > +{
> > > > +	struct device_driver *driver = &mhi_drv->driver;
> > > > +
> > > > +	if (!mhi_drv->probe || !mhi_drv->remove)
> > > > +		return -EINVAL;
> > > > +
> > > > +	driver->bus = &mhi_bus_type;
> > > > +	driver->probe = mhi_driver_probe;
> > > > +	driver->remove = mhi_driver_remove;
> > > > +
> > > > +	return driver_register(driver);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(mhi_driver_register);
> > > 
> > > You don't care about module owners of the driver?  Odd :(
> > > 
> > > (hint, you probably should...)
> > > 
> > > greg k-h
> > > 
> > 
> > For my own education, can you please clarify your comment?  I'm not sure
> > that I understand the context of what you are saying (ie why is this export
> > a possible problem?).
> 
> Sorry, it didn't have to do with the export, it had to do with the fact
> that your driver_register() function does not pass in the owner of the
> module of the driver, like almost all other subsystems do.  That way you
> can try to protect the module from being unloaded if it has files open
> assigned to it.
> 
> If you don't have any userspace accesses like that, to the driver, then
> nevermind, all is fine :)
> 

This is not needed right now but I'll fix this anyway to avoid issues in
future :)

Btw, may I know the status of this series? Do you have any more comments
or do you happen to wait for more reviews?

Thanks,
Mani

> thanks,
> 
> greg k-h
