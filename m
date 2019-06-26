Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04C205741C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 00:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfFZWJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 18:09:39 -0400
Received: from ms.lwn.net ([45.79.88.28]:42036 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfFZWJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:09:39 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C89B44BF;
        Wed, 26 Jun 2019 22:09:38 +0000 (UTC)
Date:   Wed, 26 Jun 2019 16:09:37 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the jc_docs
 tree
Message-ID: <20190626160937.4a8d8548@lwn.net>
In-Reply-To: <20190627080123.5fd05a63@canb.auug.org.au>
References: <20190627080123.5fd05a63@canb.auug.org.au>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 08:01:23 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Commit
> 
>   fad3d54ef8a8 ("Documentation: PGP: update for newer HW devices")
> 
> is missing a Signed-off-by from its committer.

Argh.  I had to jump through some hoops to apply that patch and ...
screwed up.

Thanks,

jon
