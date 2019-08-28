Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBF8A054B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 16:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfH1Osi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 10:48:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39300 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1Osi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:48:38 -0400
Received: by mail-qk1-f196.google.com with SMTP id 4so2611675qki.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p11EOwu/uVWWwafbZoZanI/o5iGdReqlGXH8aeEIwZs=;
        b=qRCmLgBMPolI5D1ew8nG90rOtC7mFtSfXX2Jrds5xSvZmTrMg/CHVyjmHKQwjOQ1Yl
         IFz51blzXZUBrSOQX5/zWXzKDY4iihZvRE0aVY71k8y66pk3jz9EHnjaHjF2DOUAE2b/
         m1tXhsQbenmBNS4WG/OtjRkbC15NJF/rPh5TC4Dgm+7ghafp+i8NJVZ/MtSQk7RHptg3
         u/uNWe2nSOVte8P2CiC8je410mnaUQzTd3mlgGES1SdkfRO+g5QLpqGXeTcD/kv02glK
         uhMzGCpNDwIS07fcqh79UmUAjOdk9RosI22JvLaCt6VZsiXr1boDM2s3R2qnbYE1PXYa
         Ra3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=p11EOwu/uVWWwafbZoZanI/o5iGdReqlGXH8aeEIwZs=;
        b=CH801lXULXnoR5PzdLay4B8Gdc8cvJV/0m1YIjSlRh+RetWObpPIBjh4yMwCRTj02d
         Z3AcuD3QV2kJE/H9gbY/N/9HLWOM9vQaD0GY1o3UGkTvHIOYzJPkFjMwE8EMJqA9myrn
         ZC1ILdkyYtppbP39sRSiIZh0EsAEpfXg7m8+JpzSlCRmZ2dY88EYfKcsjjLpWIeH+HX2
         SMderAu0ydErXMducjodNcDCWVS8Ya9ZcWv8SzH5pjCCeByNmVP7i1aWgNHkA162sT1N
         SA8g+Jo8ulsexw5VqLevm59bgi+jqQ2OySZ5+vstTh7xbIGLvSaMqo0oCR2x05ARwQ7m
         W9eQ==
X-Gm-Message-State: APjAAAW6zztZXGJbEgczgRrmK+fdSmiVEl5ANJdV/8zOito1sTgYJGXX
        9GImKUM59080p/h9Rfi91T8=
X-Google-Smtp-Source: APXvYqyI/lM8w93rKPohI6SnUh1EbEp6HqeyFc9b6D2tyMIFivGgf81C5M52iseVgilUGgu7Q6ZOuQ==
X-Received: by 2002:a37:813:: with SMTP id 19mr3865720qki.427.1567003713733;
        Wed, 28 Aug 2019 07:48:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c231])
        by smtp.gmail.com with ESMTPSA id h1sm1588941qtc.92.2019.08.28.07.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 07:48:33 -0700 (PDT)
Date:   Wed, 28 Aug 2019 07:48:30 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
Message-ID: <20190828144830.GQ2263813@devbig004.ftw2.facebook.com>
References: <20190828073130.83800-1-namhyung@kernel.org>
 <20190828073130.83800-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828073130.83800-2-namhyung@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Namhyung.

On Wed, Aug 28, 2019 at 04:31:22PM +0900, Namhyung Kim wrote:
> +	 * struct {
> +	 *	struct perf_event_header	header;
> +	 *	u64				ino;
> +	 *	u64				path_len;
> +	 *	char				path[];

ino and path aren't great identifers for cgroups because both can get
recycled pretty quickly.  Can you please take a look at
KERNFS_ROOT_SUPPORT_EXPORTOP?  That's the fhandle that cgroup uses,
currently the standard ino+gen which isn't ideal but good enough.
Another benefit is that the path can also be resolved efficiently from
userspace given the handle.

Thanks.

-- 
tejun
