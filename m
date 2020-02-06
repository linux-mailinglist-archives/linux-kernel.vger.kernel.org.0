Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 195B215438F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 12:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBFLyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 06:54:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37194 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgBFLyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:54:14 -0500
Received: from zn.tnic (p200300EC2F0B4B00F16B0FD9F8D3445C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4b00:f16b:fd9:f8d3:445c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CEB9C1EC0C51;
        Thu,  6 Feb 2020 12:54:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1580990053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=f7ChmiHX9FL0Z79PYUHfecPXhdKL4+QNl1JEAwKSqPk=;
        b=px17xW9VoAJxnUb4qjAyocCrfn1IhZgiBqcqnMGuvX1OqYssOuCyL7mW9vRYOVcujEsWwC
        4bEAZP0lkRisNoYA2P4NHb7t8HplhUdxDyRhsaUl+srCVBbwUs6TajRrn6NaGRoWOyjNMO
        GwJdZLJDMv8fXW1912k5Z4eHmIThXvU=
Date:   Thu, 6 Feb 2020 12:54:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config support
Message-ID: <20200206115405.GA22608@zn.tnic>
References: <20200114210316.450821675@goodmis.org>
 <20200114210336.259202220@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200114210336.259202220@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 04:03:20PM -0500, Steven Rostedt wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index a34064a031a5..63450d3bbf12 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1215,6 +1215,17 @@ source "usr/Kconfig"
>  
>  endif
>  
> +config BOOT_CONFIG
> +	bool "Boot config support"
> +	select LIBXBC
> +	default y

Any particular reason this is default y? Why should it be enabled by
default on all boxes?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
