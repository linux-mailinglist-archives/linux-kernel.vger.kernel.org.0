Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18218184CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 17:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCMQtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 12:49:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35168 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMQtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:49:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id a20so12720125edj.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 09:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGG5XY3Ewg2kr6ydPgEVpPEQe8Bu0vVCZeuUuZTd/eQ=;
        b=WoJn/P9W8ionIJ6xiBiPAmxmGbbYK44xv4IrICoWubAgYlhtkhxUJmVCijstH/13K8
         e8sfsXfNGVfsBKnRV0SJuy8a8BZyemhuV3VRdHRn2DarGPfrMqFVOH/OuDqiVr4hokOl
         UhOrjDnrSoggcD90vmrkTdZGj88Cdu4MhRmnyJ0V4shQjxGwADiObeG6nDXMrC2tX1Sf
         Zx5guOou8iWTPF16pL8NUnjXXzxYS+GbneCIQZyfvTaduvQymLt4+IWsFLUbJONa/YD2
         kXa9vk9xzfHNLaAh621qmRaQsnpJdixash8QTk6Mp+WMhkhfOstdpA5Hj+YyS0gM+Gnv
         FnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGG5XY3Ewg2kr6ydPgEVpPEQe8Bu0vVCZeuUuZTd/eQ=;
        b=PeqCqmL4Cp3vPc612H3VP6/mvBUQ/2qqQ5vU+GUmR1FebPOzThu9+YhXH3sB/FzFqZ
         7T/5FgF4J5U1h16907+K3FSoTIQWCAb8z3Sz4cPY5zjCPtGLX371RPtntPXtJG3qSAvs
         XRcxC94GcqmWtNFhVDfNCbEigyFBzIlrvBHYZCXvPbE5mq5vTiofZaV2uNHKRTopd6bu
         K3CVLnU8JOU7YaeNo87dFg5nvZ0WYJypOXl8P2LZImzgDbp5tqcosQHHtYmkV4JqY4Ab
         49dp3qzAXbaraRHDbQgyBhBtrdTmLsoNHKcZmFVJpnzu3umC4qW66FHzAAGPPk/+NOMw
         SQOA==
X-Gm-Message-State: ANhLgQ3RKQ0hSLJ54j+JgIPRhAI6K1TBEDsroWbewNtDSZ9JT3FqANN6
        ObiAj6lZQzGlW7PVjg8Hul7pcGKdzzGB9BywVbdR
X-Google-Smtp-Source: ADFU+vv+9NsRZqnIPliXMbq5GOtlCub1wdzEkmolWWP97LJYncHkT1zJ8K+tAtQcCN/BN4QsA0IqfHmFy6PXx2taKa0=
X-Received: by 2002:aa7:dd01:: with SMTP id i1mr14078117edv.164.1584118169827;
 Fri, 13 Mar 2020 09:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <20200312202733.7kli64zsnqc4mrd2@madcap2.tricolour.ca>
 <CAHC9VhS9DtxJ4gvOfMRnzoo6ccGJVKL+uZYe6qqH+SPqD8r01Q@mail.gmail.com> <2588582.z15pWOfGEt@x2>
In-Reply-To: <2588582.z15pWOfGEt@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 13 Mar 2020 12:49:18 -0400
Message-ID: <CAHC9VhQ7hFc8EqrEojmjQriWtKkqjPyzWrnrc_eVKjcYhhV8QQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 07/16] audit: add contid support for signalling
 the audit daemon
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>, linux-audit@redhat.com,
        nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 12:45 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Friday, March 13, 2020 12:42:15 PM EDT Paul Moore wrote:
> > > I think more and more, that more complete isolation is being done,
> > > taking advantage of each type of namespace as they become available, but
> > > I know a nuber of them didn't find it important yet to use IPC, PID or
> > > user namespaces which would be the only namespaces I can think of that
> > > would provide that isolation.
> > >
> > > It isn't entirely clear to me which side you fall on this issue, Paul.
> >
> > That's mostly because I was hoping for some clarification in the
> > discussion, especially the relevant certification requirements, but it
> > looks like there is still plenty of room for interpretation there (as
> > usual).  I'd much rather us arrive at decisions based on requirements
> > and not gut feelings, which is where I think we are at right now.
>
> Certification rquirements are that we need the identity of anyone attempting
> to modify the audit configuration including shutting it down.

Yep, got it.  Unfortunately that doesn't really help with what we are
talking about.  Although preventing the reuse of the ACID before the
SIGNAL2 record does help preserve the sanity of the audit stream which
I believe to be very important, regardless.

-- 
paul moore
www.paul-moore.com
