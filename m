Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7DA3D6E92
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 07:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfJOF0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 01:26:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39308 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbfJOF0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:26:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so18748005wml.4;
        Mon, 14 Oct 2019 22:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=upB1pMilrXLtVJrTlKsRAM5YECttv86H2oZ0snhaLTk=;
        b=fwqO68ynU6ApjNSZ+W2u5R+TKd5CAmmbA7iIrYn+R+xTVps9tpm3a1aOGNoGNSNGdL
         rijXfnuv4v27Uv/uPLH8QSvpkvqM29BMOWxOXFeAem03btOsYwxKqAbEJpjyoJHZQA70
         a0YVxTgpkvk+utnX9r/c0viwxMlbWunTo/9EFlgpj0TOiP8jfVO/X+iC/g/u5t/YTHw5
         9JJBWAKcsJ+RduPjptrMzRH1FngWwdT7cY/K5H7pg1A1pt8+kvGK60x+YdERz+TN7r5a
         wIi67hbpwaUInTI5xMoWapho5hHpZ4qE9AezgWhZj3dQ80iUTfm8miOpG8dYJB7DPrSi
         1bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=upB1pMilrXLtVJrTlKsRAM5YECttv86H2oZ0snhaLTk=;
        b=LMfk0VFCly09jlt7CmTrXkR+13ubs1MPYBT4EgaV0g3uVfowsMbjeaKKrUObcfmPeL
         tF8YYCui0tTj0tLTOX4AxR7uV7XwWRdZMYtvKmNUnH+K84JJkKCEQKOk04cPxTOB7xFm
         xjZwKoZhqDtrHiMLHOunNh9/NuYPT1aWlDzyoinSIT8jpuQoU6NYT+xmOjjaobyQ9dte
         En2M9KqCgMUUiBA9JIl857wyCSc/D7AkTdckIF+O8nSEo4qG5IC092XF2vqImV/qIxFm
         /8bXW86nxiSR/DX04iDIQlElsNTV+ud3s+HKPMa0bf+YUK936cyo9P5Km03svmLQD/OP
         AqXQ==
X-Gm-Message-State: APjAAAUf2IVJ3N05aL7rvM3bZ6insSIIMKKCVapokdPQgph8i3fePH2R
        3KxO2BTgnK9wbrI0eN44ZV0=
X-Google-Smtp-Source: APXvYqxck+/s8y8WhFZZwv7kMnmkisGRKyju6PLV5WeOsMzJI4BdMRTEY6pqiCUiPTSYjgLgK2HQXA==
X-Received: by 2002:a1c:9dcf:: with SMTP id g198mr18326306wme.101.1571117159073;
        Mon, 14 Oct 2019 22:25:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q124sm40974869wma.5.2019.10.14.22.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 22:25:58 -0700 (PDT)
Date:   Tue, 15 Oct 2019 07:25:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        KP Singh <kpsingh@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20191015052556.GA70364@gmail.com>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit f733c6b508bcaa3441ba1eacf16efb9abd47489f:
> 
>   perf/core: Fix inheritance of aux_output groups (2019-10-07 16:50:42 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191011
> 
> for you to fetch changes up to cebf7d51a6c3babc4d0589da7aec0de1af0a5691:
> 
>   perf diff: Report noisy for cycles diff (2019-10-11 10:57:00 -0300)

Pulled, thanks a lot Arnaldo!

	Ingo
