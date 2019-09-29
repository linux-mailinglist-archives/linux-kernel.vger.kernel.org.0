Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5121C143C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 12:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfI2Kmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 06:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfI2Kmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 06:42:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0946020863;
        Sun, 29 Sep 2019 10:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569753770;
        bh=ouR6V9q3KJPqpqZJmVp8djwQWpu1aWzL4JO+zDi+DHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJhp5ixQu0JaUOtDCRFnssf4D8OOtIWMKQahWAef6kNlX/JoxUFS1RommlxVGXVYP
         3Ep7MuVSOND2aC64z71aw1G5x1gtCIrprGNKF9eF7sG+KKUpsGVZJOM92doxjUEcdP
         UetlwIR/DQKuEPNH3eVnGxKl3aACu2F0A+dmaFMw=
Date:   Sun, 29 Sep 2019 12:42:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, corbet@lwn.net, sashal@kernel.org,
        ben@decadent.org.uk, tglx@linutronix.de, labbott@redhat.com,
        andrew.cooper3@citrix.com, tsoni@codeaurora.org,
        keescook@chromium.org, tony.luck@intel.com,
        linux-doc@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 2/4] Documentation/process: describe relaxing disclosing
 party NDAs
Message-ID: <20190929104247.GA1944229@kroah.com>
References: <20190910172644.4D2CDF0A@viggo.jf.intel.com>
 <20190910172649.74639177@viggo.jf.intel.com>
 <20190911154453.GA14152@kroah.com>
 <5e9f2343-1a76-125a-9555-ab26f15b4487@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e9f2343-1a76-125a-9555-ab26f15b4487@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 09:09:18AM -0700, Dave Hansen wrote:
> On 9/11/19 8:44 AM, Greg KH wrote:
> > Intel had months of review time for this document before this was
> > published.  Your lawyers had it and never objected to this lack of
> > inclusion at all, and explictitly said that the document as written was
> > fine with them.  So I'm sorry, but it is much too late to add something
> > like this to the document at this point in time.
> 
> Hi Greg,
> 
> I'll personally take 100% of the blame for this patch.  I intended for
> it to show our commitment to work *with* our colleagues in the
> community, not to dictate demands.  Please consider this as you would
> any other patch: a humble suggestion to address what I see as a gap.
> 
> Just to be clear: this addition came from me and only me.  It did not
> come from any Intel lawyers and does not represent any kind of objection
> to the process.  Intel's support for this process is unconditional and
> not dependent on any of these patches.

Ok, thanks for the clarification.  It looked like this came from Intel
based on the comments you made on the other patches in this series.  My
confusion, sorry.

I think that Thomas's rewording here makes more sense, and you seem to
agree, so I'll go queue that up now.

thanks,

greg k-h
