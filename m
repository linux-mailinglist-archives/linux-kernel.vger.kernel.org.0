Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0359415CA9B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 19:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgBMSmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 13:42:24 -0500
Received: from ms.lwn.net ([45.79.88.28]:46966 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMSmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:42:24 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F245B740;
        Thu, 13 Feb 2020 18:42:23 +0000 (UTC)
Date:   Thu, 13 Feb 2020 11:42:22 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: userspace: ioctl-number: remove mc146818rtc
 conflict
Message-ID: <20200213114222.220060b3@lwn.net>
In-Reply-To: <20200209203304.66004-1-alexandre.belloni@bootlin.com>
References: <20200209203304.66004-1-alexandre.belloni@bootlin.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  9 Feb 2020 21:33:04 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> In 2.3.43pre2, the RTC ioctls definitions were actually moved from
> linux/mc146818rtc.h to linux/rtc.h
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 2e91370dc159..f759edafd938 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -266,7 +266,6 @@ Code  Seq#    Include File                                           Comments
>  'o'   01-A1  `linux/dvb/*.h`                                         DVB
>  'p'   00-0F  linux/phantom.h                                         conflict! (OpenHaptics needs this)
>  'p'   00-1F  linux/rtc.h                                             conflict!
> -'p'   00-3F  linux/mc146818rtc.h                                     conflict!
>  'p'   40-7F  linux/nvram.h
>  'p'   80-9F  linux/ppdev.h                                           user-space parport
>                                                                       <mailto:tim@cyberelk.net>

Applied, thanks.

jon
