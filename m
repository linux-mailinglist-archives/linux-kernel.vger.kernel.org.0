Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D784DBBC61
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 21:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502362AbfIWTtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 15:49:04 -0400
Received: from scorn.kernelslacker.org ([45.56.101.199]:49876 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfIWTtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:49:03 -0400
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1iCUKU-0003vq-1Z; Mon, 23 Sep 2019 15:49:02 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 9B7E3560162; Mon, 23 Sep 2019 15:49:01 -0400 (EDT)
Date:   Mon, 23 Sep 2019 15:49:01 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com
Subject: Re: ntp audit spew.
Message-ID: <20190923194901.GA2787@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com
References: <20190923155041.GA14807@codemonkey.org.uk>
 <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
 <20190923165806.GA21466@codemonkey.org.uk>
 <CAHC9VhTh+cD5pkb8JAHnG1wa9-UgivSb7+-yjjYaD+6vhyYKjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTh+cD5pkb8JAHnG1wa9-UgivSb7+-yjjYaD+6vhyYKjA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 02:57:08PM -0400, Paul Moore wrote:
 > On Mon, Sep 23, 2019 at 12:58 PM Dave Jones <davej@codemonkey.org.uk> wrote:
 > > On Mon, Sep 23, 2019 at 12:14:14PM -0400, Paul Moore wrote:
 > >  > On Mon, Sep 23, 2019 at 11:50 AM Dave Jones <davej@codemonkey.org.uk> wrote:
 > >  > >
 > >  > > I have some hosts that are constantly spewing audit messages like so:
 > >  > >
 > >  > > [46897.591182] audit: type=1333 audit(1569250288.663:220): op=offset old=2543677901372 new=2980866217213
 > >  > > [46897.591184] audit: type=1333 audit(1569250288.663:221): op=freq old=-2443166611284 new=-2436281764244
 > >  > > [48850.604005] audit: type=1333 audit(1569252241.675:222): op=offset old=1850302393317 new=3190241577926
 > >  > > [48850.604008] audit: type=1333 audit(1569252241.675:223): op=freq old=-2436281764244 new=-2413071187316
 > >  > > [49926.567270] audit: type=1333 audit(1569253317.638:224): op=offset old=2453141035832 new=2372389610455
 > >  > > [49926.567273] audit: type=1333 audit(1569253317.638:225): op=freq old=-2413071187316 new=-2403561671476
 > >  > >
 > >  > > This gets emitted every time ntp makes an adjustment, which is apparently very frequent on some hosts.
 > >  > >
 > >  > >
 > >  > > Audit isn't even enabled on these machines.
 > >  > >
 > >  > > # auditctl -l
 > >  > > No rules
 > >  >
 > >  > What happens when you run 'auditctl -a never,task'?  That *should*
 > >  > silence those messages as the audit_ntp_log() function has the
 > >  > requisite audit_dummy_context() check.
 > >
 > > They still get emitted.
 > >
 > >  > FWIW, this is the distro
 > >  > default for many (most? all?) distros; for example, check
 > >  > /etc/audit/audit.rules on a stock Fedora system.
 > >
 > > As these machines aren't using audit, they aren't running auditd either.
 > > Essentially: nothing enables audit, but the kernel side continues to log
 > > ntp regardless (no other audit messages seem to do this).
 > 
 > What does your kernel command line look like?  Do you have "audit=1"
 > somewhere in there?

nope.

ro root=LABEL=/ biosdevname=0 net.ifnames=0 fsck.repair=yes systemd.gpt_auto=0 pcie_pme=nomsi ipv6.autoconf=0 erst_disable crashkernel=128M console=tty0 console=ttyS1,57600 intel_iommu=tboot_noforce

	Dave

