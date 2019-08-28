Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED3CA07BD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 18:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfH1Qo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 12:44:56 -0400
Received: from baldur.buserror.net ([165.227.176.147]:50714 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1Qoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:44:55 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1i313y-0002t0-PH; Wed, 28 Aug 2019 11:44:51 -0500
Message-ID: <457508f39b96caab15ed4bf7ff0d586ffdc850f8.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     wangkefeng.wang@huawei.com, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, thunder.leizhen@huawei.com,
        linux-kernel@vger.kernel.org, npiggin@gmail.com,
        jingxiangfeng@huawei.com, diana.craciun@nxp.com, paulus@samba.org,
        zhaohongjiang@huawei.com, fanchengyang@huawei.com,
        linuxppc-dev@lists.ozlabs.org, yebin10@huawei.com
Date:   Wed, 28 Aug 2019 11:44:48 -0500
In-Reply-To: <de603506-5c4e-4ca3-bd77-e3a69af9faef@huawei.com>
References: <20190809100800.5426-1-yanaijie@huawei.com>
         <20190809100800.5426-7-yanaijie@huawei.com>
         <20190828045454.GB17757@home.buserror.net>
         <de603506-5c4e-4ca3-bd77-e3a69af9faef@huawei.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: yanaijie@huawei.com, wangkefeng.wang@huawei.com, keescook@chromium.org, kernel-hardening@lists.openwall.com, thunder.leizhen@huawei.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, jingxiangfeng@huawei.com, diana.craciun@nxp.com, paulus@samba.org, zhaohongjiang@huawei.com, fanchengyang@huawei.com, linuxppc-dev@lists.ozlabs.org, yebin10@huawei.com
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on baldur.localdomain
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  -15 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -1.5 GREYLIST_ISWHITE The incoming server has been whitelisted for
        *      this recipient and sender
Subject: Re: [PATCH v6 06/12] powerpc/fsl_booke/32: implement KASLR
 infrastructure
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-28 at 19:03 +0800, Jason Yan wrote:
> 
> On 2019/8/28 12:54, Scott Wood wrote:
> > On Fri, Aug 09, 2019 at 06:07:54PM +0800, Jason Yan wrote:
> > > +/*
> > > + * To see if we need to relocate the kernel to a random offset
> > > + * void *dt_ptr - address of the device tree
> > > + * phys_addr_t size - size of the first memory block
> > > + */
> > > +notrace void __init kaslr_early_init(void *dt_ptr, phys_addr_t size)
> > > +{
> > > +	unsigned long tlb_virt;
> > > +	phys_addr_t tlb_phys;
> > > +	unsigned long offset;
> > > +	unsigned long kernel_sz;
> > > +
> > > +	kernel_sz = (unsigned long)_end - KERNELBASE;
> > 
> > Why KERNELBASE and not kernstart_addr?
> > 
> 
> Did you mean kernstart_virt_addr? It should be kernstart_virt_addr.

Yes, kernstart_virt_addr.  KERNELBASE will be incorrect if the kernel was
loaded at a nonzero physical address without CONFIG_PHYSICAL_START being
adjusted to match.

-Scott


