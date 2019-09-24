Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D68BC8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504934AbfIXNT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 09:19:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbfIXNT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 09:19:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13EB23B708;
        Tue, 24 Sep 2019 13:19:28 +0000 (UTC)
Received: from x2.localnet (ovpn-117-6.phx2.redhat.com [10.3.117.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB04D1001B30;
        Tue, 24 Sep 2019 13:19:23 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-audit@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ntp audit spew.
Date:   Tue, 24 Sep 2019 09:19:23 -0400
Message-ID: <2130348.JY4ctgmguH@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
References: <20190923155041.GA14807@codemonkey.org.uk> <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 24 Sep 2019 13:19:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 23, 2019 12:14:14 PM EDT Paul Moore wrote:
> On Mon, Sep 23, 2019 at 11:50 AM Dave Jones <davej@codemonkey.org.uk> 
wrote:
> > I have some hosts that are constantly spewing audit messages like so:
> > 
> > [46897.591182] audit: type=1333 audit(1569250288.663:220): op=offset
> > old=2543677901372 new=2980866217213 [46897.591184] audit: type=1333
> > audit(1569250288.663:221): op=freq old=-2443166611284 new=-2436281764244
> > [48850.604005] audit: type=1333 audit(1569252241.675:222): op=offset
> > old=1850302393317 new=3190241577926 [48850.604008] audit: type=1333
> > audit(1569252241.675:223): op=freq old=-2436281764244 new=-2413071187316
> > [49926.567270] audit: type=1333 audit(1569253317.638:224): op=offset
> > old=2453141035832 new=2372389610455 [49926.567273] audit: type=1333
> > audit(1569253317.638:225): op=freq old=-2413071187316 new=-2403561671476
> > 
> > This gets emitted every time ntp makes an adjustment, which is apparently
> > very frequent on some hosts.
> > 
> > 
> > Audit isn't even enabled on these machines.
> > 
> > # auditctl -l
> > No rules
> 
> [NOTE: added linux-audit to the CC line]
> 
> There is an audit mailing list, please CC it when you have audit
> concerns/questions/etc.
> 
> What happens when you run 'auditctl -a never,task'? 

Actually, "-e 0" should turn it off. There is a general problem where systemd 
turns on auditing just because it can. The above rule just makes audit 
processes inauditable, but does not affect the kernel originating events.

-Steve

> That *should*
> silence those messages as the audit_ntp_log() function has the
> requisite audit_dummy_context() check.  FWIW, this is the distro
> default for many (most? all?) distros; for example, check
> /etc/audit/audit.rules on a stock Fedora system.  A more selective
> configuration could simply exclude the TIME_ADJNTPVAL record (type
> 1333) from the records that the kernel emits.
> 
> We could also add a audit_enabled check at the top of
> audit_ntp_log()/__audit_ntp_log(), but I imagine some of that depends
> on the various security requirements (they can be bizzare and I can't
> say I'm up to date on all those - Steve Grubb should be able to
> comment on that).




