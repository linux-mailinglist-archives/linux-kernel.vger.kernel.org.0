Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5227E46E8E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2019 08:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfFOGQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jun 2019 02:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfFOGQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 02:16:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 628282184C;
        Sat, 15 Jun 2019 06:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560579366;
        bh=BjtkEmRJtAtHKEHwhGfkDFvic+g9qJNlH8cwQrXk1/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vd9RF7LOMmXbG79sY4uZhNiG2CZedC82zVAmk/8XnMhtyblNBvzhxgpVw5i30L9Np
         0m4nFT6POp7H5TTQQn6IL3ZU23ghGL0Lejze1Lh5vcmFln8nrZz10XTDOxksVYtn6C
         pAle1+Pbjhp3sSeMa9qKEut95kqunfd7r4qrP5ok=
Date:   Sat, 15 Jun 2019 08:16:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 14/14] docs: sphinx/kernel_abi.py: fix UTF-8 support
Message-ID: <20190615061604.GA31006@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <62c8ffe86df40c90299e80619a1cb5d50971c2c6.1560477540.git.mchehab+samsung@kernel.org>
 <20190614161837.GA25206@kroah.com>
 <20190614132530.7a013757@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614132530.7a013757@coco.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 01:25:30PM -0300, Mauro Carvalho Chehab wrote:
> Em Fri, 14 Jun 2019 18:18:37 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> 
> > On Thu, Jun 13, 2019 at 11:04:20PM -0300, Mauro Carvalho Chehab wrote:
> > > The parser breaks with UTF-8 characters with Sphinx 1.4.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > ---
> > >  Documentation/sphinx/kernel_abi.py | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
> > > index 7fa7806532dc..460cee48a245 100644
> > > --- a/Documentation/sphinx/kernel_abi.py
> > > +++ b/Documentation/sphinx/kernel_abi.py
> > > @@ -1,4 +1,5 @@
> > > -# -*- coding: utf-8; mode: python -*-
> > > +# coding=utf-8
> > > +#  
> > 
> > Is this an emacs vs. vim fight?
> 
> No. This is a python-specific thing:
> 
> 	https://www.python.org/dev/peps/pep-0263/

Ah, thanks, didn't know that.

greg k-h
