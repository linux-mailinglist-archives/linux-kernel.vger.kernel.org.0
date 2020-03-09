Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6A1417D9A0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 08:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCIHNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 03:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgCIHNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 03:13:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60A6B20665;
        Mon,  9 Mar 2020 07:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583738029;
        bh=hWJNtQQWqHRyt/XLzVAneJ9w+0DP6eb16gOqermGfK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0NGCAh9Ya1os58fUGPLB9nQIhrLPnfOGcT/cS+gtCSt92Ol7VwgxGQORw2V1f8E1O
         I4IGx8WmdRn2MdGdS9w28Clj2MwcXGBkI3p7gevHcIryid4ydJMNFoJCdmX8F++Y7C
         lAsqKLNZ5f95t9ThGhLv1r7AAYQ8Yp0mm2D+uNc4=
Date:   Mon, 9 Mar 2020 08:13:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, miguel.ojeda.sandonis@gmail.com,
        willy@haproxy.com, ksenija.stanojevic@gmail.com, arnd@arndb.de,
        mpm@selenic.com, herbert@gondor.apana.org.au,
        jonathan@buzzard.org.uk, benh@kernel.crashing.org,
        davem@davemloft.net, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com
Subject: Re: [PATCH RFC 0/3] clean up misc device minor numbers
Message-ID: <20200309071347.GA4095204@kroah.com>
References: <20200309021747.626-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309021747.626-1-zhenzhong.duan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 10:17:44AM +0800, Zhenzhong Duan wrote:
> Some the misc device minor numbers definitions spread in different
> local c files, specially some are duplicate number with different
> name, some are same name with conflict numbers, some prefer dynamic
> minors.
> 
> This patchset try to address all of them.
> 
> To be honest, I didn't try build on arm or sparc arch which some
> drivers depend on as I have little experience on cross-compile.
> But I still checked the patch carefully to ensure it builds
> in theory. Appreciate if anyone willing to test build on those arch.
> 
> Zhenzhong Duan (3):
>   misc: cleanup minor number definitions in c file into miscdevice.h
>   misc: move FLASH_MINOR into miscdevice.h and fix conflicts
>   speakup: misc: Use dynamic minor numbers for speakup devices

Many thanks for this work, I think they all look sane except maybe the
last one, I'll respond there to that.

thanks,

greg k-h
