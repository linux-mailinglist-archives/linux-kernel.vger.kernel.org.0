Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F35313936E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 19:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfFGRjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 13:39:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:57896 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbfFGRjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:39:48 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5779C2CD;
        Fri,  7 Jun 2019 17:39:48 +0000 (UTC)
Date:   Fri, 7 Jun 2019 11:39:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH v2] Documentation: nvdimm: Fix typo
Message-ID: <20190607113947.604b5ba0@lwn.net>
In-Reply-To: <20190509074049.12192-1-ruansy.fnst@cn.fujitsu.com>
References: <20190509023744.4936-1-ruansy.fnst@cn.fujitsu.com>
        <20190509074049.12192-1-ruansy.fnst@cn.fujitsu.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019 15:40:49 +0800
Shiyang Ruan <ruansy.fnst@cn.fujitsu.com> wrote:

> Remove the extra 'we '.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>  Documentation/nvdimm/nvdimm.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/nvdimm/nvdimm.txt b/Documentation/nvdimm/nvdimm.txt
> index e894de69915a..1669f626b037 100644
> --- a/Documentation/nvdimm/nvdimm.txt
> +++ b/Documentation/nvdimm/nvdimm.txt
> @@ -284,8 +284,8 @@ A bus has a 1:1 relationship with an NFIT.  The current expectation for
>  ACPI based systems is that there is only ever one platform-global NFIT.
>  That said, it is trivial to register multiple NFITs, the specification
>  does not preclude it.  The infrastructure supports multiple busses and
> -we we use this capability to test multiple NFIT configurations in the
> -unit test.
> +we use this capability to test multiple NFIT configurations in the unit
> +test.

Applied, thanks.

I note this has languished for a bit; please don't hesitate to ping after
a week or so if you don't get a response on a patch posting.

jon
