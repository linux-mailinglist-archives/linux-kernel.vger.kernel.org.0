Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 699C2169960
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 19:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgBWSRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 13:17:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40050 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgBWSRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 13:17:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so7036990wmi.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 10:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4TkhGzPTHYU9WIFL2KaQh+xVHEKtwoMX92MJCQKBhTA=;
        b=cSIy9vOlps5K28Y/VDG6OWUg0Flltw+6kZMtWERGreHD6bg2EY0kt7VHlJHa3fdIM+
         mAfIx+Fez7oSt3hkY05io50dHaPJg4lVJgYt8Ul5nVF4sYV/1XrX7xeu86ZXTqcJ0N08
         NHm/2jIIeJtTq9tfUDIyW0NdJiboVm0I4DHoQYJ39STXDUSsd48QCKvFG7byqU5kibe6
         SOrHJlSV5QWucDJKIGsmyVGVI7rZhA+ztY5gNsYzQhfH9ZRFPLGjXJg1Jj9EUoUmAfeg
         MiCpdT5x1+r8GqAxg/YariyXfvU7biXcEFdHjaktuGWX9jF6/VgYMRxKaM8qZ9uJd/8n
         B5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4TkhGzPTHYU9WIFL2KaQh+xVHEKtwoMX92MJCQKBhTA=;
        b=jM5nAIz1U1LvuGvFgzDwiLrUO0b0GIbhr0r55wQdCqyOWpIzM7LD0cZZhHJ4hvDRoN
         ji/LoZoO9JkrNlf/A9kL2EqgSES5P7Wuh2uRHnLpvg7KjexYvjFeE0IIhxA5Cy7u51cF
         AkJZkobL5ZaCTqnyJDaLNidQd91tIw777okx+w6P3DEdNT3tvRfOPL6hj12+AKhY0QOb
         0deQR4ybygTTH36Plc0nk+TY8UUbHGdxuxffyXCEANtHkncU4pnofwRBXGI5W/6JFcE0
         75TiQOLG9iip35JYlXZothXFk60XLv0EGfo2zH+EihvG2+9QZKdzu8tTInb6vTpB5qPL
         DdiQ==
X-Gm-Message-State: APjAAAVsOJ3rmVsoKpGZNwEvDkbGfglupVIrptX2lfeA5HSPjujwcxsZ
        o80uftJU4PqMl+kVyb/ulriAmA==
X-Google-Smtp-Source: APXvYqxJVibj3AgMIrzfKurP0T124n6y0mdQsSI+p2iyicYWrgiVPyR+2hAAVNeCUK9NUQE80F4VQg==
X-Received: by 2002:a1c:990b:: with SMTP id b11mr17224631wme.15.1582481867966;
        Sun, 23 Feb 2020 10:17:47 -0800 (PST)
Received: from localhost (ip-89-177-130-96.net.upcbroadband.cz. [89.177.130.96])
        by smtp.gmail.com with ESMTPSA id r1sm13919375wrx.11.2020.02.23.10.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 10:17:47 -0800 (PST)
Date:   Sun, 23 Feb 2020 19:17:46 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     madhuparnabhowmik10@gmail.com
Cc:     jiri@mellanox.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org
Subject: Re: [PATCH] net: core: devlink.c: Hold devlink->lock from the
 beginning of devlink_dpipe_table_register()
Message-ID: <20200223181746.GF2228@nanopsycho>
References: <20200223112233.13417-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223112233.13417-1-madhuparnabhowmik10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Feb 23, 2020 at 12:22:33PM CET, madhuparnabhowmik10@gmail.com wrote:
>From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
>devlink_dpipe_table_find() should be called under either
>rcu_read_lock() or devlink->lock. devlink_dpipe_table_register()
>calls devlink_dpipe_table_find() without holding the lock
>and acquires it later. Therefore hold the devlink->lock
>from the beginning of devlink_dpipe_table_register().
>
>Suggested-by: Jiri Pirko <jiri@mellanox.com>
>Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Reviewed-by: Jiri Pirko <jiri@mellanox.com>
