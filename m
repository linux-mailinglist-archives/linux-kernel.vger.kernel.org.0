Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D7729A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 17:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbfEXPIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 11:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389125AbfEXPIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:08:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D86E220862;
        Fri, 24 May 2019 15:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558710516;
        bh=3GrNZFme+cssaRXbUiJnp/vXmmt3iw6xD3QXYdE76Mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CS6lansAEU9DrKeiKD2en9gdaoys56slkceUSbVE1OzHI0NmNqOrQWVCbFVroGjyK
         QTtVEIxts08HsgAecaXqC1RWXVaZA9OhGSYND5Nj9s7lly6wegGEVRYsovbCF0DDrs
         w+qb14gSzU3B49/6wj5uhIj7Q07+JzjX3MF+uqFk=
Date:   Fri, 24 May 2019 17:08:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Grzegorz Halat <ghalat@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Subject: Re: [PATCH] vt/fbcon: deinitialize resources in visual_init() after
 failed memory allocation
Message-ID: <20190524150833.GA10297@kroah.com>
References: <20190426145946.26537-1-ghalat@redhat.com>
 <CAKbGCscqbvOaXPTdmxatNLBygdu=WC0hVUKx0_WnqUR4+dj_zQ@mail.gmail.com>
 <20190524080602.GA19514@kroah.com>
 <CAKbGCscp6gLFEuu+xn24KM6Gy=x=pW9bnJGF_2CY3jzbnyV5_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKbGCscp6gLFEuu+xn24KM6Gy=x=pW9bnJGF_2CY3jzbnyV5_g@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 03:52:31PM +0200, Grzegorz Halat wrote:
> On Fri, 24 May 2019 at 10:06, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > How?  How are you triggering a memory allocation failure in a "normal"
> > system?
> > Anyway, I'll queue this up, but it really does not seem like anything
> > anyone would see "in the wild"
> 
> I've seen this crash twice in ours customer environment under low
> memory conditions.
> There is a report in Debian bug tracker:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=804443
> and LKML bug report:
> https://lkml.org/lkml/2017/12/18/591

Ok, now queued up to go to Linus for 5.2-final.

thanks,

greg k-h
