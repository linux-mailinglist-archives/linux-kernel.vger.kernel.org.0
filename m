Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B559F35B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 21:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfH0Tg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 15:36:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44560 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0Tg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:36:27 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2hGS-0006kz-SQ; Tue, 27 Aug 2019 21:36:24 +0200
Date:   Tue, 27 Aug 2019 21:36:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-spdx@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add entry for LICENSES and SPDX stuff
In-Reply-To: <20190827172519.GA28849@kroah.com>
Message-ID: <alpine.DEB.2.21.1908272135150.1939@nanos.tec.linutronix.de>
References: <20190827172519.GA28849@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019, Greg Kroah-Hartman wrote:

> Thomas and I seem to have become the "unofficial" maintainers for these
> files and questions about SPDX things.  So let's make it official.
> 
> Reported-by: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9234,6 +9234,17 @@ F:	include/linux/nd.h
>  F:	include/linux/libnvdimm.h
>  F:	include/uapi/linux/ndctl.h
>  
> +LICENSES and SPDX stuff
> +M:	Thomas Gleixner <tglx@linutronix.de>
> +M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +L:	linux-spdx@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git
> +F:	COPYING
> +F:	LICENSES/
> +F:	scripts/spdxcheck-test.sh
> +F:	scripts/spdxcheck.py

We probably want to add Documentation/process/license-rules.rst as well.

Thanks,

	tglx
