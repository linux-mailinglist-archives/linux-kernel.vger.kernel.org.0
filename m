Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07F9149EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 07:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgA0GLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 01:11:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32807 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgA0GLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 01:11:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so4623154pgk.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 22:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XlOxx0+jj+Ueflcbt7+M5DoGBZOJ3YgoxX9npTLU818=;
        b=vf8y+dkIOyamo0I61J7+ZSkbJGj40SHUioxA/UvAT4mXKJOPpTWo1waDRBuWBQKGFe
         VB4npKCMULhEanj7fe7B8P0Tpm6YqrKnLnSB1yeFvIIKAc2mOQCU3qzaP7f9Jp3Lks/W
         myykYoBSgxnIpiUwckSSFRex0x/vmDrNBMpRxBLIu3KmrNHM4QwwqGBMNr+qRycfZOuj
         M9XsKdkv5UAKHg9vMRFEuDQmUgrGsepnOmykL2wWoEI0MGV+RmTS8ozosY4EKos+mJkF
         qnnM6p9WFGXItpOfMQpF4gzErGhDTlMY3VyrI1dsQwHQp0c+2p4zjnepe8qoscXiZNd5
         NwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XlOxx0+jj+Ueflcbt7+M5DoGBZOJ3YgoxX9npTLU818=;
        b=Ro2XrkkGBQCdn7G4B3svfujA6tNOA8zakBjvRZj5L0mlj6pxlgKMxI8hwRezZSzrat
         lm5WMr25j7V8gi8mxyyWZn0enk3uR/THPnRkfOeIqxXWI5NdKzqTj2CP4501R7xArQSw
         p07Vvl5Xw0XmU9UnQqBVib1kLwTk6qBBlKIztZREMupgdxRMqImt7ABu719vkBqPkPhp
         e4TGCEOW9GQ6VsCKO4pHENDZMCo1Lers5T78tq18Xr0PKaCPkF+UNEcxB+UQG3Svjh0p
         KziaGISQbHVooqCICgzM5bnTZUoKrLZR/PaK7kgN46b3A0NAHd1fqxqDCcBrHCNtAm5j
         BseQ==
X-Gm-Message-State: APjAAAWRFmFJ5afEBsirNMh0XDB1opX0dI0aQtpMIZXAQiolfC5jl1gT
        RN8+iTdmllLgi3he1YVxi46SnA==
X-Google-Smtp-Source: APXvYqwq3tBDze8fUjKjAxaItvqrHL1lPAynvz1JenxDlEme4cEH+PsLyuKkYKU8r2459NUUhS/9IA==
X-Received: by 2002:a63:554c:: with SMTP id f12mr18365168pgm.23.1580105481429;
        Sun, 26 Jan 2020 22:11:21 -0800 (PST)
Received: from localhost ([122.172.51.87])
        by smtp.gmail.com with ESMTPSA id j9sm14298014pfn.152.2020.01.26.22.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jan 2020 22:11:20 -0800 (PST)
Date:   Mon, 27 Jan 2020 11:41:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
Message-ID: <20200127061118.5bxei6nghowlmf53@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-4-saravanak@google.com>
 <20191125112812.26jk5hsdwqfnofc2@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125112812.26jk5hsdwqfnofc2@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-11-19, 16:58, Viresh Kumar wrote:
> >From 8df083ca64d82ff57f778689271cc1be75aa99c4 Mon Sep 17 00:00:00 2001
> Message-Id: <8df083ca64d82ff57f778689271cc1be75aa99c4.1574681211.git.viresh.kumar@linaro.org>
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Mon, 25 Nov 2019 13:57:58 +0530
> Subject: [PATCH] opp: Allow lazy-linking of required-opps
> 
> The OPP core currently requires the required opp tables to be available
> before the dependent OPP table is added, as it needs to create links
> from the dependent OPP table to the required ones. This may not be
> convenient to all the platforms though, as this requires strict ordering
> of probing of drivers.
> 
> This patch allows lazy-linking of the required-opps. The OPP tables for
> which the required-opp-tables aren't available at the time of their
> initialization, are added to a special list of OPP tables:
> pending_opp_tables. Later on, whenever a new OPP table is registered
> with the OPP core, we check if it is required by an OPP table in the
> pending list; if yes, then we complete the linking then and there.
> 
> An OPP table is marked unusable until the time all its required-opp
> tables are available. And if lazy-linking fails for an OPP table, the
> OPP core disables all of its OPPs to make sure no one can use them.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c |  13 ++++++
>  drivers/opp/of.c   | 113 +++++++++++++++++++++++++++++++++++++++++++--
>  drivers/opp/opp.h  |   4 +-
>  3 files changed, 124 insertions(+), 6 deletions(-)

I was hoping to queue this up for next release, any update on getting
this tested ?


-- 
viresh
