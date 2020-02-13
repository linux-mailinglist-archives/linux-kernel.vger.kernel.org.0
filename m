Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE1E15CEB4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 00:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgBMXhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 18:37:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbgBMXhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 18:37:52 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0626620848;
        Thu, 13 Feb 2020 23:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581637070;
        bh=Ql6zYvXCOBVpVMtIO4wvQ1qek1fa2G9r/sFK9BFYgVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+S8OxEv7r81aEszEQVahIXP90Eb09j1iN/gyGVcQ9ACja+ulkWazmbP9rblVcmss
         WxdkxWgdXd4SJtYqMAuLWl2EubuZTKu8AcdKI8mXpjV+V04gKY5EcVnlQI1FiWkwTS
         1pVB9atDLD0vJW8fmhKrIQY+TMeCO5eu9Xad7V1k=
Date:   Thu, 13 Feb 2020 15:37:49 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Tyler Hicks <tyhicks@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/process: Swap out the ambassador for
 Canonical
Message-ID: <20200213233749.GB3926134@kroah.com>
References: <20200213214842.21312-1-tyhicks@canonical.com>
 <20200213231607.GA3925051@kroah.com>
 <ea91eec6-a1be-807b-32e7-acfa36071599@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea91eec6-a1be-807b-32e7-acfa36071599@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 03:25:22PM -0800, John Johansen wrote:
> On 2/13/20 3:16 PM, Greg Kroah-Hartman wrote:
> > On Thu, Feb 13, 2020 at 09:48:42PM +0000, Tyler Hicks wrote:
> > > John Johansen will take over as the process ambassador for Canonical
> > > when dealing with embargoed hardware issues.
> > 
> > Can I get an ack from John to "prove" he is ok with this horrible task?  :)
> > 
> 
> sure take away the plausible deniability ;)

Heh, thanks.  I'll queue this up with the other modifications I have
already for this file and send it to Linus soon.

greg k-h
