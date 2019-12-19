Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5390C1271E2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 00:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfLSX4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 18:56:50 -0500
Received: from baldur.buserror.net ([165.227.176.147]:43332 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLSX4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 18:56:50 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1ii5cf-0001SV-7t; Thu, 19 Dec 2019 17:54:25 -0600
Message-ID: <7f0bd277632942acbdc0c41c6cd149d8543c2b3e.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     yingjie_bai@126.com, Kumar Gala <galak@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Bai Yingjie <byj.tea@gmail.com>
Date:   Thu, 19 Dec 2019 17:54:24 -0600
In-Reply-To: <1574694943-7883-1-git-send-email-yingjie_bai@126.com>
References: <1574694943-7883-1-git-send-email-yingjie_bai@126.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: yingjie_bai@126.com, galak@kernel.crashing.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, byj.tea@gmail.com
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on baldur.localdomain
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  -15 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
Subject: Re: [PATCH] powerpc/mpc85xx: also write addr_h to spin table for
 64bit boot entry
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-11-25 at 23:15 +0800, yingjie_bai@126.com wrote:
> From: Bai Yingjie <byj.tea@gmail.com>
> 
> CPU like P4080 has 36bit physical address, its DDR physical
> start address can be configured above 4G by LAW registers.
> 
> For such systems in which their physical memory start address was
> configured higher than 4G, we need also to write addr_h into the spin
> table of the target secondary CPU, so that addr_h and addr_l together
> represent a 64bit physical address.
> Otherwise the secondary core can not get correct entry to start from.
> 
> This should do no harm for normal case where addr_h is all 0.
> 
> Signed-off-by: Bai Yingjie <byj.tea@gmail.com>
> ---
>  arch/powerpc/platforms/85xx/smp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Scott Wood <oss@buserror.net>

-Scott


