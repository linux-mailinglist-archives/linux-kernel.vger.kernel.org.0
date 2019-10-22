Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 934D7E0E85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 01:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389674AbfJVX3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 19:29:40 -0400
Received: from baldur.buserror.net ([165.227.176.147]:59068 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731847AbfJVX3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:29:40 -0400
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1iN3UG-0003jo-Ga; Tue, 22 Oct 2019 18:22:51 -0500
Message-ID: <51ee13bc7ced50c3aa1a7ac9335bea16651db684.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        christophe.leroy@c-s.fr, benh@kernel.crashing.org,
        paulus@samba.org, npiggin@gmail.com, keescook@chromium.org,
        kernel-hardening@lists.openwall.com
Cc:     wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org,
        jingxiangfeng@huawei.com, zhaohongjiang@huawei.com,
        thunder.leizhen@huawei.com, yebin10@huawei.com
Date:   Tue, 22 Oct 2019 18:22:47 -0500
In-Reply-To: <0543af6f-df4a-81ff-41fe-c81959568859@huawei.com>
References: <20190920094546.44948-1-yanaijie@huawei.com>
         <9c2dd2a8-83f2-983c-383e-956e19a7803a@huawei.com>
         <c4769b34-95f6-81b9-4856-50459630aa0d@huawei.com>
         <38141b946f3376ce471e46eaf065e357ac540354.camel@buserror.net>
         <90bb659a-bde4-3b8e-8f01-bf22d7534f44@huawei.com>
         <34ef1980887c8a6d635c20bdaf748bb0548e51b5.camel@buserror.net>
         <0543af6f-df4a-81ff-41fe-c81959568859@huawei.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: yanaijie@huawei.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com, christophe.leroy@c-s.fr, benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com, keescook@chromium.org, kernel-hardening@lists.openwall.com, wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org, jingxiangfeng@huawei.com, zhaohongjiang@huawei.com, thunder.leizhen@huawei.com, yebin10@huawei.com
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
Subject: Re: [PATCH v7 00/12] implement KASLR for powerpc/fsl_booke/32
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-21 at 11:34 +0800, Jason Yan wrote:
> 
> On 2019/10/10 2:46, Scott Wood wrote:
> > On Wed, 2019-10-09 at 16:41 +0800, Jason Yan wrote:
> > > Hi Scott,
> > > 
> > > On 2019/10/9 15:13, Scott Wood wrote:
> > > > On Wed, 2019-10-09 at 14:10 +0800, Jason Yan wrote:
> > > > > Hi Scott,
> > > > > 
> > > > > Would you please take sometime to test this?
> > > > > 
> > > > > Thank you so much.
> > > > > 
> > > > > On 2019/9/24 13:52, Jason Yan wrote:
> > > > > > Hi Scott,
> > > > > > 
> > > > > > Can you test v7 to see if it works to load a kernel at a non-zero
> > > > > > address?
> > > > > > 
> > > > > > Thanks,
> > > > 
> > > > Sorry for the delay.  Here's the output:
> > > > 
> > > 
> > > Thanks for the test.
> > > 
> > > > ## Booting kernel from Legacy Image at 10000000 ...
> > > >      Image Name:   Linux-5.4.0-rc2-00050-g8ac2cf5b4
> > > >      Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> > > >      Data Size:    7521134 Bytes = 7.2 MiB
> > > >      Load Address: 04000000
> > > >      Entry Point:  04000000
> > > >      Verifying Checksum ... OK
> > > > ## Flattened Device Tree blob at 1fc00000
> > > >      Booting using the fdt blob at 0x1fc00000
> > > >      Uncompressing Kernel Image ... OK
> > > >      Loading Device Tree to 07fe0000, end 07fff65c ... OK
> > > > KASLR: No safe seed for randomizing the kernel base.
> > > > OF: reserved mem: initialized node qman-fqd, compatible id fsl,qman-
> > > > fqd
> > > > OF: reserved mem: initialized node qman-pfdr, compatible id fsl,qman-
> > > > pfdr
> > > > OF: reserved mem: initialized node bman-fbpr, compatible id fsl,bman-
> > > > fbpr
> > > > Memory CAM mapping: 64/64/64 Mb, residual: 12032Mb
> > > 
> > > When boot from 04000000, the max CAM value is 64M. And
> > > you have a board with 12G memory, CONFIG_LOWMEM_CAM_NUM=3 means only
> > > 192M memory is mapped and when kernel is randomized at the middle of
> > > this 192M memory, we will not have enough continuous memory for node
> > > map.
> > > 
> > > Can you set CONFIG_LOWMEM_CAM_NUM=8 and see if it works?
> > 
> > OK, that worked.
> > 
> 
> Hi Scott, any more cases should be tested or any more comments?
> What else need to be done before this feature can be merged?

I've just applied it and sent a pull request.

-Scott


