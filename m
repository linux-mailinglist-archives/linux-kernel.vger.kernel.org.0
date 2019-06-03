Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B3C32A0C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 09:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfFCHvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 03:51:08 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:51424 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbfFCHvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:51:08 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 1FDC22E08D3;
        Mon,  3 Jun 2019 10:51:06 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id HTQF86XK9T-p5pinl5f;
        Mon, 03 Jun 2019 10:51:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1559548266; bh=EiLbVXDQ9KTjFwXlIVvmEa04sb6AaLzJfqDuh/MDD9w=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=wbmlXMswhm/ulrxOK2IH/j1fDipp2dW0BgDjHPEGoRqgGphlRiFFp4r7QaBAg6QGY
         pxGfgHAzyviLOtN8evRTSJsxqrxbYj0v3Itjd/YTLPCED78F9Y0IASqV1FcsB8ktIS
         J80ABDO0/b6ACzSeHqaKpsMaSZ6bsFNXXAxbTOiw=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:4c89:a73d:8d94:91a5])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id eczyja9xde-p584J5fc;
        Mon, 03 Jun 2019 10:51:05 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] scripts/decode_stacktrace: Accept dash/underscore in
 modules
To:     Evan Green <evgreen@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Manuel Traut <manut@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190531205926.42474-1-evgreen@chromium.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <f9d0688c-246b-70b9-cdac-062dd9d329b2@yandex-team.ru>
Date:   Mon, 3 Jun 2019 10:51:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531205926.42474-1-evgreen@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.2019 23:59, Evan Green wrote:
> The manpage for modprobe mentions that dashes and underscores are
> treated interchangeably in module names. The stack trace dumps seem
> to print module names with underscores. Use bash to replace _ with
> the pattern [-_] so that file names with dashes or underscores can be
> found.
> 
> For example, this line:
> [   27.919759]  hda_widget_sysfs_init+0x2b8/0x3a5 [snd_hda_core]
> 
> should find a module named snd-hda-core.ko.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>

Acked-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

> ---
> 
> Note: This should apply atop linux-next.
> 
> Thanks to Doug for showing me the bash string substitution magic.
> 
> ---
>   scripts/decode_stacktrace.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index fa704f17275e..13e5fbafdf2f 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -28,7 +28,7 @@ parse_symbol() {
>   		local objfile=${modcache[$module]}
>   	else
>   		[[ $modpath == "" ]] && return
> -		local objfile=$(find "$modpath" -name "$module.ko*" -print -quit)
> +		local objfile=$(find "$modpath" -name "${module//_/[-_]}.ko*" -print -quit)
>   		[[ $objfile == "" ]] && return
>   		modcache[$module]=$objfile
>   	fi
> 
