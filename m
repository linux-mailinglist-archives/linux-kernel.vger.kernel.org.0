Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9072C168422
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 17:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgBUQvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 11:51:44 -0500
Received: from namei.org ([65.99.196.166]:47390 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgBUQvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:51:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 01LGpOnL014504;
        Fri, 21 Feb 2020 16:51:24 GMT
Date:   Sat, 22 Feb 2020 03:51:24 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Jeremy Cline <jcline@redhat.com>
cc:     "Serge E . Hallyn" <serge@hallyn.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Frank Ch . Eigler" <fche@redhat.com>
Subject: Re: [PATCH] lockdown: Allow unprivileged users to see lockdown
 status
In-Reply-To: <20200220151738.1492852-1-jcline@redhat.com>
Message-ID: <alpine.LRH.2.21.2002220351010.18183@namei.org>
References: <20200220151738.1492852-1-jcline@redhat.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020, Jeremy Cline wrote:

> A number of userspace tools, such as systemtap, need a way to see the
> current lockdown state so they can gracefully deal with the kernel being
> locked down. The state is already exposed in
> /sys/kernel/security/lockdown, but is only readable by root. Adjust the
> permissions so unprivileged users can read the state.
> 
> Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
> Cc: Frank Ch. Eigler <fche@redhat.com>
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

Looks fine to me, any objection from Matthew or others?

> ---
>  security/lockdown/lockdown.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 5a952617a0eb..87cbdc64d272 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -150,7 +150,7 @@ static int __init lockdown_secfs_init(void)
>  {
>  	struct dentry *dentry;
>  
> -	dentry = securityfs_create_file("lockdown", 0600, NULL, NULL,
> +	dentry = securityfs_create_file("lockdown", 0644, NULL, NULL,
>  					&lockdown_ops);
>  	return PTR_ERR_OR_ZERO(dentry);
>  }
> 

-- 
James Morris
<jmorris@namei.org>

