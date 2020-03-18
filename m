Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 369F8189586
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 07:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgCRGC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 02:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgCRGC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 02:02:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D12920663;
        Wed, 18 Mar 2020 06:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584511376;
        bh=rrtQ7bSEmpqBZhNRWvjkSCXBWymjQBTAn4TLG3GnOZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0lVSe2EwSW1Aav+XG39anTMGM7F1meUK3FdwawjmTFjZlQyGLrGK9qqCHfcsct4T
         3lqrOWxqsAmxx40aM1cDyecMhZgbnZ5k5wj0V2uti4WJBtkKnM+UmoPt5KL77JlLLt
         y0o1GB0j+wSmprz+VHDU0o9yNTp6+PQkVm/JqTU4=
Date:   Wed, 18 Mar 2020 07:02:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Sean Paul <seanpaul@chromium.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] drm/nouveau/kms/nvd9-: Add CRC support
Message-ID: <20200318060254.GB1594891@kroah.com>
References: <20200318004159.235623-1-lyude@redhat.com>
 <20200318004159.235623-10-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318004159.235623-10-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 08:41:06PM -0400, Lyude Paul wrote:
> +	root = debugfs_create_dir("nv_crc", crtc->debugfs_entry);
> +	if (IS_ERR(root))
> +		return PTR_ERR(root);

No need to check this, just take the return value and move on.

> +
> +	dent = debugfs_create_file("flip_threshold", 0644, root, head,
> +				   &nv50_crc_flip_threshold_fops);
> +	if (IS_ERR(dent))
> +		return PTR_ERR(dent);

No need to check this either, in fact this test is incorrect :(

Just make the call, and move on.  See the loads of debugfs cleanups I
have been doing for examples.

thanks,

greg k-h
