Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26F19493C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 21:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgCZUeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 16:34:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43194 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgCZUeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:34:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id u12so3472853pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 13:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Le7doV1aD2nnDIjljTT6TRoqwG4Kk2Xg5cqe+Y2QeE8=;
        b=IRl4RWYnFi1S/4ylGpDj2CLK3Ia0Xfv+YRQBn3BpWZOs7UKH6YZo8+zxLGWahTKYuZ
         M/tNUA95U4+1GTULWdX+4rxNECrKnt/UOjrhOmD5k3nKqeauDBg0WkYbDFmCbgqodyGb
         N0hlBrV9t60fDGH88FD7DUnHKF0D8Q11RzoCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Le7doV1aD2nnDIjljTT6TRoqwG4Kk2Xg5cqe+Y2QeE8=;
        b=GQdtmDvf9t5jeIj0/l57Pf/S9zu6T3Hd+mqsQ6z2FRfUbdw6IA1cYMa6mQQUnZESG5
         ll9SRKS0K0/ilnHbVPHMLfhwkTdsEiw/IRD3rOn8m1/xQV3w4VbzHbrDar90Ro5ZAHL8
         tL0xsX7cdZcIrB3Nr7VpARROMa/sJM7JcIg6jsSw2eu2gOM5Afl45Te8jSnuhz3iPxEo
         2hFX5oAMmEpCEU42t3hMx8u2hdNQCfsifRgGtrz4voZtO0r923kUPSxZI56jgD+lTnuW
         DzCHUKMVLyLIPVlGaQsk1SFlDQEmuRu8dJAQPBLX0iqtZu5+hLsXG1gngTcFsCxJZx49
         6a9w==
X-Gm-Message-State: ANhLgQ0G3FsaUZ9A1+crHTUCLzL3ul+ujTMAsiQflyEFbkvzGc/WI3IM
        hgTtxwp/D3QZpRv2qxu0/uJZTQ==
X-Google-Smtp-Source: ADFU+vvJTCE0NaoY9hAAFAj5SygbDrAri2BStTDh6/CdBA2TgHqaM/8tkrZcR45y2gjrmFw6MHuIHw==
X-Received: by 2002:a62:342:: with SMTP id 63mr11323648pfd.19.1585254850791;
        Thu, 26 Mar 2020 13:34:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l11sm2222672pjy.44.2020.03.26.13.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 13:34:09 -0700 (PDT)
Date:   Thu, 26 Mar 2020 13:34:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
Subject: Re: [RFC v3 2/2] kernel/sysctl: support handling command line aliases
Message-ID: <202003261329.AAFEE9C@keescook>
References: <20200326181606.7027-1-vbabka@suse.cz>
 <20200326181606.7027-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326181606.7027-2-vbabka@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 07:16:06PM +0100, Vlastimil Babka wrote:
> We can now handle sysctl parameters on kernel command line, but historically
> some parameters introduced their own command line equivalent, which we don't
> want to remove for compatibility reasons. We can however convert them to the
> generic infrastructure with a table translating the legacy command line
> parameters to their sysctl names, and removing the one-off param handlers.
> 
> This patch adds the support and makes the first conversion to demonstrate it,
> on the (deprecated) numa_zonelist_order parameter.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Changes in v3:
> - constify some things according to Kees
> - expand the comment of sysctl_aliases to note on different timings
> 
>  fs/proc/proc_sysctl.c | 48 ++++++++++++++++++++++++++++++++++++-------
>  mm/page_alloc.c       |  9 --------
>  2 files changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 8ee3273e4540..3a861e0a7c7e 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1729,6 +1729,37 @@ int __init proc_sys_init(void)
>  
>  struct vfsmount *proc_mnt = NULL;
>  
> +struct sysctl_alias {
> +	const char *kernel_param;
> +	const char *sysctl_param;
> +};
> +
> +/*
> + * Historically some settings had both sysctl and a command line parameter.
> + * With the generic sysctl. parameter support, we can handle them at a single
> + * place and only keep the historical name for compatibility. This is not meant
> + * to add brand new aliases. When adding existing aliases, consider whether
> + * the possibly different moment of changing the value (e.g. from early_param
> + * to the moment do_sysctl_args() is called) is an issue for the specific
> + * parameter.
> + */
> +static const struct sysctl_alias sysctl_aliases[] = {
> +	{"numa_zonelist_order",		"vm.numa_zonelist_order" },
> +	{ }
> +};
> +
> +const char *sysctl_find_alias(char *param)

This should be "static" too.

> +{
> +	const struct sysctl_alias *alias;
> +
> +	for (alias = &sysctl_aliases[0]; alias->kernel_param != NULL; alias++) {
> +		if (strcmp(alias->kernel_param, param) == 0)
> +			return alias->sysctl_param;
> +	}
> +
> +	return NULL;
> +}
> +
>  /* Set sysctl value passed on kernel command line. */
>  static int process_sysctl_arg(char *param, char *val,
>  			       const char *unused, void *arg)
> @@ -1741,15 +1772,18 @@ static int process_sysctl_arg(char *param, char *val,
>  	loff_t pos = 0;
>  	ssize_t wret;
>  
> -	if (strncmp(param, "sysctl", sizeof("sysctl") - 1))
> -		return 0;
> -
> -	param += sizeof("sysctl") - 1;
> +	if (strncmp(param, "sysctl", sizeof("sysctl") - 1) == 0) {
> +		param += sizeof("sysctl") - 1;
>  
> -	if (param[0] != '/' && param[0] != '.')
> -		return 0;
> +		if (param[0] != '/' && param[0] != '.')
> +			return 0;
>  
> -	param++;
> +		param++;
> +	} else {
> +		param = (char *) sysctl_find_alias(param);
> +		if (!param)
> +			return 0;
> +	}
>  
>  	if (!proc_mnt) {
>  		proc_fs_type = get_fs_type("proc");
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..de7a134b1b8a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5460,15 +5460,6 @@ static int __parse_numa_zonelist_order(char *s)
>  	return 0;
>  }
>  
> -static __init int setup_numa_zonelist_order(char *s)
> -{
> -	if (!s)
> -		return 0;
> -
> -	return __parse_numa_zonelist_order(s);
> -}
> -early_param("numa_zonelist_order", setup_numa_zonelist_order);
> -
>  char numa_zonelist_order[] = "Node";
>  
>  /*
> -- 
> 2.25.1
> 

Otherwise, yay, I love it! :)

-- 
Kees Cook
