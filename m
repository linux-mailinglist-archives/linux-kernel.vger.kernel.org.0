Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA9516516F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 22:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgBSVPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 16:15:43 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34805 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSVPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:15:43 -0500
Received: by mail-ot1-f66.google.com with SMTP id j16so1621888otl.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 13:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rn6lqpy2jbhI+4TQPpiGx1EVg5+LdG8VFa+KXdjd7b4=;
        b=G8eRdLuM89b1NNURLorTSBZTffrCPXsn6FetEjS1ZTtf9uC0kq+IPC23B1Mi7S3cJi
         3g1qYTuHmfiDr4xQ+7VzA/bA+RlQ++Xlw0cFCCZDW6MhUDveDUk3FDA3fvaTxp0dHldp
         j7tc3/dS+NoDHR5jJ4mCOjZcWlJHN0Lr33YecbqZBxdVkjomf6O6ChSa+nmASKMGa/FP
         nLoq5eF7PqH6Qo5rSdmoZM+9+USBwuOOF44DVR2MZz4ecMz2yUqcfkrtg3QB7cPFOOfH
         3BSVmZ7sF0M3/crcI6k3ua2uWoN2O9zIrHknueSV52p6q+PP7B+kDSUBamZMYq0Sq4fu
         3beA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rn6lqpy2jbhI+4TQPpiGx1EVg5+LdG8VFa+KXdjd7b4=;
        b=mjU4IaZbqYbGgPDJB2fi88jhF9jkSxZPk8PNPoc+46goXFuBB13swiy1SxRSw27Ht8
         H9WgVMdqZzGE5ysssgk1/IUP3dszAJtQjnZ2KT0CTQu+mYWnd99LsU8M6VY6aqWAuyXT
         zKAHnamPqDotLyiXigmoQuVCtGVy+G6/6Q98c45Cmtjc4nH+9J3vrgV+q8Khqh4YQ0v4
         HQMIyDZQij4KP0ZjMa7BK4p5zqBTLCuYWJSdLv/xq+uqtfdi0whqRGCiTRJdPjTSNbda
         Mw7UDrhlJUMpp3GRNq8WPpniUs/TKeasP4I3LhnkMpN2X9Ya0rI1rfKOl2v5B82iz99p
         At6w==
X-Gm-Message-State: APjAAAVQHq+bVo6GfF0qxXUH5US22pDsBQNg5CSahoBlbgbIb6Q7ThRy
        pfW+SE/fln4zpqE50EoLCeP4tO4K/tPibq5+kLCW3w==
X-Google-Smtp-Source: APXvYqwlFRnbgU0X3saTQedLkbl14HONJoNTX45B07otBFNw/JuCsPnAdd0vy3Ql9apgEyoc/5dUXdiy/YZ3p1rvVa0=
X-Received: by 2002:a9d:634c:: with SMTP id y12mr7306829otk.12.1582146941111;
 Wed, 19 Feb 2020 13:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <20200218220748.54823-2-john.stultz@linaro.org> <20200219115942.GA4488@sirena.org.uk>
In-Reply-To: <20200219115942.GA4488@sirena.org.uk>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 19 Feb 2020 13:15:29 -0800
Message-ID: <CALAqxLU3k-pqG0C92RCg6_fgeF7f5iGo8uos6ZcJpYGc3ZryfA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] driver core: Make deferred_probe_timeout global so
 it can be shared
To:     Mark Brown <broonie@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 3:59 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Feb 18, 2020 at 10:07:48PM +0000, John Stultz wrote:
> > This patch, suggested by Rob, allows deferred_probe_timeout to
> > be global so other substems can use it.
>
> > This also sets the default to 30 instead of -1 (no timeout) and
> > modifies the regulator code to make use of it instead of its
> > hard-coded 30 second interval.
>
> This is at least two patches, one adding the new feature and the other
> adding a user of that feature.

Yea, agreed. I combined it here just to get input at this point
without flooding folks with a ton of small patches.

> > @@ -5767,18 +5772,17 @@ static int __init regulator_init_complete(void)
> >               has_full_constraints = true;
> >
> >       /*
> > -      * We punt completion for an arbitrary amount of time since
> > +      * We punt completion for deferred_probe_timeout seconds since
> >        * systems like distros will load many drivers from userspace
> >        * so consumers might not always be ready yet, this is
> >        * particularly an issue with laptops where this might bounce
>
> While I don't see it doing any harm I'm not 100% convinced by this
> change - we're not really doing anything directly to do with deferred
> probe here, we're shutting off regulators that remain unused late in
> boot but even then they'll still be available for use.  It feels a bit
> unclear and the way you've adapted the code to always have a timeout
> even if the deferred probe timeout gets changed feels a bit off.  If
> nothing else this comment needs more of an update than you've done.

This was mostly spurred by Rob's suggestion, as it seemed both
subsystems were doing similar timeouts that may need to be customized
(likely around the same amount of time).  I agree it doesn't quite map
perfectly, but I imagine it would be useful to align those in some
way.

I'll likely take a swing first at getting the driver core bits to make
sense, and then I'll come and revisit this shared timeout issue.

thanks
-john
