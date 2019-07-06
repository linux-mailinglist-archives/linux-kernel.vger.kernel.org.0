Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE0B8611EB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 17:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfGFPi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 11:38:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42032 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfGFPi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 11:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7TQwAzn0J5EXLc+BbiWf8v/R95Wdjh5+dxrOc78SyBQ=; b=zk1xeLOyXqj8CUdxCMPGb5v4O6
        7hsXykVY8BfzjRyGPWIiYyGMnVxn3mN2H9t48yfsDQr2b0t2KsCupiuMaoV3qjEeKnUyIetD1fE5E
        1Ku0V7rf+tU/MCbArHAkSOmlGc/Zj0/pjuIp/N7qSWFohv/1Pkif4/dN2NQDN2MymGp3euW92NUIA
        Mc7fJimKvdws8bLQFAm3bwYo9fNSCQAO+C59n98FSTLsk4D/TjJWDbVVoGYXBWP/337wSBHKhUnQL
        3AFwOHHBGkPtXaEz8acl3Bi2LmaUZZCeImDaFYoBAUz0uGii+Nb43uWaZlXeqb7euZPHBZ9uKr4+7
        n448kLpw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjmlu-0001Aq-7U; Sat, 06 Jul 2019 15:38:42 +0000
Subject: Re: [PATCH v5 06/12] S.A.R.A.: WX protection
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
 <1562410493-8661-7-git-send-email-s.mesoraca16@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fcbf55e9-78dc-fb1a-e893-4fea8ebdc202@infradead.org>
Date:   Sat, 6 Jul 2019 08:38:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562410493-8661-7-git-send-email-s.mesoraca16@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/19 3:54 AM, Salvatore Mesoraca wrote:
> diff --git a/security/sara/Kconfig b/security/sara/Kconfig
> index b98cf27..54a96e0 100644
> --- a/security/sara/Kconfig
> +++ b/security/sara/Kconfig
> @@ -60,3 +60,77 @@ config SECURITY_SARA_NO_RUNTIME_ENABLE
>  
>  	  If unsure, answer Y.
>  
> +config SECURITY_SARA_WXPROT
> +	bool "WX Protection: W^X and W!->X protections"
> +	depends on SECURITY_SARA
> +	default y
> +	help
> +	  WX Protection aims to improve user-space programs security by applying:
> +	    - W^X memory restriction
> +	    - W!->X (once writable never executable) mprotect restriction
> +	    - Executable MMAP prevention
> +	  See Documentation/admin-guide/LSM/SARA.rst. for further information.

	                                        .rst for further information.

> +
> +	  If unsure, answer Y.
> +
> +choice
> +	prompt "Default action for W^X and W!->X protections"
> +	depends on SECURITY_SARA
> +	depends on SECURITY_SARA_WXPROT
> +	default SECURITY_SARA_WXPROT_DEFAULT_FLAGS_ALL_COMPLAIN_VERBOSE
> +
> +        help

Use tab instead of spaces for indentation above.

> +	  Choose the default behaviour of WX Protection when no config
> +	  rule matches or no rule is loaded.
> +	  For further information on available flags and their meaning
> +	  see Documentation/admin-guide/LSM/SARA.rst.
> +
> +	config SECURITY_SARA_WXPROT_DEFAULT_FLAGS_ALL_COMPLAIN_VERBOSE
> +		bool "Protections enabled but not enforced."
> +		help
> +		  All features enabled except "Executable MMAP prevention",
> +		  verbose reporting, but no actual enforce: it just complains.
> +		  Its numeric value is 0x3f, for more information see
> +		  Documentation/admin-guide/LSM/SARA.rst.
> +
> +        config SECURITY_SARA_WXPROT_DEFAULT_FLAGS_ALL_ENFORCE_VERBOSE
> +		bool "Full protection, verbose."
> +		help
> +		  All features enabled except "Executable MMAP prevention".
> +		  The enabled features will be enforced with verbose reporting.
> +		  Its numeric value is 0x2f, for more information see
> +		  Documentation/admin-guide/LSM/SARA.rst.
> +
> +        config SECURITY_SARA_WXPROT_DEFAULT_FLAGS_ALL_ENFORCE
> +		bool "Full protection, quiet."
> +		help
> +		  All features enabled except "Executable MMAP prevention".
> +		  The enabled features will be enforced quietly.
> +		  Its numeric value is 0xf, for more information see
> +		  Documentation/admin-guide/LSM/SARA.rst.
> +
> +	config SECURITY_SARA_WXPROT_DEFAULT_FLAGS_NONE
> +		bool "No protection at all."
> +		help
> +		  All features disabled.
> +		  Its numeric value is 0, for more information see
> +		  Documentation/admin-guide/LSM/SARA.rst.
> +endchoice
> +
> +config SECURITY_SARA_WXPROT_DISABLED
> +	bool "WX protection will be disabled at boot."
> +	depends on SECURITY_SARA_WXPROT
> +	default n

Omit "default n" please.

> +	help
> +	  If you say Y here WX protection won't be enabled at startup. You can
> +	  override this option via user-space utilities or at boot time via
> +	  "sara.wxprot_enabled=[0|1]" kernel parameter.
> +
> +	  If unsure, answer N.
> +
> +config SECURITY_SARA_WXPROT_DEFAULT_FLAGS
> +	hex
> +	default "0x3f" if SECURITY_SARA_WXPROT_DEFAULT_FLAGS_ALL_COMPLAIN_VERBOSE
> +	default "0x2f" if SECURITY_SARA_WXPROT_DEFAULT_FLAGS_ALL_ENFORCE_VERBOSE
> +	default "0xf" if SECURITY_SARA_WXPROT_DEFAULT_FLAGS_ALL_ENFORCE
> +	default "0" if SECURITY_SARA_WXPROT_DEFAULT_FLAGS_NONE


-- 
~Randy
