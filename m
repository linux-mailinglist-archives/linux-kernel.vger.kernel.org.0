Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF64F79F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 18:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKKR36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 12:29:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41088 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfKKR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:29:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id p26so11106476pfq.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 09:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fA7Fsg1gpMy56Uu36LA4owNDl1Jh20vv8x7SlaV4qs8=;
        b=iacXhPkc9FGy32VeGcUizlaxp9TQyTa3YCq/Mk6DC1chJi3XqsDkHLsbxG5ogjF7mL
         cHrCAE9nMRbY1ne2C3sr4IhOPaWJ2BRnmockFOBbL70I54EDazU88zBM3JO+CpK73UQ3
         PodZNDoDnD8qH1DoJ1oiFoNgNkaTTyEFmoesB2/PI8l9OtBr5MTXGwh0+SkMxIIiKwBD
         oKc631VrVtl2JSu7Nt5yTatGHrE46KsgfPCuwoSyITvpyvrCJXb6MU68VvMyD0GnQNeq
         2XLnaTQkBqfugUlXoMFeoT1nyAYH8VQDHPUEw3yCqSvvMO9cPzry4w02tpH4rmIb0xCh
         76HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fA7Fsg1gpMy56Uu36LA4owNDl1Jh20vv8x7SlaV4qs8=;
        b=TeU/4/8wAwIQaXGK7NyPVxoNXbql0WaJC44NeLuYI7PUR6xei+hwbRO8Pw3U2udkoz
         SepY+dThgMk9+QM/N0cNyPST320f+eWFOLdDWK1Hmx4pdlvJ9zjvg1uYbTylvn2T2zqU
         c2mo8M1TcbMawNUGXuJa7pYjhD2z5LgO3vw8phhwAqPKmi7SWTGttyKZVcaPyslYVhqQ
         MHxnDvbA8VfIRYkEc9a3LhiQhBGvZDKVpvvog6h4Iy6fnw0/omZ1t1+O+Pu+5HcxouKG
         L0DDE3CyrPX+Xlnfg+FF9111VTcWwhzd0VN/wNztRno42GnN3m9hL04NfdOXLXU3H5P0
         jx1w==
X-Gm-Message-State: APjAAAUWrmalyfeEP5FY7GkiC8eBftfpVhrZ6dm5LEUUhUQJVyQetgdm
        dnciLx115+ANTd1YXAHyScmMRQ==
X-Google-Smtp-Source: APXvYqz/ZDi0j4sGOiniVLuzA+Rs8BpMrp5miPmhe+9uGIOTxXjJNz7l6UCNqvoKgWBmZet2LW3hWA==
X-Received: by 2002:a63:7015:: with SMTP id l21mr27824906pgc.200.1573493397028;
        Mon, 11 Nov 2019 09:29:57 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id r184sm17589538pfc.106.2019.11.11.09.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 09:29:56 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:29:48 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lantianyu1986@gmail.com, alex.williamson@redhat.com,
        cohuck@redhat.com, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, sashal@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net, robh@kernel.org,
        Jonathan.Cameron@huawei.com, paulmck@linux.ibm.com,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, vkuznets <vkuznets@redhat.com>
Subject: Re: [PATCH] VFIO/VMBUS: Add VFIO VMBUS driver support
Message-ID: <20191111092948.047f1708@hermes.lan>
In-Reply-To: <20191111172322.GB1077444@kroah.com>
References: <20191111084507.9286-1-Tianyu.Lan@microsoft.com>
        <20191111094920.GA135867@kroah.com>
        <20191111084712.37ba7d5a@hermes.lan>
        <20191111172322.GB1077444@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 18:23:22 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Nov 11, 2019 at 08:47:12AM -0800, Stephen Hemminger wrote:
> > On Mon, 11 Nov 2019 01:49:20 -0800
> > "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >   
> > > > +	ret = sysfs_create_bin_file(&channel->kobj,    
> > > &ring_buffer_bin_attr);  
> > > > +	if (ret)
> > > > +		dev_notice(&dev->device,
> > > > +			   "sysfs create ring bin file failed; %d\n",    
> > > ret);  
> > > > +    
> > > 
> > > Again, don't create sysfs files on your own, the bus code should be
> > > doing this for you automatically and in a way that is race-free.
> > > 
> > > thanks,
> > > 
> > > greg k-h  
> > 
> > The sysfs file is only created if the VFIO/UIO driveris used.  
> 
> That's even worse.  Again, sysfs files should be automatically created
> by the driver core when the device is created.  To randomly add/remove
> random files after that happens means userspace is never notified of
> that and that's not good.
> 
> We've been working for a while to fix up these types of races, don't
> purposfully add new ones for no good reason please :)
> 
> thanks,
> 
> greg k-h

The handler for this sysfs file is in the vfio (and uio) driver.
How would this work if bus handled it?
