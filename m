Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6E2CBE8D4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 01:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfIYXOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 19:14:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38651 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfIYXOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 19:14:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so473324pfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 16:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3yR13IGBtpRxVrAvXtfdwL1FPEzwU8Klk4nC+0EqJDk=;
        b=USlapULohZkvBJ17J2gKRIWAKw/YXLuN9Fnt7BuRoAbcPLpaksvJ19mWQjaAdswy9I
         XJ3EaMa0HMcTzhP7IHvOXewlMJLc4YjrgiwltQHTNYsK9SIZ1fM4mw3qJUZ6I961Y3rq
         xMpnts49joruj2BWQz0UB7FFSvWLzWnus5LdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3yR13IGBtpRxVrAvXtfdwL1FPEzwU8Klk4nC+0EqJDk=;
        b=QsrzmM3t1qA4J9GO8a10r8LdsVQ4klM03QCXcs0tP8oBuraH9PSJ2uQLVr29pQIvaI
         ANmhW1S+VhcDlZVhT/BEALw9rSOkJpMmYOGrESfRbleq4DS5A9onJHte9vKlinRsAO/V
         kPxn0vOIJodlfbrZ0/5xkQSs+1Zhwk04rscu0EdSIUj90ygquFYfZorVTZvbFWZ7k1FP
         sDNKqum2ZP5sQ8O0aQo82yMF0kevJbhShfvsJMJLp4YYrVBePD8KPrudNb6X/zwYZfFx
         LuDuAvpEkRWzNvsuii7WodWgGAHjciLcB8nACuf0TKt8XFeSytNxb5JkqRY3u4a8J6a9
         u1jw==
X-Gm-Message-State: APjAAAXu4Ik+MYwH3qISwjxIhVpPrB0xhL4a6i/j6mb08IfmSFhPNJ2X
        DqSq/y3bgkOs/HJFsBy+rXMJpRbMgJ8=
X-Google-Smtp-Source: APXvYqy10lz2t+xFYDw8ejqY/v+AUKNcAsXJqKVO6YWQl/wFQTx9PSW3o6jaAjC3MWIfLPMq/Q3cnw==
X-Received: by 2002:a17:90a:3462:: with SMTP id o89mr238538pjb.2.1569453291258;
        Wed, 25 Sep 2019 16:14:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 22sm90977pfo.131.2019.09.25.16.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 16:14:50 -0700 (PDT)
Date:   Wed, 25 Sep 2019 16:14:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau 
        <jeremie.galarneau@efficios.com>, s.mesoraca16@gmail.com,
        viro@zeniv.linux.org.uk, dan.carpenter@oracle.com,
        akpm@linux-foundation.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel-hardening@lists.openwall.com, linux-audit@redhat.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] audit: Report suspicious O_CREAT usage
Message-ID: <201909251614.5FDA48B1@keescook>
References: <201909251348.A1542A52@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201909251348.A1542A52@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 02:02:33PM -0700, Kees Cook wrote:
> This renames the very specific audit_log_link_denied() to
> audit_log_path_denied() and adds the AUDIT_* type as an argument. This
> allows for the creation of the new AUDIT_ANOM_CREAT that can be used to
> report the fifo/regular file creation restrictions that were introduced
> in commit 30aba6656f61 ("namei: allow restricted O_CREAT of FIFOs and
> regular files"). Without this change, discovering that the restriction
> is enabled can be very challenging:
> https://lore.kernel.org/lkml/CA+jJMxvkqjXHy3DnV5MVhFTL2RUhg0WQ-XVFW3ngDQOdkFq0PA@mail.gmail.com
> 
> Reported-by: J�r�mie Galarneau <jeremie.galarneau@efficios.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This is not a complete fix because reporting was broken in commit
> 15564ff0a16e ("audit: make ANOM_LINK obey audit_enabled and
> audit_dummy_context")
> which specifically goes against the intention of these records: they
> should _always_ be reported. If auditing isn't enabled, they should be
> ratelimited.
> 
> Instead of using audit, should this just go back to using
> pr_ratelimited()?
> ---
>  fs/namei.c                 |  7 +++++--
>  include/linux/audit.h      |  5 +++--
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 11 ++++++-----
>  4 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 671c3c1a3425..0e60f81e1d5a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -925,7 +925,7 @@ static inline int may_follow_link(struct nameidata *nd)
>  		return -ECHILD;
>  
>  	audit_inode(nd->name, nd->stack[0].link.dentry, 0);
> -	audit_log_link_denied("follow_link");
> +	audit_log_path_denied(AUDIT_ANOM_LINK, "follow_link");
>  	return -EACCES;
>  }
>  
> @@ -993,7 +993,7 @@ static int may_linkat(struct path *link)
>  	if (safe_hardlink_source(inode) || inode_owner_or_capable(inode))
>  		return 0;
>  
> -	audit_log_link_denied("linkat");
> +	audit_log_path_denied(AUDIT_ANOM_LINK, "linkat");
>  	return -EPERM;
>  }
>  
> @@ -1031,6 +1031,9 @@ static int may_create_in_sticky(struct dentry * const dir,
>  	    (dir->d_inode->i_mode & 0020 &&
>  	     ((sysctl_protected_fifos >= 2 && S_ISFIFO(inode->i_mode)) ||
>  	      (sysctl_protected_regular >= 2 && S_ISREG(inode->i_mode))))) {
> +		audit_log_path_denied(AUDIT_ANOM_CREAT,
> +				      S_ISFIFO(inode->i_mode) ? "fifo"
> +							      : "regular");
>  		return -EACCES;
>  	}
>  	return 0;
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index aee3dc9eb378..b3715e2ee1c5 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -156,7 +156,8 @@ extern void		    audit_log_d_path(struct audit_buffer *ab,
>  					     const struct path *path);
>  extern void		    audit_log_key(struct audit_buffer *ab,
>  					  char *key);
> -extern void		    audit_log_link_denied(const char *operation);
> +extern void		    audit_log_path_denied(int type,
> +						  const char *operation);
>  extern void		    audit_log_lost(const char *message);
>  
>  extern int audit_log_task_context(struct audit_buffer *ab);
> @@ -217,7 +218,7 @@ static inline void audit_log_d_path(struct audit_buffer *ab,
>  { }
>  static inline void audit_log_key(struct audit_buffer *ab, char *key)
>  { }
> -static inline void audit_log_link_denied(const char *string)
> +static inline void audit_log_path_denied(int type, const char *string);

Oops, typo above (should be no trailing ";"). Thanks 0day-bot! I didn't
build without CONFIG_AUDIT. :)

-Kees

>  { }
>  static inline int audit_log_task_context(struct audit_buffer *ab)
>  {
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index c89c6495983d..3ad935527177 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -143,6 +143,7 @@
>  #define AUDIT_ANOM_PROMISCUOUS      1700 /* Device changed promiscuous mode */
>  #define AUDIT_ANOM_ABEND            1701 /* Process ended abnormally */
>  #define AUDIT_ANOM_LINK		    1702 /* Suspicious use of file links */
> +#define AUDIT_ANOM_CREAT	    1703 /* Suspicious file creation */
>  #define AUDIT_INTEGRITY_DATA	    1800 /* Data integrity verification */
>  #define AUDIT_INTEGRITY_METADATA    1801 /* Metadata integrity verification */
>  #define AUDIT_INTEGRITY_STATUS	    1802 /* Integrity enable status */
> diff --git a/kernel/audit.c b/kernel/audit.c
> index da8dc0db5bd3..ed7402ac81b6 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2155,18 +2155,19 @@ void audit_log_task_info(struct audit_buffer *ab)
>  EXPORT_SYMBOL(audit_log_task_info);
>  
>  /**
> - * audit_log_link_denied - report a link restriction denial
> - * @operation: specific link operation
> + * audit_log_path_denied - report a path restriction denial
> + * @type: audit message type (AUDIT_ANOM_LINK, AUDIT_ANOM_CREAT, etc)
> + * @operation: specific operation name
>   */
> -void audit_log_link_denied(const char *operation)
> +void audit_log_path_denied(int type, const char *operation)
>  {
>  	struct audit_buffer *ab;
>  
>  	if (!audit_enabled || audit_dummy_context())
>  		return;
>  
> -	/* Generate AUDIT_ANOM_LINK with subject, operation, outcome. */
> -	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_ANOM_LINK);
> +	/* Generate log with subject, operation, outcome. */
> +	ab = audit_log_start(audit_context(), GFP_KERNEL, type);
>  	if (!ab)
>  		return;
>  	audit_log_format(ab, "op=%s", operation);
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook

-- 
Kees Cook
