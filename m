Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2527CC188
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 19:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbfJDRWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 13:22:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfJDRWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:22:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05BB8C00A167;
        Fri,  4 Oct 2019 17:22:08 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE39760852;
        Fri,  4 Oct 2019 17:22:07 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id DF45A4EE68;
        Fri,  4 Oct 2019 17:22:07 +0000 (UTC)
Date:   Fri, 4 Oct 2019 13:22:07 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     aliasgar surti500 <aliasgar.surti500@gmail.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <312248413.4882810.1570209727854.JavaMail.zimbra@redhat.com>
In-Reply-To: <1944905967.4863703.1570204154537.JavaMail.zimbra@redhat.com>
References: <20191002174631.15919-1-aliasgar.surti500@gmail.com> <1944905967.4863703.1570204154537.JavaMail.zimbra@redhat.com>
Subject: Re: [Cluster-devel] [PATCH] gfs2: removed unnecessary semicolon
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.219, 10.4.195.17]
Thread-Topic: gfs2: removed unnecessary semicolon
Thread-Index: 5pT+PabUEhpG6HUEs4rjxCBeLgtPV2X/eonn
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 04 Oct 2019 17:22:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> ----- Original Message -----
> > From: Aliasgar Surti <aliasgar.surti500@gmail.com>
> > 
> > There is use of unnecessary semicolon after switch case.
> > Removed the semicolon.
> > 
> > Signed-off-by: Aliasgar Surti <aliasgar.surti500@gmail.com>
> > ---
> >  fs/gfs2/recovery.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
> > index c529f8749a89..f4aa8551277b 100644
> > --- a/fs/gfs2/recovery.c
> > +++ b/fs/gfs2/recovery.c
> > @@ -326,7 +326,7 @@ void gfs2_recover_func(struct work_struct *work)
> >  
> >  		default:
> >  			goto fail;
> > -		};
> > +		}
> >  
> >  		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
> >  					   LM_FLAG_NOEXP | GL_NOCACHE, &ji_gh);
> > --
> > 2.17.1
> 
> Hi,
> 
> Thanks for the patch. I did a quick search and found two more:
> 
> glops.c-                break;
> glops.c:        };
> 
> inode.c-                        goto out_gunlock;
> inode.c:                };
> 
> Do you want to include those in your patch and re-submit it or
> should I cook up a second patch?

Hi,

I just went ahead and added the two above to your patch and pushed
it to for-next. Thanks.

Regards,

Bob Peterson
