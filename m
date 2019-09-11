Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCCCAFBF7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 13:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfIKLyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 07:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfIKLyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:54:55 -0400
Received: from localhost (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 306C5206A5;
        Wed, 11 Sep 2019 11:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568202893;
        bh=dZkPFEFYHk3XV5sMFgWKRdUHKnMUAz8iz3zkyPF7RkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsAbUtOW5klYj8TSAi97iki2lZEvFWzuDniiyfILmS63MA3sjVfq17ahwFR8f/gSk
         D/6q8u6k42CtrCSM4/gpg6SwyizJG08Mo/SpKcvYHcgKYhVwnwUsCjsRIBAydeCJbM
         hGpN+Fq8OHn0xWYuRT00+wPx8CnXz52Vj21xaaG4=
Date:   Wed, 11 Sep 2019 12:54:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net, sashal@kernel.org,
        ben@decadent.org.uk, tglx@linutronix.de, labbott@redhat.com,
        andrew.cooper3@citrix.com, tsoni@codeaurora.org,
        keescook@chromium.org, tony.luck@intel.com,
        dan.j.williams@intel.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/4] Documentation/process: embargoed hardware issues
 additions
Message-ID: <20190911115450.GA29987@kroah.com>
References: <20190910172644.4D2CDF0A@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910172644.4D2CDF0A@viggo.jf.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 10:26:44AM -0700, Dave Hansen wrote:
> Intel will adhere to this process for future hardware embargoed
> issues.  This series contains a patch from Tony Luck with him
> volunteering to be Intel's ambassador for this process.
> 
> These are some minor improvements here to the process document.  I've
> had the pleasure of seeing some of the problems with the various
> "processes" that led to the need for this document and I think these
> tweaks will help.  This part of the series is much more of an RFC than
> the first patch, obviously.

I've applied patch 1 to the tree, thank you for that.

The other patches will take a bit more to think about, and calm down
about, before I'll respond.  Please wait until next week for that...

thanks,

greg k-h
