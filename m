Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D8512DFDF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 18:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgAAR7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 12:59:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38229 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgAAR7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 12:59:35 -0500
Received: by mail-qt1-f194.google.com with SMTP id n15so33404014qtp.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SYGoSQGhI9waAhjdEyjLiqThtN+CZhG7eOuu0haMJuw=;
        b=nw3uHhs8zlT7ka7gdHJe9c5myQOGnVFAbeNTgMHd1oTID6IVCVAnX2ZMT/bsgO0ycM
         BN6LJi4S1aHnCvSK6RjRf9cIaRxT/4j77j82R3BwQ+tPsZSEEiIA7YSOGhtHAtniwUHO
         uiAxxnQwgB4I0pJzZ/9UBTONGr9OO3bk7m2cbARBB7LPpRXw93QRtDdF0X+1YVVGq+gX
         SKtqkXWyx1bhxWppS5goo7Wd3fudFxtIj2ax44GnIujqljQBt0tJqm5HOcexSa5M3DaC
         oly16l1+IX/6O7m5Z3fAUa5woWlxOXrKNOJOmUBFkWjjC2HU1CLy9swMt223Va1vtl5X
         RGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SYGoSQGhI9waAhjdEyjLiqThtN+CZhG7eOuu0haMJuw=;
        b=H242flilG0m7H5oCxwc6PNeg9fWPTwhOvKwqgNx0UrYi1Yu4TUqvnl2lXn5ShF2B1O
         2Ibv7drmyb1HziLYFZjGrnDD448ymsvEo3YpwB//lkPPPeILJcwH8Ysf7kc9ulQ4kp9r
         US9Cxq7eyPLNx5GCHPDT7DQrAF4Ld4OqFKqzggSBrtuRLYT7NMpg4b5A3YEyogZGm1lr
         x+w9k30RVIXrlODBYxCYzJfNGoe3MrynjYZDEUdZDNy2fbifwxZLhvICl31QiH1nOiAt
         3GaoQySZT9+rxKoBeI0OaV6sVDxHxdDN7W4td0R5eoyLY/hGuuuTMshrToWiVY6oPXvQ
         dXOA==
X-Gm-Message-State: APjAAAUn+lTLLbpmJv5+iJ7YZ3nq4jPboc0Kkwc3B8ynfdLo7tafXp3U
        OwoD4C3h693j3LdY+eSNHcw=
X-Google-Smtp-Source: APXvYqwY7OERVBU/b50ZAQ30Vw5WkU39Zzn543CWrUm8P5YCBZOrGCyUoHGWRW5Kse3L3PuEMJ5wxA==
X-Received: by 2002:ac8:276a:: with SMTP id h39mr50019289qth.207.1577901574147;
        Wed, 01 Jan 2020 09:59:34 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o6sm14342474qkk.53.2020.01.01.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 09:59:33 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 1 Jan 2020 12:59:32 -0500
To:     youling 257 <youling257@gmail.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
Message-ID: <20200101175931.GA183871@rani.riverdale.lan>
References: <20191231150226.GA523748@light.dominikbrodowski.net>
 <20200101003017.GA116793@rani.riverdale.lan>
 <20200101104313.GA666771@light.dominikbrodowski.net>
 <CAOzgRdZ0eBNKAP_T8r=MF35WUtUMn07-14OwA+AXACyY=r5hqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOzgRdZ0eBNKAP_T8r=MF35WUtUMn07-14OwA+AXACyY=r5hqA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2020 at 09:27:27PM +0800, youling 257 wrote:
> Unfortunately, test this patch still no help, has system/bin/sh warning.
> 

Just to confirm, the only change needed to make the warning go away is
reverting the single commit 8243186f0cc7 ("fs: remove ksys_dup()")?

I don't get how that thing, even if it gets something wrong, impacts the
shell on a virtual console, which should be a long way downstream from
the init process that got handed /dev/console.
