Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE304C826
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 09:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfFTHQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 03:16:51 -0400
Received: from mail180-24.suw31.mandrillapp.com ([198.2.180.24]:16363 "EHLO
        mail180-24.suw31.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbfFTHQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:In-Reply-To:References:Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=LMg3Bk6kln69Vs5t8MxVxPy3A99uh33UqnDkBfEpokk=;
 b=Eqt/oafqB0/S7B51V8T5s4mI2wlX5qECgmIaI91Q0OZx8pORHB1WbBe+dDnA5ExRud7MnENLTdjI
   T+HhJyEtOPjawdUrGn+LuVI+kkouESm8bN5ym8UZRIhPMIsYdV9fYm3Hc5EvG2toKoMlmhQdviG3
   2IK0jk4wEFlZJG6dFds=
Received: from pmta03.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail180-24.suw31.mandrillapp.com id h1cpdo22sc00 for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 07:01:44 +0000 (envelope-from <bounce-md_31050260.5d0b2f57.v1-1cf7cd72e6274ddeafb0967d931fd70d@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1561014103; h=From : 
 Subject : To : Cc : In-Reply-To : References : Message-Id : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=LMg3Bk6kln69Vs5t8MxVxPy3A99uh33UqnDkBfEpokk=; 
 b=h0ITYzP1NEgCkRQPorkXWYej5GuBGP9yK+Lh6k/2h2rbLPhhuZcTKQqwLTaFHt5WVkvuHA
 oGH9454xxVgw0crxSvCJbYUKJDbMHcYLwTWBbFZzJlKZsEf8D8kcQMPC7b04yRjoqW/ARbgx
 +ZqRiJbXcmhqG4Rb3gkOuGPyN0l8Y=
From:   <kirr@nexedi.com>
Subject: Re: [PATCH] pci/switchtec: fix stream_open.cocci warnings (fwd)
Received: from [87.98.221.171] by mandrillapp.com id 1cf7cd72e6274ddeafb0967d931fd70d; Thu, 20 Jun 2019 07:01:43 +0000
X-Sender: kirr@nexedi.com
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kbuild-all@01.org>
In-Reply-To: <20190619201859.GA197717@google.com>
References: <alpine.DEB.2.20.1906191227430.3726@hadrien> <20190619162713.GA19859@deco.navytux.spb.ru> <20190619201859.GA197717@google.com>
Message-Id: <e6568b7107d4cbef639f82a400ba8b1a@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.1cf7cd72e6274ddeafb0967d931fd70d
X-Mandrill-User: md_31050260
Date:   Thu, 20 Jun 2019 07:01:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-06-19 23:19:
> On Wed, Jun 19, 2019 at 04:27:52PM +0000, Kirill Smelkov wrote:
>> Hi Julia, everyone.
>> 
>> On Wed, Jun 19, 2019 at 12:28:47PM +0200, Julia Lawall wrote:
>> > Hi,
>> >
>> > Can you forward this patch to the people below if you think it is
>> > appropriate?
>> 
>> Yes, this patch is appropriate. It was actually part of
>> git.kernel.org/linus/c5bf68fe0c86 . It should be safe, (and desirable 
>> as
>> it removes a chance for deadlock) to apply it.
>> 
>> Sebastian, Kurt, Logan, Bjorn, please consider picking it up.
> 
> I don't get it.  This appeared in v5.2-rc1 as c5bf68fe0c86 ("*: convert
> stream-like files from nonseekable_open -> stream_open"), so it looks 
> like
> this is already done.  What would you like me to do with it?

I meant just that it was ok to pick this change into 5.0-RT tree as 
kbuild robot was suggesting. Sorry for not being clear.

Kirill

>> > Could I tell the kbuild people to add you to the CC list for
>> > this semantic patch?
>> 
>> Yes, sure. Please feel free to add me to CC list for stream_open.cocci
>> related patches.
>> 
>> Kirill
>> 
>> 
>> > thanks,
>> > julia
>> >
>> > ---------- Forwarded message ----------
>> > Date: Wed, 19 Jun 2019 18:23:18 +0800
>> > From: kbuild test robot <lkp@intel.com>
>> > To: kbuild@01.org
>> > Cc: Julia Lawall <julia.lawall@lip6.fr>
>> > Subject: [PATCH] pci/switchtec: fix stream_open.cocci warnings
>> >
>> > CC: kbuild-all@01.org
>> > TO: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> > CC: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
>> > CC: Logan Gunthorpe <logang@deltatee.com>
>> > CC: Bjorn Helgaas <helgaas@kernel.org>
>> > CC: linux-pci@vger.kernel.org
>> > CC: linux-kernel@vger.kernel.org
>> >
>> > From: kbuild test robot <lkp@intel.com>
>> >
>> > drivers/pci/switch/switchtec.c:395:1-17: ERROR: switchtec_fops: .read(=
) can deadlock .write(); change nonseekable_open -> stream_open to fix.
>> >
>> > Generated by: scripts/coccinelle/api/stream_open.cocci
>> >
>> > Fixes: a3a1e895d4fa ("pci/switchtec: Don't use completion's wait queue=
")
>> > Signed-off-by: kbuild test robot <lkp@intel.com>
>> > ---
>> >
>> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-de=
vel.git linux-5.0.y-rt-rebase
>> > head:   31cc76d5590f5e60c2f26f029e40bc7d0441d93f
>> > commit: a3a1e895d4fa0508e11ac9107ace883a5b2a4d3b [171/305] pci/switcht=
ec: Don't use completion's wait queue
>> > :::::: branch date: 6 days ago
>> > :::::: commit date: 6 days ago
>> >
>> > Please take the patch only if it's a positive warning. Thanks!
>> >
>> >  switchtec.c |    2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > --- a/drivers/pci/switch/switchtec.c
>> > +++ b/drivers/pci/switch/switchtec.c
>> > @@ -392,7 +392,7 @@ static int switchtec_dev_open(struct ino
>> >  =09=09return PTR_ERR(stuser);
>> >
>> >  =09filp->private_data =3D stuser;
>> > -=09nonseekable_open(inode, filp);
>> > +=09stream_open(inode, filp);
>> >
>> >  =09dev_dbg(&stdev->dev, "%s: %p\n", __func__, stuser);
>> >

