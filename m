Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B999A9A22
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 07:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbfIEFhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 01:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730801AbfIEFhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 01:37:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4390208E4;
        Thu,  5 Sep 2019 05:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567661835;
        bh=fYRvwBq0+YcDWM1nphCOQUXCYxH0k2i3xcWg9k5lO7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEAmuOA9lGr2S20H5sSFXIUpC1VS8r+Tl/VXq12lLYeB9K7mTN1w9xus7UPsft5k8
         687yVmtbkINjTeml5Kq+/CI6i9FCmPwdJMGy5x1CrTa0oEg7T5Gly2KJhpuq0fc40k
         V5oTvYoEUYAPfxnnYuC4a5LTASC/FU70BYd4OMaU=
Date:   Thu, 5 Sep 2019 07:37:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tyler Hicks <tyhicks@canonical.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Documentation/process: Volunteer as the ambassador for
 Xen
Message-ID: <20190905053712.GA17257@kroah.com>
References: <20190904181702.19788-1-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904181702.19788-1-andrew.cooper3@citrix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 07:17:02PM +0100, Andrew Cooper wrote:
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tyler Hicks <tyhicks@canonical.com>
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> ---
> Volunteer as tribute, perhaps.  Lets hope this isn't needed as frequenly as
> the past two years have gone.

I sure hope not, but thanks for volunteering!

greg k-h
