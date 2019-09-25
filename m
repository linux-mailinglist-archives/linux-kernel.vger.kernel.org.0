Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F05FEBDD1F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 13:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404738AbfIYLaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 07:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404699AbfIYLaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:30:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3CEE21D7C;
        Wed, 25 Sep 2019 11:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569411001;
        bh=bT6QNYw62ROYdUkU8kuDz9f6qPtELlUCc5ZZT8/IPH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHkSSMhqYFHePGS+ur3Yuz4EpwzvPWJo484/36I39y8edrV3hnIL9A+GMul4gDohu
         VrF8nTYTgawwn8UmYBt7I8xGtMVHl1jrfeQKePxoVrNb792bKfY3wD6szak7wnEMWA
         i7c5Xv8XrXO41oprZQd37sJeDWyHjmk3gEz9Wnxk=
Date:   Wed, 25 Sep 2019 13:29:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, arnd@arndb.de, michal.simek@xilinx.com
Subject: Re: [RFC PATCH 2/2] misc: xilinx_flex: Add support for the flex noc
 Performance Monitor
Message-ID: <20190925112958.GB1490631@kroah.com>
References: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569410216.git.shubhrajyoti.datta@xilinx.com>
 <5694e92158ce93f774fc804c069b465b3dc1f62a.1569410216.git.shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5694e92158ce93f774fc804c069b465b3dc1f62a.1569410216.git.shubhrajyoti.datta@xilinx.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 04:53:07PM +0530, Shubhrajyoti Datta wrote:
> Add support for the FlexNoc Performance Monitor.
> Adds support for various port setting and monitoring
> the packets transactions. It supports LPD and FPD monitoring
> counters for read and write transaction requests and responses.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/misc/Kconfig          |   9 +
>  drivers/misc/Makefile         |   1 +
>  drivers/misc/xilinx_flex_pm.c | 644 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 654 insertions(+)
>  create mode 100644 drivers/misc/xilinx_flex_pm.c

You are creating new sysfs files (in a buggy and racy way), and not
documenting them in Documentation/ABI/ which is not allowed.

Please fix up both issues before resending.

thanks,

greg k-h
