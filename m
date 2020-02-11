Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCC215996C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 20:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgBKTL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 14:11:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38872 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730444AbgBKTL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:11:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id d6so6229206pgn.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 11:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tsow3V7Qcg/7TdOBvQfEChXDPTjmm/i/J9UtL8nyGdQ=;
        b=zondnlkgAJViZhnsfy6H4zqUsOW8TjHRFBApbJIsN0y0H5PHvFZBtsSOT9Dyf41nMe
         EcNKxiErTEGxr4+pljj1+euUZq2JiO4RMBE0e5jtlkyqkBtF6vNqB8NqQuvqJlpq+DhO
         TtTo5GEXOEdGRCU/0EASkPR7z2KFC4Pi8Qv5zO0Y+3ago2m5129BIgwmFeW5L3QJGnpe
         lZDs3OSRPNi5LkPBrwC0NcWsSuv5XOMG7XqtJM+YtZf5PhetIvRU0wtL4V0hWNfwqalI
         u4rbtVr4HDgiVxjTqAxY7mMLgREOBGlMemylNEP/FR+ZbWASoJvArkUPGpoAcK58PDfz
         ehBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tsow3V7Qcg/7TdOBvQfEChXDPTjmm/i/J9UtL8nyGdQ=;
        b=KbA4b08RKt7DYiFrb1IfiEgzLNXRzNfXqtY/Lv3JlR0DUNkNRfXF94UUSOt3cV2nTo
         38Cx2JY9TR8XwJyJ0lbMxvnteOO5kTQwOGYUqlTus3YXfGi+8v3ECXyyGqRHVBo/Iv1k
         BUMKwb5KxujqUpT4yuH7CQdGrg/aRGgWu+Y1ApD4ENYvbzdscQE77qmIHHufOWEI4VTY
         BplUFbRzxnMih7QVRvVImH2Uey3WHiU81RgYZqJb3hvBgUFDW/YfGCMOKqS+fMCg++ul
         OMB4155jE7kgdev8wS59okPjhoBZF2dGW/IZKsYK82G0t1uQZlgPwtftit9kS3KKiX3e
         c+1Q==
X-Gm-Message-State: APjAAAXz1D5kpypzmuxYOKICpcWeuL7tXykMSJkaTHQeWhobVaw8Xwtg
        djZ8dOWhZB91cHoAabUAb3mY
X-Google-Smtp-Source: APXvYqzhJB7rfJbmXLIaUCiKe6GXen7+4eeBQ7SZcbGsxfwdiyucbZcgMROkcH+xdR59gIUnOiITTw==
X-Received: by 2002:a63:f402:: with SMTP id g2mr4174697pgi.405.1581448314841;
        Tue, 11 Feb 2020 11:11:54 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:638b:7653:754d:196d:c455:1f88])
        by smtp.gmail.com with ESMTPSA id d24sm5327630pfq.75.2020.02.11.11.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 11:11:54 -0800 (PST)
Date:   Wed, 12 Feb 2020 00:41:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/16] bus: mhi: core: Add support for registering MHI
 controllers
Message-ID: <20200211191147.GB11908@Mani-XPS-13-9360>
References: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
 <20200131135009.31477-3-manivannan.sadhasivam@linaro.org>
 <20200206165606.GA3894455@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206165606.GA3894455@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Feb 06, 2020 at 05:56:06PM +0100, Greg KH wrote:
> On Fri, Jan 31, 2020 at 07:19:55PM +0530, Manivannan Sadhasivam wrote:
> > +static void mhi_release_device(struct device *dev)
> > +{
> > +	struct mhi_device *mhi_dev = to_mhi_device(dev);
> > +
> > +	if (mhi_dev->ul_chan)
> > +		mhi_dev->ul_chan->mhi_dev = NULL;
> 
> That looks really odd.  Why didn't you just drop the reference you
> should have grabbed here for this pointer?  You did properly increment
> it when you saved it, right?  :)
> 

Well, there is no reference count (kref) exist for mhi_dev. And we really
needed to NULL the mhi_dev to avoid any dangling reference to it. The reason for
not having kref is that, each mhi_dev will be used by maximum of 2 channels
only. So thought that refcounting is not needed. Please correct me if I'm
wrong.

Thanks,
Mani

> > +
> > +	if (mhi_dev->dl_chan)
> > +		mhi_dev->dl_chan->mhi_dev = NULL;
> 
> Same here.
> 
> thanks,
> 
> greg k-h
