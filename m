Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B0B2C0CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 10:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfE1IGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 04:06:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:43455 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfE1IGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:06:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 01:06:15 -0700
X-ExtLoop1: 1
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 28 May 2019 01:06:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 28 May 2019 11:06:12 +0300
Date:   Tue, 28 May 2019 11:06:12 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ajay Gupta <ajayg@nvidia.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: ccg: fix memory leak in do_flash
Message-ID: <20190528080612.GC7167@kuha.fi.intel.com>
References: <20190527181050.GA31496@embeddedor>
 <20190528080452.GB7167@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528080452.GB7167@kuha.fi.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 11:04:52AM +0300, Heikki Krogerus wrote:
> On Mon, May 27, 2019 at 01:10:50PM -0500, Gustavo A. R. Silva wrote:
> > In case memory resources for *fw* were successfully allocated,
> > release them before return.
> > 
> > Addresses-Coverity-ID: 1445499 ("Resource leak")
> > Fixes: 5c9ae5a87573 ("usb: typec: ucsi: ccg: add firmware flashing support")
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Acked-by: Heikki Krogerus <heikki.krogerus@gmail.com>

That email address does not actually exist :-/. Sorry.

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


> > ---
> >  drivers/usb/typec/ucsi/ucsi_ccg.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> > index 9d46aa9e4e35..bf63074675fc 100644
> > --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> > +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> > @@ -862,8 +862,10 @@ static int do_flash(struct ucsi_ccg *uc, enum enum_flash_mode mode)
> >  
> >  not_signed_fw:
> >  	wr_buf = kzalloc(CCG4_ROW_SIZE + 4, GFP_KERNEL);
> > -	if (!wr_buf)
> > -		return -ENOMEM;
> > +	if (!wr_buf) {
> > +		err = -ENOMEM;
> > +		goto release_fw;
> > +	}
> >  
> >  	err = ccg_cmd_enter_flashing(uc);
> >  	if (err)
> > -- 
> > 2.21.0

-- 
heikki
