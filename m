Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29062189946
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 11:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCRK0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 06:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgCRK0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:26:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89B2D2077D;
        Wed, 18 Mar 2020 10:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584527179;
        bh=UlN77Lcr1YcbRluFke1Jeq2nc5CFpiX0honzhkDD++Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sPd+IR8UVou5jeJH1g0/z49jcrnM2VKfOlv38JRYbsv06nuufTBI6CVccJEp4AOHb
         u7F41F8IM5dqVxcUjGoP9vYPFi8m46PzxpcMLDa78m+1MjnckhJINr5YM8ucYUBHeb
         qd1pNuVQhRTlcFXSpnT23kYjPX8u1rPpaD+f2F4c=
Date:   Wed, 18 Mar 2020 11:26:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 0/6] intel_th/stm class: Updates for v5.7
Message-ID: <20200318102615.GC2126918@kroah.com>
References: <20200317062215.15598-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200317062215.15598-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 08:22:09AM +0200, Alexander Shishkin wrote:
> Hi Greg,
> 
> These are the patches I have for the next merge window. They are mostly
> fixes, one new PCI ID and a "feature" for the Trace Hub's memory buffer
> trace collection. Andy Shevchenko again lent his keen reviewer's eye,
> and aiaiai static checkers approve.
> 
> A signed tag can be found below, individual patches follow. Please,
> consider pulling or applying. Thanks!
> 
> The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> 
>   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-stm-for-greg-20200316

This adds a build warning:

drivers/hwtracing/intel_th/msu.c: In function ‘stop_on_full_store’:
drivers/hwtracing/intel_th/msu.c:2078:16: warning: unused variable ‘val’ [-Wunused-variable]
 2078 |  unsigned long val;
      |                ^~~

So I'll just pick and choose the patches to take here to try to avoid
that...

Can you fix the offending patch up and resend it?

thanks,

greg k-h
