Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 040BD18A71E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 22:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgCRVdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 17:33:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27864 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726776AbgCRVdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584567225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BMvSq0aaD1F6KooQQFFReSXOA3xWD0kLhG1e6rpiSpM=;
        b=cfvSWpNgc1Vj8+kCOFVmAQBwGhQnxO0sfVBA8QZm3SMVBh7agiHb5YJBJFdBjsBfd3ODTa
        I6120bLMwoL16o0tv2UMkPOcF15+IN+4zAuhYTRd/UMYIV6+wSTLRUCY+QTiaLu1Z5En+J
        CazdKw0WNH9sJpKs+DYEGYYh4Mv5DmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-1IIGxNciM9CpuoSVsU5Ytw-1; Wed, 18 Mar 2020 17:33:43 -0400
X-MC-Unique: 1IIGxNciM9CpuoSVsU5Ytw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BC61800D5B;
        Wed, 18 Mar 2020 21:33:42 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.36.110.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDF0C5D9E5;
        Wed, 18 Mar 2020 21:33:31 +0000 (UTC)
Date:   Wed, 18 Mar 2020 17:33:27 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, twoerner@redhat.com,
        Eric Paris <eparis@parisplace.org>, fw@strlen.de,
        ebiederm@xmission.com, tgraf@infradead.org
Subject: Re: [PATCH ghak25 v3 3/3] audit: add subj creds to NETFILTER_CFG
 record to cover async unregister
Message-ID: <20200318213327.ow22q6nnjn3ijq6v@madcap2.tricolour.ca>
References: <cover.1584480281.git.rgb@redhat.com>
 <13ef49b2f111723106d71c1bdeedae09d9b300d8.1584480281.git.rgb@redhat.com>
 <20200318131128.axyddgotzck7cit2@madcap2.tricolour.ca>
 <CAHC9VhTdLZop0eT11H4uSXRj5M=kBet=GkA8taDwGN_BVMyhrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTdLZop0eT11H4uSXRj5M=kBet=GkA8taDwGN_BVMyhrQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-18 17:22, Paul Moore wrote:
> On Wed, Mar 18, 2020 at 9:12 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2020-03-17 17:30, Richard Guy Briggs wrote:
> > > Some table unregister actions seem to be initiated by the kernel to
> > > garbage collect unused tables that are not initiated by any userspace
> > > actions.  It was found to be necessary to add the subject credentials to
> > > cover this case to reveal the source of these actions.  A sample record:
> > >
> > >   type=NETFILTER_CFG msg=audit(2020-03-11 21:25:21.491:269) : table=nat family=bridge entries=0 op=unregister pid=153 uid=root auid=unset tty=(none) ses=unset subj=system_u:system_r:kernel_t:s0 comm=kworker/u4:2 exe=(null)
> >
> > Given the precedent set by bpf unload, I'd really rather drop this patch
> > that adds subject credentials.
> >
> > Similarly with ghak25's subject credentials, but they were already
> > present and that would change an existing record format, so it isn't
> > quite as justifiable in that case.
> 
> Your comments have me confused - do you want this patch (v3 3/3)
> considered for merging or no?

I would like it considered for merging if you think it will be required
to provide enough information about the event that happenned.  In the
bpf unload case, there is a program number to provide a link to a
previous load action.  In this case, we won't know for sure what caused
the table to be unloaded if the number of entries was empty.  I'm still
trying to decide if it matters.  For the sake of caution I think it
should be included.  I don't like it, but I think it needs to be
included.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

