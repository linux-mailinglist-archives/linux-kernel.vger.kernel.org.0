Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23DBD505FF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 11:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfFXJnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 05:43:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34422 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfFXJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:43:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so7205806pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dV+hpYbGfRGXFvtF+Lfe9yalvB//tMvrxl/pRmYwcng=;
        b=SQ/ngd4msMUIPRv2c/dYdDsed9ND7ilayDReo1/ls41mTFqemaMtbzZKrBfYs/B78t
         uA6r6vhUR5aKBJK1fPTYE9NiZcr0v+FlmWBDLD8tnyryBjZr3kZzGwJx/yQTqFez94s3
         ryKPQk3139Y84cKLunqaFt+JZj7TiF4m375GAoiKaAa1iB7CiZQZUWb3qykhXQ2nTo1I
         lNhZaCcqGIUPSMUQ28qA+ltUtaECfZrFQ3ENnRxeS+Pg3kWSf4LylEWZuo8GxVuIZwid
         wxiJW2bOwj6Bsps7aelMFiTej5mPtpYVm0l+ss/D/ORIFSk3mwW16IiFMwGuEv69IAPA
         uSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dV+hpYbGfRGXFvtF+Lfe9yalvB//tMvrxl/pRmYwcng=;
        b=XOXarF4CFKaJI5vVNDbKCuMvdV+Y03h8+8sWu7mwn9B/yIsQQxEnSlQWM2q3U1VtND
         aL6wR+QjG+Va3zGiGkneO2g8exbKxoA43l+pdk+6l4aw+Q8YVmYssnrE0nhWI22PbtFs
         0bYpM7I8pBQVxAfFbltMV9TRuZ+FUcbgmx4Uagk+GvAoTon1FP2ncfLbYfAdKm5m090i
         NdxeH4Uw2roCtdAZViADq1VJTPb2IQHuDQhDTr/lEMwQT/Zpp1M6xQyoqO/LYbHR2bMC
         fCXQGMsTOGxN+p+zn+1DM05/PsIGhhLzuaxe9WpkGdEY4iE3IR406KuFhmjXDLsi1rvh
         rAeQ==
X-Gm-Message-State: APjAAAW957P52gj06kCF0ATIzLXSnkJMQdLcvk2itDs8Xoqtuwrmk6Cn
        qULrQnnRKiou8e+zd+N6vppK0A==
X-Google-Smtp-Source: APXvYqz7ncTVXqaPWF0r1zHZNr+xEaLdLJzuLNFtO9pSi9dtOl/Fd7SnoidmNIDaiGT5xtHnyGkt5w==
X-Received: by 2002:a17:90a:fa07:: with SMTP id cm7mr23936237pjb.115.1561369431698;
        Mon, 24 Jun 2019 02:43:51 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id x8sm10417055pfa.46.2019.06.24.02.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 02:43:51 -0700 (PDT)
Date:   Mon, 24 Jun 2019 15:13:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Add required-opps support to devfreq passive gov
Message-ID: <20190624094349.rtjb7nuv6g7zmsf2@vireshk-i7>
References: <20190622003449.33707-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622003449.33707-1-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-19, 17:34, Saravana Kannan wrote:
> The devfreq passive governor scales the frequency of a "child" device
> based on the current frequency of a "parent" device (not parent/child in
> the sense of device hierarchy). As of today, the passive governor
> requires one of the following to work correctly:
> 1. The parent and child device have the same number of frequencies
> 2. The child device driver passes a mapping function to translate from
>    parent frequency to child frequency.
> 
> When (1) is not true, (2) is the only option right now. But often times,
> all that is required is a simple mapping from parent's frequency to
> child's frequency.
> 
> Since OPPs already support pointing to other "required-opps", add
> support for using that to map from parent device frequency to child
> device frequency. That way, every child device driver doesn't have to
> implement a separate mapping function anytime (1) isn't true.

Can you please provide a real world example with DT code here so I
can understand it better ?

-- 
viresh
