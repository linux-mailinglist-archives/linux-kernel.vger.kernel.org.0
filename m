Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30FB4999B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 08:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfFRG54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 02:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfFRG54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:57:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF7DD20665;
        Tue, 18 Jun 2019 06:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560841075;
        bh=BoadilkCYTPnIl3QEBERI4uj2lKdwRcXmzIyAhRqQSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1mDdjMBHX1dV0hIrfNV3qExLK8CSEFyjXK4h0fBH9Tcj1qmVv2gXbs6/Ybxywbzd0
         C4NKkMeTJecd7TG/crMhIjhR51Bsei5HdYiJsTdhSrgeZ3hVKCdvPT3H9vjmid+OTC
         mxRAltCZxo9DSh88tM+i6ytmY5JJkIfPOA3jTGBI=
Date:   Tue, 18 Jun 2019 08:57:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Michael Straube <straube.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] staging: rtl8723bs: os_dep: ioctl_linux: make use of
 kzalloc
Message-ID: <20190618065753.GA15358@kroah.com>
References: <20190618014410.GA8505@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618014410.GA8505@hari-Inspiron-1545>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 07:14:10AM +0530, Hariprasad Kelam wrote:
> kmalloc with memset can be replaced with kzalloc.

Yes, but did you audit the call-paths of this to ensure that GFP_KERNEL
is the correct value for kzalloc() here?  If so, please document that in
the changelog.

thanks,

greg k-h
