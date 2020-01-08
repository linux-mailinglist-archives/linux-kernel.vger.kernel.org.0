Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60AE13419B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 13:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgAHM1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 07:27:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:45334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgAHM1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:27:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE74206DB;
        Wed,  8 Jan 2020 12:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578486420;
        bh=bdV7UZyxDSFjWGmbyUPJYulPJkb85zdzG2rMiGkHtgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pItVJT6GR9aLVvs23xo3EJ+kba/XPUzhbw1mwc6TFE+GQwRKWl8MILQkpeMy3yxL6
         k2DIEJEJYgdmVD7LlcK8iUKi2/cMwcocFyKw+FVmQZFemY8OGl+gn/4soSOtq/X/xw
         UDpt++iYVw5G4Zd+fqY5ZVJYCKw+ed/sZe8d0/sI=
Date:   Wed, 8 Jan 2020 13:26:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luo Jiaxing <luojiaxing@huawei.com>
Cc:     saravanak@google.com, jejb@linux.ibm.com, James.Bottomley@suse.de,
        James.Bottomley@hansenpartnership.com, john.garry@huawei.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v1] driver core: Use list_del_init to replace list_del at
 device_links_purge()
Message-ID: <20200108122658.GA2365903@kroah.com>
References: <1578483244-50723-1-git-send-email-luojiaxing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578483244-50723-1-git-send-email-luojiaxing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 07:34:04PM +0800, Luo Jiaxing wrote:
> We found that enabling kernel compilation options CONFIG_SCSI_ENCLOSURE and
> CONFIG_ENCLOSURE_SERVICES, repeated initialization and deletion of the same
> SCSI device will cause system panic, as follows:
> [72.425705] Unable to handle kernel paging request at virtual address
> dead000000000108
> ...
> [72.595093] Call trace:
> [72.597532] device_del + 0x194 / 0x3a0
> [72.601012] enclosure_remove_device + 0xbc / 0xf8
> [72.605445] ses_intf_remove + 0x9c / 0xd8
> [72.609185] device_del + 0xf8 / 0x3a0
> [72.612576] device_unregister + 0x14 / 0x30
> [72.616489] __scsi_remove_device + 0xf4 / 0x140
> [72.620747] scsi_remove_device + 0x28 / 0x40
> [72.624745] scsi_remove_target + 0x1c8 / 0x220
> 
> After analysis, we see that in the error scenario, the ses module has the
> following calling sequence:
> device_register() -> device_del() -> device_add() -> device_del().
> The first call to device_del() is fine, but the second call to device_del()
> will cause a system panic.

Is this all on the same device structure?  If so, that's not ok, you
can't do that, once device_del() is called on the memory location, you
can not call device_add() on it again.

How are you triggering this from userspace?

thanks,

greg k-h
