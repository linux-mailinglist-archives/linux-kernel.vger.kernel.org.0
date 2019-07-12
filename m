Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 946BE6674C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 08:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfGLG4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 02:56:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfGLG4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 02:56:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD1204ACDF;
        Fri, 12 Jul 2019 06:56:33 +0000 (UTC)
Received: from ming.t460p (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C69065C69A;
        Fri, 12 Jul 2019 06:56:21 +0000 (UTC)
Date:   Fri, 12 Jul 2019 14:56:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Palmer Dabbelt <palmer@sifive.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Gal Pressman <galpress@amazon.com>,
        Allison Randal <allison@lohutok.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scatterlist: Allocate a contiguous array instead of
 chaining
Message-ID: <20190712065613.GA3036@ming.t460p>
References: <20190712063657.17088-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712063657.17088-1-sultan@kerneltoast.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 12 Jul 2019 06:56:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 11:36:56PM -0700, Sultan Alsawaf wrote:
> From: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> Typically, drivers allocate sg lists of sizes up to a few MiB in size.
> The current algorithm deals with large sg lists by splitting them into
> several smaller arrays and chaining them together. But if the sg list
> allocation is large, and we know the size ahead of time, sg chaining is
> both inefficient and unnecessary.
> 
> Rather than calling kmalloc hundreds of times in a loop for chaining
> tiny arrays, we can simply do it all at once with kvmalloc, which has
> the proper tradeoff on when to stop using kmalloc and instead use
> vmalloc.

vmalloc() may sleep, so it is impossible to be called in atomic context.

Thanks,
Ming
