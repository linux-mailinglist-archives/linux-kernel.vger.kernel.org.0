Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A1314726C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 21:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgAWUL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 15:11:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29712 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726376AbgAWUL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 15:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579810314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AruOByNj78PEkwXtGFEjZ4URz4q7nBfl4M0qRCZx/p8=;
        b=KKa2YHOi/dJvYBWoAUuvPerjUXHWZ2S3fFiDEsrX5C5+RACZ1gTBjudMEKoWRnYoEopcoo
        hWb/8r/0DXq9bylRFVn4A08S04RUQLPPb6K4DoY+k+NIofu4k1UYfy/lkXuuTI2W1cd5kN
        JjgYRvdUI7c/+PpXsGsjfgGAwMpwt+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-Gt2aN6qtNlqpPyigc8z4NA-1; Thu, 23 Jan 2020 15:11:51 -0500
X-MC-Unique: Gt2aN6qtNlqpPyigc8z4NA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF425100551B;
        Thu, 23 Jan 2020 20:11:49 +0000 (UTC)
Received: from x2.localnet (ovpn-116-176.phx2.redhat.com [10.3.116.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4DBC5DA89;
        Thu, 23 Jan 2020 20:11:42 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-audit@redhat.com
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, nhorman@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ghak28 V4] audit: log audit netlink multicast bind and unbind events
Date:   Thu, 23 Jan 2020 15:11:42 -0500
Message-ID: <2543770.gFq7b6OZdx@x2>
Organization: Red Hat
In-Reply-To: <20200123161349.z55l2dd7qsyhoxbn@madcap2.tricolour.ca>
References: <ca70ee17d85860aa599e0001a75d639d819de7ae.1579292286.git.rgb@redhat.com> <CAHC9VhTcv9E8DUDJ2Y-PzXmU0_+ufVydbPB3Q_Fhb8-7TUZMmg@mail.gmail.com> <20200123161349.z55l2dd7qsyhoxbn@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 23, 2020 11:13:49 AM EST Richard Guy Briggs wrote:
> Steve, can you say why this order should be the standard?  From:
>         http://people.redhat.com/sgrubb/audit/record-fields.html

The majority of events go down the path of:
pid,uid,auid,ses,subj,op,comm,exe,res

Which lands on the parse_user() function.

If for some reason we really wanted to stay on a "kernel" parser, then I'd 
recommend:
auid,uid,ses,subj,pid,comm,exe,op,res

which lands on the parse_kernel_anom() function.

Either of those have complete information and requires no syscall record.

-Steve


> I get:
>         SYSCALL/ANOM_LINK/FEATURE_CHANGE
>                 ppid    pid     auid    uid     gid     euid    suid   
> fsuid   egid    sgid    fsgid   tty     ses     comm    exe     subj
> ANOM_ABEND/SECCOMP
>                                 auid    uid     gid     ses     subj    pid
>     comm    exe LOGIN
>                 pid     uid     subj    old-auid        auid    tty    
> old-ses ses SYSTEM_BOOT/SYSTEM_SHUTDOWN
>                 pid     uid     auid    ses     subj    comm    exe
>         USER_LOGIN
>                 pid     uid     auid    ses     subj    uid     exe
>         DAEMON_START
>                                 auid    pid     uid     ses     subj
>         DAEMON_CONFIG/DAEMON_END
>                                 auid    pid     subj
>         ANOM_PROMISCUOUS
>                                 auid    uid     gid     ses
>         52msgs
>                 pid     uid     auid    ses     subj    *
>         CONFIG_CHANGE
>                                 auid    ses     subj
> 
> This new record is:
>         EVENT_LISTENER
>                 pid     uid     auid    tty     ses     subj    comm    exe
> 
> And using the search criteria following, I get no other matches:
>         /pid.*uid.*auid.*tty.*ses.*subj.*comm.*exe
> so this appears to be a new field order.




