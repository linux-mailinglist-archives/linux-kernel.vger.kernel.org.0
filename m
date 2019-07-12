Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA43066AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 12:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfGLKn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 06:43:59 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:53773
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbfGLKn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:43:59 -0400
X-IronPort-AV: E=Sophos;i="5.63,482,1557180000"; 
   d="scan'208";a="313309971"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2019 12:43:55 +0200
Date:   Fri, 12 Jul 2019 12:43:52 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Hannes Reinecke <hare@suse.de>
cc:     Colin King <colin.king@canonical.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: libfc: fix null pointer dereference on a null
 lport
In-Reply-To: <14c9e345-dd98-63e7-5ba2-679f10760fe6@suse.de>
Message-ID: <alpine.DEB.2.20.1907121243220.3900@hadrien>
References: <20190702091835.13629-1-colin.king@canonical.com> <14c9e345-dd98-63e7-5ba2-679f10760fe6@suse.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1695843507-1562928232=:3900"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8323329-1695843507-1562928232=:3900
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 12 Jul 2019, Hannes Reinecke wrote:

> On 7/2/19 11:18 AM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently if lport is null then the null lport pointer is dereference
> > when printing out debug via the FC_LPORT_DB macro. Fix this by using
> > the more generic FC_LIBFC_DBG debug macro instead that does not use
> > lport.
> >
> > Addresses-Coverity: ("Dereference after null check")
> > Fixes: 7414705ea4ae ("libfc: Add runtime debugging with debug_logging module parameter")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/scsi/libfc/fc_exch.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/scsi/libfc/fc_exch.c b/drivers/scsi/libfc/fc_exch.c
> > index 025cd2ff9f65..c477fadbf504 100644
> > --- a/drivers/scsi/libfc/fc_exch.c
> > +++ b/drivers/scsi/libfc/fc_exch.c
> > @@ -2591,8 +2591,8 @@ void fc_exch_recv(struct fc_lport *lport, struct fc_frame *fp)
> >
> >  	/* lport lock ? */
> >  	if (!lport || lport->state == LPORT_ST_DISABLED) {
> > -		FC_LPORT_DBG(lport, "Receiving frames for an lport that "
> > -			     "has not been initialized correctly\n");
> > +		FC_LIBFC_DBG("Receiving frames for an lport that "
> > +			     "has not been initialized correctly\n");

If the code is being changed, perhaps the string could be put onto one
line as well.

julia

> >  		fc_frame_free(fp);
> >  		return;
> >  	}
> >
> Reviewed-by: Hannes Reinecke <hare@suse.com>
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke		   Teamlead Storage & Networking
> hare@suse.de			               +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
> GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG Nürnberg)
>
--8323329-1695843507-1562928232=:3900--
