Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE151743FA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 01:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgB2Avi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 19:51:38 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37203 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgB2Avi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 19:51:38 -0500
Received: by mail-pj1-f66.google.com with SMTP id o2so41026pjp.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 16:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M4tgEyFArklK0C2NkHJ4Ev1DbekboBTuLVXflJ8Bdmg=;
        b=YEZrilU5Emz9Z8Ec+wHK4LiI7fQQzdfCcue2M/IsGBDlntu9mx1MWRLDNRF2DkbyzK
         R2lwOWZhgB6mzNpT1Pu/aYGOixkKd67bWXduwxC7akBPX2iYuMwBeOQ5JBnJ3PoP/sm+
         fwHlgE5NWc/QcaNpgQ1v36FCjFUNaQ0QzZjXLhJBB7HSyakmk/gogoPqwcbqcHALKGWF
         LEwHUDu3Vt5k84kgM8atzhoarq3m2Hp+ubtvEsIOjJSEjTqa8HV47MN06DuHfs+WThz5
         AS+PNvVOGiAiXvalk95ELB6qY6CzHUNlqNZ8cCZ8Kyzz7tO0GspqtRYJOBiBc4omlRU0
         Jamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M4tgEyFArklK0C2NkHJ4Ev1DbekboBTuLVXflJ8Bdmg=;
        b=mMikz26WX439UJOxL8GlZZKaybee1Mf2FwjNpDfEiDy2/2lqMF6Di9Fg4rj2OYqPCG
         kAX5g4vugA1A3wZ6N2ti5qN0xGC0Z3gFLnIvY+341Z1qQz1U+2vSY/9ly33QFDbHriUY
         PZ5uVC7M1+3wRT0idIohh8Hur0sPy6kZYnAkOotYB7OLowy79Ha3iftL0mChAkZmguz4
         0GXEgYMN1LF08V6yEfE6FXVNpVsVGR3UTSwdD8Su8l4rvgYhdqaxOD0ZrxV1WGCvdclE
         DL8TDMy9qF953ESiP+TxfaNx4xUuUnrow54kbc+ubfpKbiPsCu2nh7gYqYy42IsP4JQQ
         AdBQ==
X-Gm-Message-State: APjAAAU7Uihf2Ft62YG09NyvAi/mqshfgwhDHbTwY0RjyIENq6nw5d4R
        3RdohODdUi5aG9qDbcoCA4USiQ==
X-Google-Smtp-Source: APXvYqy82naI/lVAZlOJvZdl3C/jjyr3KkWwvalv9/HybDbYSHFf9yfSUJEYY3U/VEuNZhjYcVENGg==
X-Received: by 2002:a17:90a:8a8d:: with SMTP id x13mr7344279pjn.97.1582937496771;
        Fri, 28 Feb 2020 16:51:36 -0800 (PST)
Received: from google.com ([2620:15c:211:202:ae26:61fb:e2f3:92e7])
        by smtp.gmail.com with ESMTPSA id y16sm12339385pfn.177.2020.02.28.16.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 16:51:36 -0800 (PST)
Date:   Fri, 28 Feb 2020 16:51:31 -0800
From:   Marco Ballesio <balejs@google.com>
To:     tj@kernel.org, guro@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, corbet@lwn.net, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, minchan@google.com, surenb@google.com,
        dancol@google.com
Subject: Re: [PATCH] cgroup-v1: freezer: optionally killable freezer
Message-ID: <20200229005131.GB9813@google.com>
References: <20200219183231.50985-1-balejs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219183231.50985-1-balejs@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

did anyone have time to look into my proposal and, in case, are there
any suggestions, ideas or comments about it?

Marco
