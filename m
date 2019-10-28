Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1C3E7720
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 17:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403965AbfJ1Q7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 12:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730463AbfJ1Q7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:59:12 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4911F208C0;
        Mon, 28 Oct 2019 16:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572281951;
        bh=UYouAhSgD6Ci8zsPE6rdCP7HF2cJHswezxxOQTzMf9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yqs9XFdFAkSZIlT5PTS4XYl6FpeFgw1NlLwbUkgyqiDIRfL4FbaXiFLxBciPFCsEg
         QlPMhcoiXGwxlACI9zioIW/pJEICg79mqqsTLYbioElb2HIJt/VtjZFJdEpUPqVPLx
         hhKOQV6Pp764XR1ZfW3Tha9FZJzg3OGuyfe48B2E=
Date:   Mon, 28 Oct 2019 17:59:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     devel@driverdev.osuosl.org, eric@anholt.net, wahrenst@gmx.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: replace g_free_fragments_mutex
 with spinlock
Message-ID: <20191028165909.GA469472@kroah.com>
References: <20191027221530.12080-1-dave@stgolabs.net>
 <20191028155354.s3bgq2wazwlh32km@linux-p48b>
 <20191028162412.GA321492@kroah.com>
 <20191028163537.b2pspgdl6ceevcxv@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028163537.b2pspgdl6ceevcxv@linux-p48b>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 09:35:37AM -0700, Davidlohr Bueso wrote:
> On Mon, 28 Oct 2019, Greg KH wrote:
> > This is obviously not in a format I can apply it in :(
> 
> What are you talking about? I sent you the original patch,
> then Cc'ed the drivers mailing list. So you still have a
> patch you can apply... this is quite a common way of doing
> things (Ccing for future references to someone or another
> ml). I don't understand why you are hairsplitting over this
> patch.

I don't understand what is going on at all.  Is this patch already
applied?  If not, then yes, I need it in a format I can apply it in.  If
it's already applied to my tree/branch, then there's no need to send it
at all.

totally confused,

greg k-h
