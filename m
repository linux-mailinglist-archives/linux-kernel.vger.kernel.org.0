Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E665C178ACC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 07:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbgCDGsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 01:48:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgCDGsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 01:48:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209672146E;
        Wed,  4 Mar 2020 06:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583304490;
        bh=yN/luUhk9sZoRMguRNrPehHcGwLuSq+z6P8y708HX2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HBBKqHXsUn20IUYFP2Ot0oMeIMRYHgdsk3+a8f3tf9+j1gCZ/Iu/mNx0bV0uV3xXH
         N4nT5SSgkiCRKCxdKecVGABm89b8blckrPmV4kVqxTOC9Gx/uBlXson80BcbCNEUDL
         hhg8Zoo/TJZHir1QF8jmUBQwSrk3vFVmXaftmmvI=
Date:   Wed, 4 Mar 2020 07:48:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Cc:     Joe Perches <joe@perches.com>, jerome.pouiller@silabs.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wfx: data_tx.c: match parentheses alignment
Message-ID: <20200304064808.GA1232166@kroah.com>
References: <20200223193201.GA20843@kaaira-HP-Pavilion-Notebook>
 <8c458c189abb45fb3021f7882a40d28a24cc662d.camel@perches.com>
 <20200224162621.GA6611@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224162621.GA6611@kaaira-HP-Pavilion-Notebook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 09:56:21PM +0530, Kaaira Gupta wrote:
> On Mon, Feb 24, 2020 at 06:13:32AM -0800, Joe Perches wrote:
> > On Mon, 2020-02-24 at 01:02 +0530, Kaaira Gupta wrote:
> > > Match next line with open parentheses by giving appropriate tabs.
> 
> Changed the first word to caps. Will keep this in mind from now on.
> Thanks!
> 

There was no "v2" patch in this email, what happened to it?

I've dropped this thread now, please resend the patch if you have an
updated version.

thanks,

greg k-h
