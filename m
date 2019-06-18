Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F6A4A641
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 18:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfFRQIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 12:08:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbfFRQIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:08:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A80C213F2;
        Tue, 18 Jun 2019 16:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560874130;
        bh=YCsNI3NUEf3Ql1pa6VJY/tDOkScY+nHIByu9NbnC36Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0YKi/KzPywEj1N8qH2KtYtm/gAy7MGUSAmSjnLozqZfHcQkhJAsnU26kBZW3TnOs3
         x050ZxqF1ZgcYIvK+f5UqVtG8lb76QINYtwEW8rJcere9TfZck1vQOubHmTKC07Jd7
         ty3Y8cr9LSJxKvrBnJqvaycxBX2cJ6GxEC26G9m0=
Date:   Tue, 18 Jun 2019 18:08:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, hch@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH v2] fs: cramfs_fs.h: Fix shifting
 signed 32-bit value by 31 bits problem
Message-ID: <20190618160847.GC27611@kroah.com>
References: <20190618114947.10563-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618114947.10563-1-puranjay12@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 05:19:47PM +0530, Puranjay Mohan wrote:
> Fix CRAMFS_BLK_FLAG_UNCOMPRESSED to use "U" cast to avoid shifting signed
> 32-bit value by 31 bits problem. This isn't a problem for kernel builds
> with gcc.
> 
> This could be problem since this header is part of public API which
> could be included for builds using compilers that don't handle this
> condition safely resulting in undefined behavior.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

You should resend this and cc: Nicolas Pitre <nico@fluxnic.net> as he is
the cramfs maintainer.

thanks,

greg k-h
