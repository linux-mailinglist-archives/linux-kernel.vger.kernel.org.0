Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852EDACECC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2019 15:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfIHNFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 09:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfIHNFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:05:15 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DACA2081B;
        Sun,  8 Sep 2019 13:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947914;
        bh=f/USdf+Qmmrhtr9v2Ye1PhWv3pSQE+Nih/ikf2MxXZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgrRWimuE+GnXFwSTufD2W9Ief5Mtj+E6ytsR5zwiVwABvRj/wSmbLVc/5glV7WSL
         0ErUvG/E8lts7YenUpaTMjZfgfyXsf9oGqjcQekuNdihrG4a/k+vHYmVSs4ipP9OQc
         Buk3RaUuSGdEh8wgFCWV5ceNGJDEbcxbGwFPee4Q=
Date:   Sun, 8 Sep 2019 14:05:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] staging: exfat: cleanup casts
Message-ID: <20190908130512.GA9290@kroah.com>
References: <564f4da0f0a9cf9eb91ee46bf10531ea04a37750.camel@perches.com>
 <20190907214541.13764-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907214541.13764-1-vvidic@valentin-vidic.from.hr>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 09:45:41PM +0000, Valentin Vidic wrote:
> Use constants and fix checkpatch.pl warnings:
> 
>   CHECK: No space is necessary after a cast

This really should be two different patches, one for the constant
changes, and one for the space issues.  Can you break this up and resend
the whole series?

thanks,

greg k-h
