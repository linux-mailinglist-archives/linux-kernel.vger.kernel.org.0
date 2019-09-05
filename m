Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1940AAE79
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 00:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389840AbfIEW3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 18:29:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43930 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfIEW3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 18:29:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id u72so2236398pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 15:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s+sueiFggHK4S3ifsIGTWqOmnYdWRahnyjO7JP923fw=;
        b=i71t0S/nQaJxz9y3FGAA6i+INjYlVJQ/aNBxRdcrSt5m4s0F6DLLsMbKqQaGAl28kN
         PFUxg5F/a/3O/D24nodsx0qfjcsm9uffdvEPfgPO2NKt10y8uq1ZDwFpMFCYFXgrCj0g
         xa81cdaHjKVDN969QzmGkKUxTzociVeC5SdFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s+sueiFggHK4S3ifsIGTWqOmnYdWRahnyjO7JP923fw=;
        b=kI46K0CRH0ckFSJxfQ7KGwuCObxvRrQT472eOmcfaLsoC2wGq7UREaUVI/nwR3/Szq
         aoTfe2IiIrfQ9GbbqUQuCejV9fcePEbF3IAgdHoMCOJGu95Gix5q9OerqJZ/6R5bb10r
         2mH7Q3NM6eHK4zjV7SXOHzRUFdinVf83cFh22aE8cHQEk2WGNR/Mut8a9MdDNWb07SUz
         ibNrSR4lG4VkSDjoCCb7vB7BYhXlvPGtmj1nhtZKJvFiv9c3j1qMe6ii1akobaGRlWCs
         s2LH7TEJSsVV2N9CV2NtGKr1QKGjcF382rR01Jo98DAVXNYHCtdl6GZjdoJCTlr2MM3X
         J2JA==
X-Gm-Message-State: APjAAAVaLzsBR+NCjiGwoWNXb/yItgrkwBfkMcPxcV8MDmPJz6i8+ael
        sfS6h5LwlUh0Jhlc2RIxY70hRQ==
X-Google-Smtp-Source: APXvYqzVubawcpR3Xi9NWFfLnk2RShrj+hrkp6Gq7AT/1Ls34UaN9LljK/4Kf7K5J1GZxsOxX93q2A==
X-Received: by 2002:a63:a011:: with SMTP id r17mr5387281pge.219.1567722592691;
        Thu, 05 Sep 2019 15:29:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w13sm3678817pfi.30.2019.09.05.15.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 15:29:51 -0700 (PDT)
Date:   Thu, 5 Sep 2019 15:29:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] Simplify string_escape_mem
Message-ID: <201909051520.94549AE@keescook>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
 <1567712673-1629-7-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567712673-1629-7-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:44:31PM -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> string_escape_mem is harder to use than necessary:
> 
> 	- ESCAPE_NP sounds like it means "escape nonprinting
> 	  characters", but actually means "do not escape printing
> 	  characters"
> 	- the use of the "only" string to limit the list of escaped
> 	  characters rather than supplement them is confusing and
> 	  unehlpful.
> 
> So:
> 
> 	- use the "only" string to add to, rather than replace, the list
> 	  of characters to escape
> 	- separate flags into those that select which characters to
> 	  escape, and those that choose the format of the escaping ("\ "
> 	  vs "\x20" vs "\040".)  Make flags that select characters just
> 	  select the union when they're OR'd together.
> 
> Untested.  The tests themselves, especially, I'm unsure about.

I'll take a look at these too. Notes below...

> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/proc/array.c                |  2 +-
>  fs/seq_file.c                  |  2 +-
>  include/linux/string_helpers.h | 14 +++----
>  lib/string_helpers.c           | 76 +++++++++++++++-------------------
>  lib/test-string_helpers.c      | 41 ++++++++----------
>  lib/vsprintf.c                 |  2 +-
>  net/sunrpc/cache.c             |  2 +-
>  7 files changed, 62 insertions(+), 77 deletions(-)
> 
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 982c95d09176..bdeeb3318fa2 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -111,7 +111,7 @@ void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
>  	size = seq_get_buf(m, &buf);
>  	if (escape) {
>  		ret = string_escape_str(tcomm, buf, size,
> -					ESCAPE_SPECIAL, "\n\\");
> +					ESCAPE_STYLE_SLASH, "\n\\");
>  		if (ret >= size)
>  			ret = -1;
>  	} else {
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 1600034a929b..63e5a7c4dbf7 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -379,7 +379,7 @@ void seq_escape(struct seq_file *m, const char *s, const char *esc)
>  	size_t size = seq_get_buf(m, &buf);
>  	int ret;
>  
> -	ret = string_escape_str(s, buf, size, ESCAPE_OCTAL, esc);
> +	ret = string_escape_str(s, buf, size, ESCAPE_STYLE_OCTAL, esc);
>  	seq_commit(m, ret < size ? ret : -1);
>  }
>  EXPORT_SYMBOL(seq_escape);
> diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
> index 7bf0d137373d..5d350f7f6874 100644
> --- a/include/linux/string_helpers.h
> +++ b/include/linux/string_helpers.h
> @@ -41,13 +41,13 @@ static inline int string_unescape_any_inplace(char *buf)
>  	return string_unescape_any(buf, buf, 0);
>  }
>  
> -#define ESCAPE_SPECIAL		0x02
> -#define ESCAPE_OCTAL		0x08
> -#define ESCAPE_ANY		(ESCAPE_OCTAL | ESCAPE_SPECIAL)
> -#define ESCAPE_NP		0x10
> -#define ESCAPE_ANY_NP		(ESCAPE_ANY | ESCAPE_NP)
> -#define ESCAPE_HEX		0x20
> -#define ESCAPE_FLAG_MASK	0x3a
> +#define ESCAPE_SPECIAL		0x01
> +#define ESCAPE_NP		0x02
> +#define ESCAPE_ANY_NP		(ESCAPE_SPECIAL | ESCAPE_NP)
> +#define ESCAPE_STYLE_SLASH	0x20
> +#define ESCAPE_STYLE_OCTAL	0x40
> +#define ESCAPE_STYLE_HEX	0x80
> +#define ESCAPE_FLAG_MASK	0xe3
>  
>  int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
>  		unsigned int flags, const char *only);
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index ac72159d3980..47f40406f9d4 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -400,6 +400,11 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
>  	return true;
>  }
>  
> +static bool is_special(char c)
> +{
> +	return c == '\0' || strchr("\f\n\r\t\v\\\a\e", c);
> +}
> +
>  /**
>   * string_escape_mem - quote characters in the given memory buffer
>   * @src:	source buffer (unescaped)
> @@ -407,23 +412,18 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
>   * @dst:	destination buffer (escaped)
>   * @osz:	destination buffer size
>   * @flags:	combination of the flags
> - * @only:	NULL-terminated string containing characters used to limit
> - *		the selected escape class. If characters are included in @only
> - *		that would not normally be escaped by the classes selected
> - *		in @flags, they will be copied to @dst unescaped.
> + * @esc:	NULL-terminated string containing characters which
> + *		should also be escaped.
>   *
> - * Description:
> - * The process of escaping byte buffer includes several parts. They are applied
> - * in the following sequence.
>   *
> - *	1. The character is matched to the printable class, if asked, and in
> - *	   case of match it passes through to the output.
> - *	2. The character is not matched to the one from @only string and thus
> - *	   must go as-is to the output.
> - *	3. The character is checked if it falls into the class given by @flags.
> - *	   %ESCAPE_OCTAL and %ESCAPE_HEX are going last since they cover any
> - *	   character. Note that they actually can't go together, otherwise
> - *	   %ESCAPE_HEX will be ignored.
> + * Description:
> + * The characters selected by ESCAPE_* flags and by the "esc" string
> + * are escaped, using the escaping specified by the ESCAPE_STYLE_*
> + * flags.  If ESCAPE_STYLE_SLASH is specified together with one of the
> + * ESCAPE_STYLE_OCTAL or ESCAPE_STYLE_HEX flags, then those characters
> + * for which special slash escapes exist will be escaped using those,
> + * with others escaped using octal or hexidecimal values.  If
> + * unspecified, the default is ESCAPE_STYLE_OCTAL.
>   *
>   * Caller must provide valid source and destination pointers. Be aware that
>   * destination buffer will not be NULL-terminated, thus caller have to append
> @@ -439,14 +439,14 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
>   *		'\a' - alert (BEL)
>   *		'\e' - escape
>   *		'\0' - null
> - *	%ESCAPE_OCTAL:
> - *		'\NNN' - byte with octal value NNN (3 digits)
> - *	%ESCAPE_ANY:
> - *		all previous together
>   *	%ESCAPE_NP:
>   *		escape only non-printable characters (checked by isprint)
>   *	%ESCAPE_ANY_NP:
>   *		all previous together
> + *	%ESCAPE_STYLE_SLASH:
> + *		Escape using the slash codes shown above
> + *	%ESCAPE_STYLE_OCTAL:
> + *		'\NNN' - byte with octal value NNN (3 digits)
>   *	%ESCAPE_HEX:
>   *		'\xHH' - byte with hexadecimal value HH (2 digits)
>   *
> @@ -457,39 +457,31 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
>   * dst for a '\0' terminator if and only if ret < osz.
>   */
>  int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
> -		      unsigned int flags, const char *only)
> +		      unsigned int flags, const char *esc)
>  {
>  	char *p = dst;
>  	char *end = p + osz;
> -	bool is_dict = only && *only;
> +	bool is_dict = esc && *esc;
>  
>  	while (isz--) {
>  		unsigned char c = *src++;
>  
> -		/*
> -		 * Apply rules in the following sequence:
> -		 *	- the character is printable, when @flags has
> -		 *	  %ESCAPE_NP bit set
> -		 *	- the @only string is supplied and does not contain a
> -		 *	  character under question
> -		 *	- the character doesn't fall into a class of symbols
> -		 *	  defined by given @flags
> -		 * In these cases we just pass through a character to the
> -		 * output buffer.
> -		 */
> -		if ((flags & ESCAPE_NP && isprint(c)) ||
> -		    (is_dict && !strchr(only, c))) {
> -			/* do nothing */
> -		} else {
> -			if (flags & ESCAPE_SPECIAL && escape_special(c, &p, end))
> -				continue;
> +		if ((is_dict && strchr(esc, c)) ||
> +		    (flags & ESCAPE_NP && !isprint(c)) ||
> +		    (flags & ESCAPE_SPECIAL && is_special(c))) {

One thing that needs fixing a bit here is the handling of '\' in input
strings. Anything that does escaping must escape '\' as well otherwise
output string encodings can be spoofed. e.g. input of "\100" doing
non-printable escaping will not escape anything, but anything trying to
reconstruct the input from the output will process it as "@" (octal
100). So "\" must always be escaped (and I think this was a bug in the
old handling too.) So I think it likely needs to be explicitly included,
maybe like this:

		if ((is_dict && strchr(esc, c)) || c == '\' ||
		    (flags & ESCAPE_NP && !isprint(c)) ||
		    (flags & ESCAPE_SPECIAL && is_special(c))) {

Or maybe a mask can be used to check "flags" for non-style escape flags
being requested and if any are set, make sure '\' is included.

-Kees

>  
> -			/* ESCAPE_OCTAL and ESCAPE_HEX always go last */
> -			if (flags & ESCAPE_OCTAL && escape_octal(c, &p, end))
> +			if (flags & ESCAPE_STYLE_SLASH &&
> +					escape_special(c, &p, end))
>  				continue;
>  
> -			if (flags & ESCAPE_HEX && escape_hex(c, &p, end))
> +			if (flags & ESCAPE_STYLE_HEX &&
> +					escape_hex(c, &p, end))
>  				continue;
> +			/*
> +			 * Always the default, so a caller doesn't
> +			 * accidentally leave something unescaped:
> +			 */
> +			escape_octal(c, &p, end);
>  		}
>  
>  		escape_passthrough(c, &p, end);
> @@ -526,7 +518,7 @@ char *kstrdup_quotable(const char *src, gfp_t gfp)
>  {
>  	size_t slen, dlen;
>  	char *dst;
> -	const int flags = ESCAPE_HEX;
> +	const int flags = ESCAPE_STYLE_HEX;
>  	const char esc[] = "\f\n\r\t\v\a\e\\\"";
>  
>  	if (!src)
> diff --git a/lib/test-string_helpers.c b/lib/test-string_helpers.c
> index 0da3c195a327..d40fedab24ad 100644
> --- a/lib/test-string_helpers.c
> +++ b/lib/test-string_helpers.c
> @@ -127,13 +127,13 @@ static const struct test_string_2 escape0[] __initconst = {{
>  	.in = "\\h\\\"\a\e\\",
>  	.s1 = {{
>  		.out = "\\\\h\\\\\"\\a\\e\\\\",
> -		.flags = ESCAPE_SPECIAL,
> +		.flags = ESCAPE_SPECIAL | ESCAPE_STYLE_SLASH,
>  	},{
>  		.out = "\\\\\\150\\\\\\042\\a\\e\\\\",
> -		.flags = ESCAPE_SPECIAL | ESCAPE_OCTAL,
> +		.flags = ESCAPE_SPECIAL | ESCAPE_STYLE_SLASH | ESCAPE_STYLE_OCTAL,
>  	},{
>  		.out = "\\\\\\x68\\\\\\x22\\a\\e\\\\",
> -		.flags = ESCAPE_SPECIAL | ESCAPE_HEX,
> +		.flags = ESCAPE_SPECIAL | ESCAPE_STYLE_SLASH | ESCAPE_STYLE_HEX,
>  	},{
>  		/* terminator */
>  	}},
> @@ -141,28 +141,19 @@ static const struct test_string_2 escape0[] __initconst = {{
>  	.in = "\eb \\C\007\"\x90\r]",
>  	.s1 = {{
>  		.out = "\\eb \\\\C\\a\"\x90\\r]",
> -		.flags = ESCAPE_SPECIAL,
> -	},{
> -		.out = "\\033\\142\\040\\134\\103\\007\\042\\220\\015\\135",
> -		.flags = ESCAPE_OCTAL,
> +		.flags = ESCAPE_SPECIAL | ESCAPE_STYLE_SLASH,
>  	},{
>  		.out = "\\e\\142\\040\\\\\\103\\a\\042\\220\\r\\135",
> -		.flags = ESCAPE_SPECIAL | ESCAPE_OCTAL,
> -	},{
> -		.out = "\eb \\C\007\"\x90\r]",
> -		.flags = ESCAPE_NP,
> +		.flags = ESCAPE_SPECIAL | ESCAPE_STYLE_SLASH | ESCAPE_STYLE_OCTAL,
>  	},{
>  		.out = "\\eb \\C\\a\"\x90\\r]",
> -		.flags = ESCAPE_SPECIAL | ESCAPE_NP,
> -	},{
> -		.out = "\\033b \\C\\007\"\\220\\015]",
> -		.flags = ESCAPE_OCTAL | ESCAPE_NP,
> +		.flags = ESCAPE_SPECIAL | ESCAPE_STYLE_SLASH | ESCAPE_STYLE_OCTAL,
>  	},{
>  		.out = "\\eb \\C\\a\"\\220\\r]",
> -		.flags = ESCAPE_SPECIAL ESCAPE_OCTAL | ESCAPE_NP,
> +		.flags = ESCAPE_SPECIAL | ESCAPE_STYLE_OCTAL | ESCAPE_NP,
>  	},{
>  		.out = "\\x1bb \\C\\x07\"\\x90\\x0d]",
> -		.flags = ESCAPE_NP | ESCAPE_HEX,
> +		.flags = ESCAPE_NP | ESCAPE_STYLE_HEX,
>  	},{
>  		/* terminator */
>  	}},
> @@ -175,10 +166,10 @@ static const struct test_string_2 escape1[] __initconst = {{
>  	.in = "\f\\ \n\r\t\v",
>  	.s1 = {{
>  		.out = "\f\\134\\040\n\\015\\011\v",
> -		.flags = ESCAPE_OCTAL,
> +		.flags = ESCAPE_STYLE_OCTAL,
>  	},{
>  		.out = "\f\\x5c\\x20\n\\x0d\\x09\v",
> -		.flags = ESCAPE_HEX,
> +		.flags = ESCAPE_STYLE_HEX,
>  	},{
>  		/* terminator */
>  	}},
> @@ -186,7 +177,7 @@ static const struct test_string_2 escape1[] __initconst = {{
>  	.in = "\\h\\\"\a\e\\",
>  	.s1 = {{
>  		.out = "\\134h\\134\"\a\e\\134",
> -		.flags = ESCAPE_OCTAL,
> +		.flags = ESCAPE_STYLE_OCTAL,
>  	},{
>  		/* terminator */
>  	}},
> @@ -194,7 +185,7 @@ static const struct test_string_2 escape1[] __initconst = {{
>  	.in = "\eb \\C\007\"\x90\r]",
>  	.s1 = {{
>  		.out = "\e\\142\\040\\134C\007\"\x90\\015]",
> -		.flags = ESCAPE_OCTAL,
> +		.flags = ESCAPE_STYLE_OCTAL,
>  	},{
>  		/* terminator */
>  	}},
> @@ -211,9 +202,9 @@ static __init const char *test_string_find_match(const struct test_string_2 *s2,
>  	if (!flags)
>  		return s2->in;
>  
> -	/* ESCAPE_OCTAL has a higher priority */
> -	if (flags & ESCAPE_OCTAL)
> -		flags &= ~ESCAPE_HEX;
> +	/* ESCAPE_OCTAL is default: */
> +	if (!(flags & ESCAPE_STYLE_HEX))
> +		flags |= ESCAPE_STYLE_OCTAL;
>  
>  	for (i = 0; i < TEST_STRING_2_MAX_S1 && s1->out; i++, s1++)
>  		if (s1->flags == flags)
> @@ -266,6 +257,8 @@ static __init void test_string_escape(const char *name,
>  		memcpy(&out_test[q_test], out, len);
>  		q_test += len;
>  	}
> +	if (!p)
> +		goto out;
>  
>  	q_real = string_escape_mem(in, p, out_real, out_size, flags, esc);
>  
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 5522d2a052e1..020aff0c3fd9 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1553,7 +1553,7 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
>  	 * had the buffer been big enough.
>  	 */
>  	buf += string_escape_mem(addr, len, buf, buf < end ? end - buf : 0,
> -				 ESCAPE_ANY_NP, NULL);
> +				 ESCAPE_ANY_NP|ESCAPE_STYLE_SLASH, NULL);
>  
>  	return buf;
>  }
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index 6f1528f271ee..1b5a2b9e7808 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -1118,7 +1118,7 @@ void qword_add(char **bpp, int *lp, char *str)
>  
>  	if (len < 0) return;
>  
> -	ret = string_escape_str(str, bp, len, ESCAPE_OCTAL, "\\ \n\t");
> +	ret = string_escape_str(str, bp, len, ESCAPE_STYLE_OCTAL, "\\ \n\t");
>  	if (ret >= len) {
>  		bp += len;
>  		len = -1;
> -- 
> 2.21.0
> 

-- 
Kees Cook
