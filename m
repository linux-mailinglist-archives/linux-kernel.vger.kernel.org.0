Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A2469D55
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 23:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbfGOVKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 17:10:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37525 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbfGOVKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:10:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id z28so17764302ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QqWs6tnJsgPqdUO1RETz8iVY1LYxL4xOc0UaMWvwPg0=;
        b=Jc3fkDPoiovpnK/n6pDHbPLS9nVpGOM7djQI5/ClJN/dSVYx0G2CcXdfv23vT3PanX
         Qn6AUs3nVlieQDU5Z4c7eqmhRVhmiFpAcCkovtd0tanJyIidCZd+LqSce4GoI/lUymw3
         ElQLBiBEe1Ku5Olg531yOzIB+dCJGL8uU4Lf44GoktV3dBNmKyeVkOTIuJ7cMV0EA4hN
         rcTTJVbFdwgsoDOx4fLkWerxaPeZb6F33gh+JEpagB8bKE/FmRMbnODKAMa0coDjYDqZ
         4BjkOPXxge1sCEh141rXpKRh4sAooMqCmZgsr22pRF9VCyPb2695owHUo7FbJ1nKjCGq
         vcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqWs6tnJsgPqdUO1RETz8iVY1LYxL4xOc0UaMWvwPg0=;
        b=G93dXunHnHAx0lQk+jgELGmUZn4cNp4qt+0K4aY7qvuzWTyhmD7vIM8AlMoOSqQVUp
         UP6ZETTETs/POyHe/JZM667W4pA+giwZDlAyebvEM5ekaZyJIzWrlqWkukRBvfcqNIiP
         i9Q5X0YD8J+qSJW2HngTEi3FMF6yKTWE1AcWi9UPi2bGMiEAqoYDagr/TY0wqQG9vAX+
         /uE8QvJX26od7viYX2dVjXw+x26n34/piNci/4pCezUNAcX7CTtNIigBis0Zn0ORZexR
         v4t2QGgZFjD9CfXKvhzEfU1SMrwFPvED7p8vMo8VI9OuyPlvXulCKh6qct9C8C4dhVkW
         RPFg==
X-Gm-Message-State: APjAAAU5O158LFZlx2NxPh1qPWMikIJCyzEoZjiTeC7CSRZR/cy2TpMF
        O3BZmx1OJYDNRXFZuot1QEkBLgI5uByFar2FPQ==
X-Google-Smtp-Source: APXvYqxVf+AvafI76eso5Vi9qaZvd/1ppBT5BDFcvn0IUAfeDjccWO8ASbUvznAJcvMELWLizujdPIuM3Zrv5fujIzE=
X-Received: by 2002:a2e:9dc1:: with SMTP id x1mr15382970ljj.0.1563225009574;
 Mon, 15 Jul 2019 14:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190529145742.GA8959@cisco> <CAHC9VhR4fudQanvZGYWMvCf7k2CU3q7e7n1Pi7hzC3v_zpVEdw@mail.gmail.com>
 <20190529153427.GB8959@cisco> <CAHC9VhSF3AjErX37+eeusJ7+XRw8yuPsmqBTRwc9EVoRBh_3Tw@mail.gmail.com>
 <20190529222835.GD8959@cisco> <CAHC9VhRS66VGtug3fq3RTGHDvfGmBJG6yRJ+iMxm3cxnNF-zJw@mail.gmail.com>
 <20190530170913.GA16722@mail.hallyn.com> <CAHC9VhThLiQzGYRUWmSuVfOC6QCDmA75BDB7Eg7V8HX4x7ymQg@mail.gmail.com>
 <20190530212900.GC5739@cisco> <CAHC9VhT5HPt9rCJoDutdvA3r1Y1GOHfpXe2eJ54atNC1=Vd8LA@mail.gmail.com>
 <20190708181237.5poheliito7zpvmc@madcap2.tricolour.ca>
In-Reply-To: <20190708181237.5poheliito7zpvmc@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Jul 2019 17:09:58 -0400
Message-ID: <CAHC9VhT0V+xi_6nAR5TsM2vs34LbgMeO=-W+MS_kqiXRRzneZQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 V6 02/10] audit: add container id
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        ebiederm@xmission.com, nhorman@tuxdriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 2:12 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-05-30 19:26, Paul Moore wrote:

...

> > I like the creativity, but I worry that at some point these
> > limitations are going to be raised (limits have a funny way of doing
> > that over time) and we will be in trouble.  I say "trouble" because I
> > want to be able to quickly do an audit container ID comparison and
> > we're going to pay a penalty for these larger values (we'll need this
> > when we add multiple auditd support and the requisite record routing).
> >
> > Thinking about this makes me also realize we probably need to think a
> > bit longer about audit container ID conflicts between orchestrators.
> > Right now we just take the value that is given to us by the
> > orchestrator, but if we want to allow multiple container orchestrators
> > to work without some form of cooperation in userspace (I think we have
> > to assume the orchestrators will not talk to each other) we likely
> > need to have some way to block reuse of an audit container ID.  We
> > would either need to prevent the orchestrator from explicitly setting
> > an audit container ID to a currently in use value, or instead generate
> > the audit container ID in the kernel upon an event triggered by the
> > orchestrator (e.g. a write to a /proc file).  I suspect we should
> > start looking at the idr code, I think we will need to make use of it.
>
> To address this, I'd suggest that it is enforced to only allow the
> setting of descendants and to maintain a master list of audit container
> identifiers (with a hash table if necessary later) that includes the
> container owner.

We're discussing the audit container ID management policy elsewhere in
this thread so I won't comment on that here, but I did want to say
that we will likely need something better than a simple list of audit
container IDs from the start.  It's common for systems to have
thousands of containers now (or multiple thousands), which tells me
that a list is a poor choice.  You mentioned a hash table, so I would
suggest starting with that over the list for the initial patchset.

-- 
paul moore
www.paul-moore.com
