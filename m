Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9872AB7EC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 14:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391890AbfIFMPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 08:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731749AbfIFMPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:15:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 681112082C;
        Fri,  6 Sep 2019 12:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567772112;
        bh=5lYR/FQBgRh7A9RIp7yNUqDXtfcFudRVpQJL1DVpMQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hg00T9IPvUXYTC/+xnKj1S1qbcnE6WFmCIUz9qPNHq+L783ygHKxPJVHvn8w9vsrZ
         YTFcKHDcldoSFM3Qw3IoA/Y9bMi95Lyz8e7B/Ow3MEDCtDAf2/6TYOLwtjl9qEunoS
         KmMRZgwDU754CERmPPr08l4XlIUoSFMMRNjSjDbw=
Date:   Fri, 6 Sep 2019 14:15:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Thomas <trenn@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: /dev/mem and secure boot
Message-ID: <20190906121510.GA17328@kroah.com>
References: <20190906130221.0b47a565@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906130221.0b47a565@endymion>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 01:02:21PM +0200, Jean Delvare wrote:
> I've been bitten recently by mcelog not working on machines started in
> secure boot mode. mcelog tries to read DMI information from /dev/mem
> and fails to open it.

What do you mean by "secure boot"?  Is this matthew's patchset that
restricts /dev/mem/ or something else?

> This made me wonder: if not even root can read /dev/mem (nor, I
> suppose, /dev/kmem and /dev/port) in secure boot mode, why are we
> creating these device nodes at all in the first place? Can't we detect
> that we are in secure boot mode and skip that step, and reap the rewards
> (faster boot, lower memory footprint and less confusion)?

Sure, feel free to not register it at all if the mode is enabled.

thanks,

greg k-h
