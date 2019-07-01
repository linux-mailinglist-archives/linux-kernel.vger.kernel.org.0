Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E25929250
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 10:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389392AbfEXICE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 04:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388960AbfEXICD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:02:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C30A20879;
        Fri, 24 May 2019 08:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558684923;
        bh=vrI2w4bCtBVKfEqYgeIaQRqwpP4Fb94jIUkDHbH/c2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHZsXyagXDTctt2cCFh7NrW8NeeaYLm48PggtIM7D52b6/dSVHIOcjykEaYm1Hr6Z
         mT4a9ag6PEMXThiCy/A1n0e0fOnRQknQgGl+nknCeo/lgtB5s6mvj/rbvf2tNFcC8h
         OI1j0SwMVbM1sw3xgD+tiCLZJVyTmpG1w6RQkKrI=
Date:   Fri, 24 May 2019 10:02:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     jslaby@suse.com, keescook@chromium.org, khorenko@virtuozzo.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] consolemap: Fix a memory leaking bug in
 con_insert_unipair()
Message-ID: <20190524080200.GA19609@kroah.com>
References: <20190521092935.GA2297@zhanggen-UX430UQ>
 <201905211342.DE554F0D@keescook>
 <20190522015055.GC4093@zhanggen-UX430UQ>
 <201905221353.AD8E585E6D@keescook>
 <20190523003452.GB14060@zhanggen-UX430UQ>
 <201905230952.B47ADA17A@keescook>
 <20190524021932.GA4866@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524021932.GA4866@zhanggen-UX430UQ>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:19:32AM +0800, Gen Zhang wrote:
> In function con_insert_unipair(), when allocation for p2 and p1[n]
> fails, ENOMEM is returned, but previously allocated p1 is not freed, 
> remains as leaking memory. Thus we should free p1 as well when this
> allocation fails.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Any reason you keep dropping me from this thread?

It's as if you don't want me to apply the patch :(

greg k-h
