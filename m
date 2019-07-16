Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D9E6A8DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 14:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfGPMkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 08:40:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPMkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 08:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k7uNjGYc5NGW86U1WwRqV0gayXTomQeitE9Om1/SzOk=; b=u1ZS6tKNBRD5Lu81RQ1RdVPM3
        G6YKyiYLYqejgDbPnCYdCEltx0Vy2Ft9wL4QrGxzSdU7fxeQNDu42H84Rh6Fz2em46n6Hg3gnYLnf
        f5mFBK4Y31pL0QEBy0tiHM8MmtgyC9jAnd5DKhfo5o3wPtOr/3VttlPVyskHlYiUpP0/2c/Var7ME
        FIvfU8YSOKXyyAs9N3LJJbfQCCvWmWx1OrHbWbzz8beeJk0Uqbp9sFdPKo8haejP5vYv6ywojPdrW
        m+ICy4XmMmWh/jBBOV39BcNGvo0qbXBfx8Kjs8B3zACHU6u7qe2KFeqeFqR5yx+2VCA2RfxUkYkQ8
        XeAxwPEJA==;
Received: from [189.27.46.152] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnMlH-0007gL-6Y; Tue, 16 Jul 2019 12:40:51 +0000
Date:   Tue, 16 Jul 2019 09:40:47 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rdma tree with the v4l-dvb-next
 tree
Message-ID: <20190716094047.38e0074b@coco.lan>
In-Reply-To: <20190716122637.GA29741@mellanox.com>
References: <20190716104614.2ec8b57c@canb.auug.org.au>
        <20190716122637.GA29741@mellanox.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 16 Jul 2019 12:26:40 +0000
Jason Gunthorpe <jgg@mellanox.com> escreveu:

> On Tue, Jul 16, 2019 at 10:46:14AM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the rdma tree got a conflict in:
> > 
> >   Documentation/index.rst
> > 
> > between commit:
> > 
> >   09fdc957ad0d ("docs: leds: add it to the driver-api book")
> > (and others following)
> > 
> > from the v4l-dvb-next tree and commit:
> > 
> >   a3a400da206b ("docs: infiniband: add it to the driver-api bookset")
> > 
> > from the rdma tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.  
> 
> I'm surprised this is coming from a v4l tree..

Jon asked me to send a pull request with the pending conversion
patches. I opted to apply them to my v4l-dvb-next tree, just because
it was the simplest way of having those at linux-next :-)

> 
> > diff --cc Documentation/index.rst
> > index f379e43fcda0,869616b57aa8..000000000000
> > --- a/Documentation/index.rst
> > +++ b/Documentation/index.rst
> > @@@ -96,23 -90,9 +96,24 @@@ needed)
> >   
> >      driver-api/index
> >      core-api/index
> >  +   locking/index
> >  +   accounting/index
> >  +   block/index
> >  +   cdrom/index
> >  +   ide/index
> >  +   fb/index
> >  +   fpga/index
> >  +   hid/index
> >  +   iio/index
> >  +   leds/index
> > +    infiniband/index  
> 
> This should be kept sorted, Mauro rdma is already merged you'll need
> to tell Linus about this trivial conflict when you send your patches.

Yeah, I placed a comment about that at the pull request I sent
earlier today.

In any case, this is a simple conflict. It should be trivial for
Linus to address it.

Thanks,
Mauro
