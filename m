Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE99829265
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 10:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389316AbfEXIGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 04:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389046AbfEXIGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:06:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B0702133D;
        Fri, 24 May 2019 08:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558685164;
        bh=vgZcDHT3SM5hC1ueqbfS3ee1j3qnp9qGc2/YoL1k5FE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gAJmLl2IDvA9SaE+pSxROqx56O5HVK4fHHBwrqvuU1e2oKD1TSeooAr9d7RnKN062
         y39ij4q1bxJel/nQjAQ/6vlsndYcBFQZKaIe39q4YWbJnrLukxXvKBAiBA2p78VckA
         C2CiYPMn8RCkhf5IOEVHTGbzulH/mdiDB/SAW/t8=
Date:   Fri, 24 May 2019 10:06:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Grzegorz Halat <ghalat@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Subject: Re: [PATCH] vt/fbcon: deinitialize resources in visual_init() after
 failed memory allocation
Message-ID: <20190524080602.GA19514@kroah.com>
References: <20190426145946.26537-1-ghalat@redhat.com>
 <CAKbGCscqbvOaXPTdmxatNLBygdu=WC0hVUKx0_WnqUR4+dj_zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKbGCscqbvOaXPTdmxatNLBygdu=WC0hVUKx0_WnqUR4+dj_zQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 04:33:40PM +0200, Grzegorz Halat wrote:
> On Fri, 26 Apr 2019 at 16:59, Grzegorz Halat <ghalat@redhat.com> wrote:
> >
> > After memory allocation failure vc_allocate() doesn't clean up data
> > which has been initialized in visual_init(). In case of fbcon this
> > leads to divide-by-0 in fbcon_init() on next open of the same tty.
> 
> Hi,
> A gentle reminder. Could you please review my patch? I've seen two
> crashes caused by this bug.

How?  How are you triggering a memory allocation failure in a "normal"
system?

Anyway, I'll queue this up, but it really does not seem like anything
anyone would see "in the wild".

thanks,

greg k-h
