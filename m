Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F46518D36F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 17:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgCTQAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 12:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgCTQAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:00:40 -0400
Received: from coco.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D4F020739;
        Fri, 20 Mar 2020 16:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584720039;
        bh=OPX7ZO8XdqiJ3pBNxueMaQkzxx8QgkND10VWalu31ME=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IEyqH9TcePuGXHORtyUR9KDgBpOXXy72zESirAsUANr+PH49tOOvCm2aAImrHb1Mr
         vXsVm7aX2suMYZrUWKBY7MJ2Lz3R9hmBwCCtUpndewdUMNvkgAtlV0/WgDrDsndFPt
         BHi8ClBkjeZ1PQW166ifePoVzhx0u2QrK7VeR/qw=
Date:   Fri, 20 Mar 2020 17:00:35 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 04/17] kernel: futex.c: get rid of a docs build warning
Message-ID: <20200320170035.581f5095@coco.lan>
In-Reply-To: <87h7yj59m0.fsf@nanos.tec.linutronix.de>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
        <aab1052263e340a3eada5522f32be318890314a1.1584456635.git.mchehab+huawei@kernel.org>
        <87h7yj59m0.fsf@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 20 Mar 2020 16:28:23 +0100
Thomas Gleixner <tglx@linutronix.de> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> The subject prefix for this is: 'futex:'

Ok!

> 
> > Adjust whitespaces and blank lines in order to get rid of this:
> >
> > 	./kernel/futex.c:491: WARNING: Definition list ends without a blank line; unexpected unindent.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  kernel/futex.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/futex.c b/kernel/futex.c
> > index 67f004133061..dda6ddbc2e7d 100644
> > --- a/kernel/futex.c
> > +++ b/kernel/futex.c
> > @@ -486,7 +486,8 @@ static u64 get_inode_sequence_number(struct inode *inode)
> >   * The key words are stored in @key on success.
> >   *
> >   * For shared mappings (when @fshared), the key is:
> > - *   ( inode->i_sequence, page->index, offset_within_page )
> > + * ( inode->i_sequence, page->index, offset_within_page )  
> 
> Sigh. Is there no better way to make this look sane both in the file and
> in the docs?

The enclosed patch would do the trick.

I noticed another problem on it, however: "!@fshared" is not properly
parsed by kernel-docs. It basically converts it to "!**fshared**", with is
not what we want.

IMHO, this specific case should be handled by kernel-doc script. I'll
write a patch addressing this issue.

Regards,
Mauro

---


[PATCH 04/17 v2] kernel: futex: get rid of a docs build warning

Adjust whitespaces and blank lines in order to get rid of this:

	./kernel/futex.c:491: WARNING: Definition list ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/kernel/futex.c b/kernel/futex.c
index 67f004133061..81ad379cbadf 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -486,10 +486,13 @@ static u64 get_inode_sequence_number(struct inode *inode)
  * The key words are stored in @key on success.
  *
  * For shared mappings (when @fshared), the key is:
+ *
  *   ( inode->i_sequence, page->index, offset_within_page )
+ *
  * [ also see get_inode_sequence_number() ]
  *
  * For private mappings (or when !@fshared), the key is:
+ *
  *   ( current->mm, address, 0 )
  *
  * This allows (cross process, where applicable) identification of the futex

