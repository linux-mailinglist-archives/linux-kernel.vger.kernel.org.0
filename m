Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E873E5E59
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 20:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfJZSCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 14:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfJZSC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 14:02:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5744C20663;
        Sat, 26 Oct 2019 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572112947;
        bh=736+3LKuV8NtSBzw5PYMu27jhPpKvZMpTRt5u2a7cNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ns2I7xmQ15+dgUq66GGoqTdRNEHOsz7OTxkXYI37ZVyVgtbTxSVjo3gQqqWUmy3jR
         zbKP66vg/fgJZZwAsvrCLT2PBZdR5d4iZMV2jzhCMe7vE4EjkLGlimiMde76g163qb
         rG7IZi6dn2OQZtUaAAK2KweuGVgem/50FiFO06cM=
Date:   Sat, 26 Oct 2019 20:02:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristiane Naves <cristianenavescardoso09@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [RESEND PATCH] staging: gasket: Fix line ending with a '('
Message-ID: <20191026180225.GA645771@kroah.com>
References: <20191025233909.GA1599@cristiane-Inspiron-5420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025233909.GA1599@cristiane-Inspiron-5420>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 08:39:09PM -0300, Cristiane Naves wrote:
> Fix line ending with a '('
> 
> Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
> ---
>  drivers/staging/gasket/gasket_ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Why is this a "RESEND"?  Did nothing change in it?

Always version your patches, as the documentation suggests, and list
below the --- line what changed from the previous version.

Please fix up and resend it as a v3 (this is v2, right?)

thanks,

greg k-h
