Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D83F158D22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 12:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgBKLBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 06:01:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgBKLBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:01:32 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E320D206DB;
        Tue, 11 Feb 2020 11:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581418892;
        bh=eUexnhmDU3VQ4N25ffYXIeI9ds5eo9F52594vkxGwtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wTJnIZ76EOvxxyQX8ypEeoMOR00rT7sBTuBYSgoONN/4a06djSfASD6PyX1UtE9ft
         RIiE2yvWlsp4sZ5LZtsvolWK6rGJLa16J+lYD55NqmpGVNBxVHIM1Jt0I+hmeB/IcU
         8NVQNeeXx0nOxh+AvnzkYuJtnbD2yfJJdAWMd8nM=
Date:   Tue, 11 Feb 2020 11:01:27 +0000
From:   Will Deacon <will@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Saravana Kannan <saravanak@google.com>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200211110126.GC8560@willie-the-truck>
References: <20200123093628.GA18991@willie-the-truck>
 <20200123085015.GA436361@kroah.com>
 <CAGETcx86rQpS4qodSiv_v+E_8P3DUQDY9jiN_Yq07Jwh9tHQcQ@mail.gmail.com>
 <20200125101130.449a8e4d@lwn.net>
 <20200125014231.GI147870@mit.edu>
 <20200123155340.GD147870@mit.edu>
 <20200209110549.GA1621867@kroah.com>
 <20200210211142.GB1373304@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210211142.GB1373304@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 01:11:42PM -0800, Greg Kroah-Hartman wrote:
> With the realization that having debugfs enabled on "production" systems
> is generally not a good idea, debugfs is being disabled from more and
> more platforms over time.  However, the functionality of dynamic
> debugging still is needed at times, and since it relies on debugfs for
> its user api, having debugfs disabled also forces dynamic debug to be
> disabled.
> 
> To get around this, also create the "control" file for dynamic_debug in
> procfs.  This allows people turn on debugging as needed at runtime for
> individual driverfs and subsystems.
> 
> Reported-by: many different companies
> Cc: Jason Baron <jbaron@akamai.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v6: fix up Kconfig help, it was a bit incorrect,thanks to Saravana for
>     the review.
> v5: as many people asked for it, now enable the control file in both
>     debugfs and procfs at the same time.

The 'ddebug_lock' mutex looks like it resolves all of the races here, so:

Acked-by: Will Deacon <will@kernel.org>

Will
