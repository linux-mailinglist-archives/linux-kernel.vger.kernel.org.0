Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E02FF13AD86
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 16:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgANPWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 10:22:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgANPWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:22:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C73E2467D;
        Tue, 14 Jan 2020 15:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579015372;
        bh=9ONsXseL7vnPhow6rBf8Rwy7QYNR2g1suzafCfQHXSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XkObdN6QZyL7qMxqhY0CAJQQ0sjY3N8DpwRxUhEzAeC7xnJ3/Iug79uQYo3uwuU2F
         ogbuVetlDLA9ETMJDdIEW15hjtaUpveO5gU2AkrPMIAtSFZQV0xcfV5k0D+TnjJay5
         w4tfgTsqJb8Rc02Ry5a8qZSK7Y8zwKKeTusf244A=
Date:   Tue, 14 Jan 2020 16:22:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: fix log spam for existing debugfs file creation.
Message-ID: <20200114152249.GA2041689@kroah.com>
References: <1578671054-5982-1-git-send-email-martin.fuzzey@flowbird.group>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578671054-5982-1-git-send-email-martin.fuzzey@flowbird.group>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 04:44:01PM +0100, Martin Fuzzey wrote:
> Since commit 43e23b6c0b01 ("debugfs: log errors when something goes wrong")
> debugfs logs attempts to create existing files.
> 
> However binder attempts to create multiple debugfs files with
> the same name when a single PID has multiple contexts, this leads
> to log spamming during an Android boot (17 such messages during
> boot on my system).
> 
> Fix this by checking if we already know the PID and only create
> the debugfs entry for the first context per PID.
> 
> Do the same thing for binderfs for symmetry.
> 
> Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>

Does this need a "Fixes:" and cc: stable tag?

And it would be good to get a review from the binder maintainer(s) to
see if this is sane or not...

thanks,

greg k-h
