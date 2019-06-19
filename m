Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72A74BAF5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 16:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfFSOPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 10:15:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSOPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NBYZM4x4vonQf9U9PegTdJ8Gr3lWbvulPmcaW6blw1o=; b=dPqOh1g1u6+Gx0sBalb5rkX2u
        wIbBMtAEdIsAee3Ub7W9KYWOgt2mtCWo8S4Q3A8BuyYcZpFXJIBFKLK93DcM0OgM4m/inlhuMxd4i
        xv4bXL13yE2S6AOwvmz7dbVWGoNRlTOpVocD4rVyrbv1GF1YVK56MDdeJUJ2TJdyUU/i7LDzPPxwk
        q5bBzKUGnZGKBhiO1stiWprfqZmaUIaVdpkulYzUlK2rGWSYmI7ne0f+vptRKQfKdDsKioHcQ3HVY
        ZLJmnIxZLL9Wg8XwEkfcleJ+3FQYhKRtXa8W53asUfOJcitK/KfLJc7dkOM7cGkK88AajNUpeKd7M
        OSliQfZFw==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdbN5-0002AD-M9; Wed, 19 Jun 2019 14:15:32 +0000
Date:   Wed, 19 Jun 2019 11:15:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main
 dir
Message-ID: <20190619111528.3e2665e3@coco.lan>
In-Reply-To: <11422.1560951550@warthog.procyon.org.uk>
References: <20190619072218.4437f891@coco.lan>
        <cover.1560890771.git.mchehab+samsung@kernel.org>
        <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
        <CAKMK7uGM1aZz9yg1kYM8w2gw_cS6Eaynmar-uVurXjK5t6WouQ@mail.gmail.com>
        <11422.1560951550@warthog.procyon.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Em Wed, 19 Jun 2019 14:39:10 +0100
David Howells <dhowells@redhat.com> escreveu:

> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > > > -Documentation/nommu-mmap.rst
> > > > +Documentation/driver-api/nommu-mmap.rst    
> 
> Why is this moving to Documentation/driver-api?  

Good point. I tried to do my best with those document renames, but
I'm pretty sure some of them ended by going to the wrong place - or
at least there are arguments in favor of moving it to different
places :-)

The driver-api ended to be where most of the stuff has been moved,
as this is the main kAPI dir (there is also a core-api dir for kAPI too).

I tend to place there stuff that has a mix of kAPI and uAPI at
driver-api, as usually such documents are written assuming that
the one that would be reading it is a Kernel developer.

> It's less to do with drivers
> than with the userspace mapping interface.  Documentation/vm/ would seem a
> better home.
> 
> Or should we institute a Documentation/uapi/?  Though that might be seen to
> overlap with man2.  Actually, should this be in man7?

Actually, there is an userspace-api dir too. While the logs show that
this was created back on 2017, I only noticed it very recently.

Re-checking the file, I see your point: there are lots of
userspace-relevant contents there. Yet, it also mentions kAPI internals,
like a reference for file and vm ops (at "Providing shareable character
device support" session):

	file->f_op->get_unmapped_area()
	file->f_op->mmap()
	vm_ops->close()

It is up to MM people and Jon to decide where to place it.

In any case, the best (long term) seems to split it on separate files, 
one with kAPI and another one with uAPI (just like may other subsystem
specific docs).

Thanks,
Mauro
