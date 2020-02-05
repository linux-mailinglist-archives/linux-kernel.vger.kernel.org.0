Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7F0F153B41
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 23:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBEWqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 17:46:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgBEWqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:46:10 -0500
Received: from localhost (unknown [193.117.204.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B15F2082E;
        Wed,  5 Feb 2020 22:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580942770;
        bh=hv6T71uUmvL/Bwp3JACY/D/S1uvhocjFb2xRovJ7rsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hyRT812zRw7D2xqxVZxF2DqYy25fMk3NwEKeHehj7dkfc4KW3fmNp37Ad+iT9FWZu
         /p2sqVVBNgP7k2INn1O3GM0GDPJDC6CCL2uKZ7Feckd+nZcq6Ve4UWrgc1GcaVUz2W
         oLjdyFEjY+cdaemnyYeJI4dQx/IXNwxD8gwGT9bQ=
Date:   Wed, 5 Feb 2020 22:46:08 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     James Morris <jmorris@namei.org>
Cc:     Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
        linux-kernel@vger.kernel.org, kys@microsoft.com,
        jamorris@microsoft.com
Subject: Re: [PATCH] Documentation/process: Change Microsoft contact for
 embargoed hardware issues
Message-ID: <20200205224608.GA1547731@kroah.com>
References: <20200205213621.31474-1-sashal@kernel.org>
 <20200205214716.GA1468203@kroah.com>
 <alpine.LRH.2.21.2002060854230.17039@namei.org>
 <20200205221203.GA1471886@kroah.com>
 <alpine.LRH.2.21.2002060919420.17039@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2002060919420.17039@namei.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 09:22:33AM +1100, James Morris wrote:
> On Wed, 5 Feb 2020, Greg KH wrote:
> 
> > > Add me for this: jamorris@linux.microsoft.com
> > 
> > Can you send me a patch please?
> > 
> 
> Sure.
> 
> >From 97a1a94c53ac2b840ad285f9e47929de764f0ffa Mon Sep 17 00:00:00 2001
> From: James Morris <jmorris@namei.org>
> Date: Wed, 5 Feb 2020 14:17:56 -0800
> Subject: [PATCH] [PATCH] Documentation/process: Change Microsoft contact for embargoed hardware issues
> 
> Update Microsoft contact from Sasha to James.
> 
> Signed-off-by: James Morris <jmorris@namei.org>
> ---
>  Documentation/process/embargoed-hardware-issues.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

In a format that I don't have to hand-edit to fix up to apply?  :)
