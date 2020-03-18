Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC18F18A0F6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 17:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCRQyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 12:54:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51076 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgCRQyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:54:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id z13so4276305wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 09:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=euLF9uKukhUVYesx9HtjGcg8xZuMjIswB0B2088zXNE=;
        b=JJ6/OpCLtKTqtB6uxm2hMHagpXJXdLC17tZFROgOO4zpKBlJOHIOYPgtfRxdxIQNCv
         bRIzKfaZtyCPMyLzY5e3i/zf1En0YslFxsY0iiFHQuVdf2WXP+yUJzsbTOujoto6aBLd
         /E5oVXjUFqSxSalML/Qb23Bcf9c90LFDw33kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=euLF9uKukhUVYesx9HtjGcg8xZuMjIswB0B2088zXNE=;
        b=OG8gwl8iBdoBi3BKnohXiMLDmrTCtW0DuPceTuEYq6ZT1LU+14YCWMKVFurEut6Mkw
         dmGafLZizIAPqRLQyyfR22reaNIwuVWF/CYyoJKaBC3exQeMKk3hWALYztcxXdSTd4Jj
         bdadiJ9PTaWq2m/m57y57Nv9Ba/g2Hgn+eBTJ9NY8PW1+ycMPR0Mvd7vNJZGZjzTJFEr
         KtPU08ROjA691peQmefX6FAVQsVREJ9/Nsv2VkFojwMnSUMFr5h7en0sAcen9J0tDPNI
         TnlCzuhG7PmQB7f0JbNUxZZxjAy4TncbHiWNFThh6Q8eBxPuN2BNWneCL1j0sgjaKl8C
         jgcA==
X-Gm-Message-State: ANhLgQ1+/Kobc2S9DUb3BdZ0I/c+85ABwbp+8vPk/Ax904nwGLDJRQbD
        ICrtKKmwp2QZuO7jwDL9DADGKQ==
X-Google-Smtp-Source: ADFU+vtH3o1yPclrHIEiwrUHDrQwsqLe9vEypWjkSC/b3CYYmEykMBPLH06LmomqF5G282GjOoJo2g==
X-Received: by 2002:a05:600c:20c9:: with SMTP id y9mr6431143wmm.83.1584550484128;
        Wed, 18 Mar 2020 09:54:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i12sm10245729wro.46.2020.03.18.09.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 09:54:43 -0700 (PDT)
Date:   Wed, 18 Mar 2020 17:54:41 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/17] drm: subsytem-wide debugfs functions refactor
Message-ID: <20200318165441.GA2363188@phenom.ffwll.local>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
        Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
 <20200310143307.GA3376131@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310143307.GA3376131@kroah.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 03:33:07PM +0100, Greg KH wrote:
> On Tue, Mar 10, 2020 at 04:31:04PM +0300, Wambui Karuga wrote:
> > This series includes work on various debugfs functions both in drm/core
> > and across various drivers in the subsystem.
> > Since commit 987d65d01356 (drm: debugfs: make drm_debugfs_create_files()
> > never fail), drm_debugfs_create_files() does not fail and only returns
> > zero. This series therefore removes the left over error handling and
> > checks for its return value across drm drivers.
> > 
> > As a result of these changes, most drm_debugfs functions are converted
> > to return void in this series. This also enables the
> > drm_driver, debugfs_init() hook to be changed to return void. 
> > 
> > v2: individual driver patches have been converted to have debugfs
> > functions return 0 instead of void to prevent breaking individual driver
> > builds.
> > The last patch then converts the .debugfs_hook() and its users across
> > all drivers to return void.
> 
> This looks much better to me, nice job:

Yup, really nice all!

> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for the patches (and the review), everything queued up in
drm-misc-next. But missed the 5.7 feature freeze in drm unfortunately, so
heading for 5.8. Apologies for being a bit too distracted past week and
not merging this a bit more timely.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
