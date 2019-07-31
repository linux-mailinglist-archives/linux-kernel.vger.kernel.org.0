Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDCF07C22B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 14:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfGaMvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 08:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfGaMvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:51:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BB21206B8;
        Wed, 31 Jul 2019 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564577466;
        bh=m75Y5bySfWBg5RmHFC71cuvOVKJysRnkCpBlKcHZU9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=polaUNRXlPvhV5sj/t8H8t9+nufivwNfvf8s0t/hPB/CKys8ZkEiYhn5zyBfpQe/6
         htHepHzxiC126s7lK8SPlIqt96j7yN9LG50E86zzvs+FfgFhQJg4VmPD4fuCU2aN08
         s7c6fYss2YRY5WaMZLZc8mU7CFzaWjsLmlRBS1sU=
Date:   Wed, 31 Jul 2019 14:51:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 01/10] driver core: add dev_groups to all drivers
Message-ID: <20190731125104.GA6062@kroah.com>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
 <20190731124349.4474-2-gregkh@linuxfoundation.org>
 <s5h4l32s71l.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h4l32s71l.wl-tiwai@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 02:49:26PM +0200, Takashi Iwai wrote:
> On Wed, 31 Jul 2019 14:43:40 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Add the ability for the driver core to create and remove a list of
> > attribute groups automatically when the device is bound/unbound from a
> > specific driver.
> > 
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Missing sign-off from Dmitry?

He never provided it :(

Dmitry, can you please do so?  I forgot to include that in the cover
leter...

thanks,

greg k-h
