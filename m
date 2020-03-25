Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230E0192636
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 11:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgCYKxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 06:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgCYKxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:53:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49281206F6;
        Wed, 25 Mar 2020 10:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585133588;
        bh=eNKDrjGeRGne237ucRqN4fyF1o7W5vC1y21j05IKCoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rpPjSn4K2bsf84MmozkpghLYzNp8h8gDbY98Z07aLrxqEyvXb2rOPIHAKf7axiiwn
         DBFYQCvvt8EQb0+if8SdAd0tcdiBEE2lhGCFzuCzQGr1/JMx2Zz6gUay9CqQSRrmWl
         QGcA9nSvocsu1PN8A+KcukKYw3wZ8Tp8ugDImy28=
Date:   Wed, 25 Mar 2020 11:53:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au
Subject: Re: [PATCH v2 2/2] nvmem: core: use is_bin_visible for permissions
Message-ID: <20200325105306.GA3146321@kroah.com>
References: <20200325100138.17854-1-srinivas.kandagatla@linaro.org>
 <20200325100138.17854-3-srinivas.kandagatla@linaro.org>
 <20200325102134.GA3084470@kroah.com>
 <e1e768dd-7e6f-b917-dfb6-cf2e1fc6114a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e768dd-7e6f-b917-dfb6-cf2e1fc6114a@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 10:40:10AM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 25/03/2020 10:21, Greg KH wrote:
> > > -
> > >   const struct attribute_group **nvmem_sysfs_get_groups(
> > >   					struct nvmem_device *nvmem,
> > >   					const struct nvmem_config *config)
> > You no longer need any parameters for this function, right?
> no we do not need that, I can update that in next version.

Ok.

> > Also, you really don't even need the function, just point to the
> > variable instead.
> We have a use case where in the user can chose to not have sysfs entry,
> specially if we have hypervisor trapping access to some range of entries in
> nvmem. This is enforced using CONFIG_NVMEM_SYSFS option.
> 
> Currently in upstream we have a stub function when CONFIG_NVMEM_SYSFS is not
> selected returning NULL.
> 
> If we want to remove this function and subsequently the nvmem-sysfs.c file
> then we have to have #ifdef in the code which am okay to do if that is
> something that you are keen on.

You can still do it in the .h file, defining the variable as NULL if
that config option is not enabled.

thanks,

greg k-h
