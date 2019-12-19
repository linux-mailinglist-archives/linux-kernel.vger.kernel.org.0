Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A521267A3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 18:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfLSRFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 12:05:36 -0500
Received: from ms.lwn.net ([45.79.88.28]:37360 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSRFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:05:36 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7C16E2E5;
        Thu, 19 Dec 2019 17:05:35 +0000 (UTC)
Date:   Thu, 19 Dec 2019 10:05:34 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Harry Wei <harryxiyou@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] docs/zh_CN: add translator info for
 embargoed-hardware-issues
Message-ID: <20191219100534.707c0f36@lwn.net>
In-Reply-To: <1576660243-84140-2-git-send-email-alex.shi@linux.alibaba.com>
References: <1576660243-84140-1-git-send-email-alex.shi@linux.alibaba.com>
        <1576660243-84140-2-git-send-email-alex.shi@linux.alibaba.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 17:10:41 +0800
Alex Shi <alex.shi@linux.alibaba.com> wrote:

> Let the people know where to complain... ;)

So I'd like to apply all of these changes; they look fine to me given that
I don't read Chinese...:)  But I do have a couple of requests:

 - Please combine the changes into a single patch; adding the translated
   file, putting it into the toctree, and adding translator credit are all
   a single action, in the end.  There is no reason to split them apart.

 - Changelogs like the above are not particularly helpful; please provide
   changelogs in the usual kernel style describing what was done and why.

Thanks,

jon

> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Harry Wei <harryxiyou@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../translations/zh_CN/process/embargoed-hardware-issues.rst         | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
> index 5bc583a41188..a0b956946ebf 100644
> --- a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
> +++ b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
> @@ -1,3 +1,8 @@
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :ref:`Documentation/process/embargoed-hardware-issues.rst`
> +:Translator: Alex Shi <alex.shi@linux.alibaba.com>
> +
>  被限制的硬件问题
>  ================
>  
