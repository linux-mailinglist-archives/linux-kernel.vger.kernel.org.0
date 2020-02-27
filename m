Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A66F17128F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 09:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgB0IaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 03:30:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40064 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgB0IaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:30:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id b185so1237682pfb.7;
        Thu, 27 Feb 2020 00:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tvby+wcv0BQs9h7cjR7fY7Khx0epyt1ALylZ/rOptsk=;
        b=tyDk7PYlcOkw+gGiTcjC/6Qa3T7IV3N+PomawQkDEiJGrEoCCxSnWkYJ5O/Fpgwyy4
         ZtOLBWdGNND4hNkyWa3dHc/ut8slDRK9rgLL8XyEfLxxueDkU/GItIt+OIyNcySmM6zR
         /qBcX92xLsADWlEomsFtB9+iYXpvy0e7guWXKMwEwgYrjdMuXHCRwFT6Kftn/IgbFTHr
         PBh442mhEugo9AJJLOM3S9Rj2ruJuhDOGfsldCMqRsLAQ6Wlbz8iWawZSfVHHd0XrQQb
         vI5L1Z98bkcjdrwpQXy9a/ATMieVCkUD1K5O0r6nVJActWwc24pkfIkMPk65i3+CJevR
         2DMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tvby+wcv0BQs9h7cjR7fY7Khx0epyt1ALylZ/rOptsk=;
        b=myGNPCF9gen1McJAPMNypCTJwaqRPnJZRF8FQ3s1koIDYnLctwuCeOR6k+87shJRNg
         4frPR/32P4MoY54qY7Zz+zX0985Tp2Hc0UEWBbhkk5X1M7AU7rNGxSQ3rJShJ0vJMI3N
         vQxX4rFs2L/2I2zRLhVV99NHYzoy/18VGU+EpT6xBJLPxDOag+ALjavG/EJJpHR+bKwx
         /IZU5NDodl9LNoj5/FYWcMDcvv/g3JxZt/TsoAvvKObDIDcmL4pY/IzE4ITDmj4Ge580
         P5SnMSfBg0oDrYEnnE0CfKBj3VH1GAWl1Tqur27ypF607rXOQLduGk91LN6aRcjSoG2e
         U67A==
X-Gm-Message-State: APjAAAV6VMbuhy9e3Yf+irxu5T2kWwul5O1VEqy8uOgfAm/jWS+fty9v
        04PfHMxD5ASNGYoCHAnQo8E=
X-Google-Smtp-Source: APXvYqwbdwa5z/Mw8fsv5fDjzzdIQEE48+SMUMGxedgroSV5O6Mz8Opk8lbDY2FoQaMBU2tprUKiPg==
X-Received: by 2002:a63:a741:: with SMTP id w1mr3064761pgo.131.1582792218623;
        Thu, 27 Feb 2020 00:30:18 -0800 (PST)
Received: from workstation-portable ([103.87.56.152])
        by smtp.gmail.com with ESMTPSA id r145sm6174967pfr.5.2020.02.27.00.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 00:30:18 -0800 (PST)
Date:   Thu, 27 Feb 2020 14:00:10 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     amanharitsh123 <amanharitsh123@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH] doc: Convert to checklist.txt to
 checklist.rst
Message-ID: <20200227083010.GB5241@workstation-portable>
References: <20200225183916.4555-1-amanharitsh123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225183916.4555-1-amanharitsh123@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 12:09:16AM +0530, amanharitsh123 wrote:
> This patch converts checklist.txt to checklist.rst and
> adds it to index.rst
> 

Hi Aman,

Thank you for the patch! But before this can be accepted there are a few
things that you need to take care of.

> Signed-off-by: amanharitsh123 <amanharitsh123@gmail.com>

1. Signed-off-by *must* *always* include your full real name. You can
modify .gitconfig, or run `git config user.name "Your Name"` to change
this.

> ---
>  Documentation/RCU/{checklist.txt => checklist.rst} | 8 +++++---
>  Documentation/RCU/index.rst                        | 1 +
>  2 files changed, 6 insertions(+), 3 deletions(-)
>  rename Documentation/RCU/{checklist.txt => checklist.rst} (99%)
> 
> diff --git a/Documentation/RCU/checklist.txt b/Documentation/RCU/checklist.rst
> similarity index 99%
> rename from Documentation/RCU/checklist.txt
> rename to Documentation/RCU/checklist.rst
> index e98ff261a438..49bf7862c950 100644
> --- a/Documentation/RCU/checklist.txt
> +++ b/Documentation/RCU/checklist.rst
> @@ -1,5 +1,7 @@
> -Review Checklist for RCU Patches
> +.. checklist doc:

2. The document identifier must always start with an underscore and
should not contain white spaces, something like:
.. _checklist_doc:
should work.

>  
> +Review Checklist for RCU Patches
> +================================
>  
>  This document contains a checklist for producing and reviewing patches
>  that make use of RCU.  Violating any of the rules listed below will
> @@ -442,8 +444,8 @@ over a rather long period of time, but improvements are always welcome!
>  
>  	You instead need to use one of the barrier functions:
>  
> -	o	call_rcu() -> rcu_barrier()
> -	o	call_srcu() -> srcu_barrier()
> +	-	call_rcu() -> rcu_barrier()
> +	-	call_srcu() -> srcu_barrier()
>  
>  	However, these barrier functions are absolutely -not- guaranteed
>  	to wait for a grace period.  In fact, if there are no call_rcu()
> diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
> index 81a0a1e5f767..d60eb4ba2cd0 100644
> --- a/Documentation/RCU/index.rst
> +++ b/Documentation/RCU/index.rst
> @@ -10,6 +10,7 @@ RCU concepts
>     arrayRCU
>     rcubarrier
>     rcu_dereference
> +   checklist
>     whatisRCU
>     rcu
>     listRCU

3. The subject line needs a bit of tweaking.

Apart from the above mentioned changes, everything looks good!

Thanks
Amol

> -- 
> 2.20.1
> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
