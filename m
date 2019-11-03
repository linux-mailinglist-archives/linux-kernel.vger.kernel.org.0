Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC76FED43E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 19:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfKCSyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 13:54:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbfKCSyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 13:54:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55AB52190F;
        Sun,  3 Nov 2019 18:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572807250;
        bh=/Fp7rJRFyNxy/xi8McFrIAyKVvI085F99glKGb/E+gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z0GSLE2GRdg5EPuxBK07F3ljN5RKjQUcyOmiiZgimTk2OnoFa2gFPheZoo4css9tK
         xILaSia6I4WJDK3q6uidE54n/lU/xo/zN21qdex85ZQ9ZBjOaKT44Zt0wwumGUbCwI
         pm9jOqG3rW1v1QR3enD5CvlfddIZXDlD/92+FzRM=
Date:   Sun, 3 Nov 2019 19:54:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Michael Moese <mmoese@suse.de>, Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH] drivers: mcb: use symbol namespaces
Message-ID: <20191103185408.GA966077@kroah.com>
References: <20191016100158.1400-1-jthumshirn@suse.de>
 <20191016125139.GA26497@kroah.com>
 <48f87640-d277-fdb6-3d6e-3f88b7623f22@suse.de>
 <20191016135300.GA302460@kroah.com>
 <c4e3216e-df8d-65cb-d60a-98eb159b9205@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4e3216e-df8d-65cb-d60a-98eb159b9205@suse.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 10:20:58AM +0100, Johannes Thumshirn wrote:
> On 16/10/2019 15:53, Greg KH wrote:
> [...]
> > I can take this now, into my -next tree.  I'll do so later this week
> > unless you object.
> 
> Ping?

Sorry, been traveling, will get to this now...
