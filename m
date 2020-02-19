Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58FCF1642C3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 11:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgBSK6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 05:58:25 -0500
Received: from ms.lwn.net ([45.79.88.28]:33838 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgBSK6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:58:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B49EF2DC;
        Wed, 19 Feb 2020 10:58:23 +0000 (UTC)
Date:   Wed, 19 Feb 2020 03:58:18 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kref: Clarify the use of two kref_put() in
 example code
Message-ID: <20200219035818.08ad246f@lwn.net>
In-Reply-To: <20200213125311.21256-1-manivannan.sadhasivam@linaro.org>
References: <20200213125311.21256-1-manivannan.sadhasivam@linaro.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 18:23:11 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:

> Eventhough the current documentation explains that the reference count
> gets incremented by both kref_init() and kref_get(), it is often
> misunderstood that only one instance of kref_put() is needed in the
> example code. So let's clarify that a bit.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/kref.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/kref.txt b/Documentation/kref.txt
> index 3af384156d7e..c61eea6f1bf2 100644
> --- a/Documentation/kref.txt
> +++ b/Documentation/kref.txt
> @@ -128,6 +128,10 @@ since we already have a valid pointer that we own a refcount for.  The
>  put needs no lock because nothing tries to get the data without
>  already holding a pointer.
>  
> +In the above example, kref_put() will be called 2 times in both success
> +and error paths. This is necessary because the reference count got
> +incremented 2 times by kref_init() and kref_get().

Out of curiosity, where have you seen this misunderstanding happening?
I'm not really opposed to this change, but I don't understand why it's
really needed.

Thanks,

jon
