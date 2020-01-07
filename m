Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587CE131FE3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 07:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgAGGlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 01:41:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40667 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAGGlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:41:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so28103433pfh.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 22:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XstUhmY/YkSGwKvN4vcBunQP4Q1xbCGHu5HvS0GQt7M=;
        b=efXqnL53H3PkXbS1e1wybpPxBF6yN8o6MuSnaNRd1bmiokFeNCZjVN/EeIYnWpJ5AP
         oaIlRMN+K8ee5tDPeOEJX+Ddx0Rv8QOh+qZDOFp4cxcWDjm9Ju6qMrdi5KyCnRiNy2f5
         q/OjwwYhyvGZpWidiEk8t0mMUIGchRjpEGqLeBvbp4JviixSfpsS30mT0tBytVCpTUFK
         AVhBbAZVglzC0/v0KzdfeXPqDmASCzJNSp4lQBHWeLzAdkmG1Z9ZWeJyQQdQrtQHRIi1
         3+sZN/I04mvPAMEWptKZB2d+EBc93vFQNkhs4EVoRBeet2NPo89XTRJeEwjbj+Yqi4uG
         r0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XstUhmY/YkSGwKvN4vcBunQP4Q1xbCGHu5HvS0GQt7M=;
        b=JOsZVCgvhfDjLf+n+lUHW33hMwj9NGFMNnEvrSzuO6rwX/Yw3veUSo5ZSp1K+VlJcG
         80wczdCYg6ZuHptSaBRVmFVZOOWqKHIrhh4boiW95uT0J2mJKutgQvRQG5JNp8Cw/Uww
         sd0AmLCAmeJ95E1uRUnF3GDJbTsPAi33UB9nH51NUA8B1m4V+Gc54H1ZOyRS4cQawYBk
         TJJp/KU8x5KN1ANIM2YJ2PSgEo0bhVyhNfkf7r23pz3K4mYqC2MVHtOLekfRIm4fr4hN
         lZ5Gea7cPQ0JI0OySwgKPGJzcsr66eJebP7yGMIIllwScu8z8Kz5/ttbg8cLwNNSqPs4
         5C8A==
X-Gm-Message-State: APjAAAWOa1iJZ9JQhwinaGKLVPTUFZYepRhP1PpGwNbDbttJiR+3sZR8
        HQgsYGuwu45ya0+zTWRJIbQ8cA==
X-Google-Smtp-Source: APXvYqy+6YwckmrUe/l4OGtN1B7r1kkzFWLgWuImOvJI/fI7MvMdDKhTFGUOIE/R67rUjlk+YLmW5A==
X-Received: by 2002:a63:6ac1:: with SMTP id f184mr2154205pgc.133.1578379291561;
        Mon, 06 Jan 2020 22:41:31 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id l186sm75585493pge.31.2020.01.06.22.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 22:41:30 -0800 (PST)
Date:   Tue, 7 Jan 2020 12:11:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] opp: quiet down WARN when no valid OPPs remain
Message-ID: <20200107064128.gkeq2ejtvx4bmyhj@vireshk-i7>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
 <5c2d6548aef35c690535fd8c985b980316745e91.1578077228.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c2d6548aef35c690535fd8c985b980316745e91.1578077228.git.mirq-linux@rere.qmqm.pl>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-01-20, 20:36, Michał Mirosław wrote:
> Per CPU screenful of backtraces is not really that useful. Replace
> WARN with a diagnostic discriminating common causes of empty OPP table.

But why should a platform have an OPP table in DT where none of them works for
it ? I added the warn intentionally here just for that case.

-- 
viresh
