Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F27131744
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 19:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgAFSLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 13:11:03 -0500
Received: from baldur.buserror.net ([165.227.176.147]:48232 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:11:02 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1ioWls-0008DE-B8; Mon, 06 Jan 2020 12:06:33 -0600
Message-ID: <88cb950e3ad4040a368d946909d8818c4372894f.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 Jan 2020 12:06:31 -0600
In-Reply-To: <1577900990-8588-6-git-send-email-Julia.Lawall@inria.fr>
References: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
         <1577900990-8588-6-git-send-email-Julia.Lawall@inria.fr>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: Julia.Lawall@inria.fr, kernel-janitors@vger.kernel.org, galak@kernel.crashing.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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
Subject: Re: [PATCH 05/10] powerpc/83xx: use resource_size
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-01 at 18:49 +0100, Julia Lawall wrote:
> Use resource_size rather than a verbose computation on
> the end and start fields.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> <smpl>
> @@ struct resource ptr; @@
> - (ptr.end - ptr.start + 1)
> + resource_size(&ptr)
> </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  arch/powerpc/platforms/83xx/km83xx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Scott Wood <oss@buserror.net>

-Scott


