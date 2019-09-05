Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E26CEA9856
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 04:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfIECaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 22:30:06 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:51400 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730074AbfIECaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 22:30:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07812042|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0543389-0.00436749-0.941294;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03312;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.FOxzzyz_1567650603;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.FOxzzyz_1567650603)
          by smtp.aliyun-inc.com(10.147.42.197);
          Thu, 05 Sep 2019 10:30:03 +0800
Date:   Thu, 5 Sep 2019 10:30:02 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH V6 1/3] riscv: Add perf callchain support
Message-ID: <20190905023002.GA3949@vmh-VirtualBox>
References: <cover.1567060834.git.han_mao@c-sky.com>
 <86d18d80affc39cf9579a24f1beb7c8631cfa9bd.1567060834.git.han_mao@c-sky.com>
 <alpine.DEB.2.21.9999.1909041247560.13502@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1909041247560.13502@viisi.sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 12:54:41PM -0700, Paul Walmsley wrote:
> Hello Mao Han,
> 
> On Thu, 29 Aug 2019, Mao Han wrote:
> 
> > This patch add support for perf callchain sampling on riscv platform.
> > The return address of leaf function is retrieved from pt_regs as
> > it is not saved in the outmost frame.
> > 
> > Signed-off-by: Mao Han <han_mao@c-sky.com>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Greentime Hu <green.hu@gmail.com>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: linux-riscv <linux-riscv@lists.infradead.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Guo Ren <guoren@kernel.org>
> 
> There are some 'checkpatch.pl --strict' warnings with this patch (below).  
> These have been fixed here.  The following patch has been queued for 
> v5.4-rc1 with Greentime's Tested-by:.  Thanks for your hard work following 
> up on the feedback with these patches -
Thanks for the fixes. I'll check patches with --strict next time.

Thanks,
Mao Han
