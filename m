Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010D87A5CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 12:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbfG3KQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 06:16:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38392 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfG3KQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:16:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 1CC0728B34A
Subject: Re: [PATCH v3] platform/chrome: cros_ec_trace: update generating
 script
To:     Tzung-Bi Shih <tzungbi@google.com>, bleung@chromium.org,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org, cychiang@google.com,
        dgreid@google.com, Raul E Rangel <rrangel@chromium.org>
References: <20190729143932.167915-1-tzungbi@google.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <bb8a3194-4e4a-0ab4-8b8a-6f1c2255f14f@collabora.com>
Date:   Tue, 30 Jul 2019 12:16:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729143932.167915-1-tzungbi@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi,

cc'ing Raul for if he has comments

On 29/7/19 16:39, Tzung-Bi Shih wrote:
> To remove ", \" from the last line.
> 

I'm overall fine with the patch itself but I'd prefer a better description here.

Thanks,
~ Enric

> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
> Changes from v1:
> - simpler awk code
> Changes from v2:
> - use c style comments instead of c++ style
> - use '@' delimiter in sed instead of '/' to avoid unintentional end of
>   comment "*/"
> 
>  drivers/platform/chrome/cros_ec_trace.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
> index 0a76412095a9..f6034b774f9a 100644
> --- a/drivers/platform/chrome/cros_ec_trace.c
> +++ b/drivers/platform/chrome/cros_ec_trace.c
> @@ -5,8 +5,21 @@
>  
>  #define TRACE_SYMBOL(a) {a, #a}
>  
> -// Generate the list using the following script:
> -// sed -n 's/^#define \(EC_CMD_[[:alnum:]_]*\)\s.*/\tTRACE_SYMBOL(\1), \\/p' include/linux/mfd/cros_ec_commands.h
> +/*
> + * Generate the list using the following script:
> + * sed -n 's@^#define \(EC_CMD_[[:alnum:]_]*\)\s.*@\tTRACE_SYMBOL(\1), \\@p' \
> + * include/linux/mfd/cros_ec_commands.h | awk '
> + * {
> + *   if (NR != 1)
> + *     print buf;
> + *   buf = $0;
> + * }
> + * END {
> + *   gsub(/, \\/, "", buf);
> + *   print buf;
> + * }
> + * '
> + */
>  #define EC_CMDS \
>  	TRACE_SYMBOL(EC_CMD_PROTO_VERSION), \
>  	TRACE_SYMBOL(EC_CMD_HELLO), \
> 
