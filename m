Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79573F964
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 15:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfD3NAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 09:00:02 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:33594 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfD3NAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:00:02 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id D097A5C1015; Tue, 30 Apr 2019 14:59:09 +0200 (CEST)
Date:   Tue, 30 Apr 2019 14:59:09 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>, David Lin <dtwlin@gmail.com>,
        devel@driverdev.osuosl.org, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH] staging: greybus: use proper return type for
 wait_for_completion_timeout
Message-ID: <20190430125909.GC26274@osadl.at>
References: <1556335645-7583-1-git-send-email-hofrat@osadl.org>
 <20190430095821.GD2269@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430095821.GD2269@kadam>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:58:21PM +0300, Dan Carpenter wrote:
> On Sat, Apr 27, 2019 at 05:27:25AM +0200, Nicholas Mc Guire wrote:
> > wait_for_completion_timeout() returns unsigned long (0 on timeout or
> > remaining jiffies) not int. 
> > 
> 
> Yeah, but it's fine though because 10000 / 256 fits into int without a
> problem.
> 
> I'm not sure this sort of patch is worth it when it's just a style
> debate instead of a bugfix.  I'm a little bit torn about this.  In
> Smatch, I run into this issue one in a while where Smatch doesn't know
> if the timeout is less than int.  Right now I hacked the DB to say that
> these functions always return < INT_MAX.
> 
> Anyway, for sure the commit message should say that it's just a cleanup
> and not a bugfix.
>
I know its not a functional bug its "only" an API violation - the problem
is more that code is often cut&past and at some point it may be a 
problem or someoe expects a negative return value without that this evef
can occure.

But yes - the commit message should have stated that this non-conformance
in this case has no effect - will resend.

thx!
hofrat
