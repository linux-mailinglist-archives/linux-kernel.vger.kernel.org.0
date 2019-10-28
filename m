Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBE4E6E51
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 09:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbfJ1IgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 04:36:05 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:51440 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732003AbfJ1IgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:36:05 -0400
X-IronPort-AV: E=Sophos;i="5.68,239,1569276000"; 
   d="scan'208";a="408749677"
Received: from unknown (HELO hadrien) ([91.217.168.176])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 09:36:04 +0100
Date:   Mon, 28 Oct 2019 09:36:04 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Cristiane Naves <cristianenavescardoso09@gmail.com>,
        outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: Remove unneeded variable
In-Reply-To: <20191028082732.GE1944@kadam>
Message-ID: <alpine.DEB.2.21.1910280934430.2348@hadrien>
References: <20191026222453.GA14562@cristiane-Inspiron-5420> <20191028082732.GE1944@kadam>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Oct 2019, Dan Carpenter wrote:

> On Sat, Oct 26, 2019 at 07:24:53PM -0300, Cristiane Naves wrote:
> > Remove unneeded variable used to store return value. Issue found by
> > coccicheck.
> >
> > Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
> > ---
> >  drivers/staging/octeon/octeon-stubs.h | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> > index b07f5e2..d53bd801 100644
> > --- a/drivers/staging/octeon/octeon-stubs.h
> > +++ b/drivers/staging/octeon/octeon-stubs.h
> > @@ -1387,9 +1387,7 @@ static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
> >  		uint64_t queue, union cvmx_pko_command_word0 pko_command,
> >  		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
> >  {
> > -	cvmx_pko_status_t ret = 0;
> > -
> > -	return ret;
> > +	return 0;
>
> What is the point of this function anyway?

Given that it is in octeon-stubs.h, it seems that the point is to get the
code to compile when COMPILE_TEST is set.  There is a real definition in
arch/mips/include/asm/octeon/cvmx-pko.h

julia
