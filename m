Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F46514921
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 13:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfEFLsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 07:48:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50358 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEFLsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 07:48:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id p21so15346895wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mAbU8LSqh6zDbO18wbVoxIfvmSATOQLHMqf1N6PtQVg=;
        b=anNeeC7xzdIHcLWm+FwD4psWMlVdLxLRqYk5qXCvbvy3sNoyHWzQEZm0gsecXWVXQ1
         iM2qWfn+oLpRReGynxhb91lPal7BZRqVhKvs8tga4ojeQuQfDFG1Xs7iFX8Jlg/H6A9k
         Pulaw9iJ2p9zIRv8mJTAVoKUyjvZMBTnoASUI2ZjwG1WkzP6H5f+O676W3/nROXLidKH
         TgCCzNC2YFNLWBexHHEvj2vRrl5wIRdY6tXTbVD7Zk1UBlcxEnZdqsrDOQOJQ5PiCnFT
         YMvW4+Yv8tvKNTKaCajBUf4vTc0KI6/BxHUi8i6T1yvCfmw9Cdds4jOBHjhz6i6DhYWV
         BIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mAbU8LSqh6zDbO18wbVoxIfvmSATOQLHMqf1N6PtQVg=;
        b=E7d9VuHarVgunavCT/h+7f5/JySn9nq6UHfJXjfL2SxrufFBYWhiXqxsM7h9a7vE1s
         mi0EjNU4IsE63pdjLrQy9XNOrPPKpkoDFZ+o9mZHWcXK4VX5iO8MwKtzojVvuImAtjnL
         6mVFXLsn6WS4I/VDoJz5svIbplf4UnMk9j0CCyHWC+H2a1sIL2wF6OBtzRWIDsZkKO1g
         OkRKI7ZXrZl6yhMZDI9peb8sBSkvcj151mIdXnxNsAXU6L+O7NOMK2OullMdSZG4O5qh
         XmkxFQRXAjb9gmrSwtrQ041Sbo5KO5WrwsR6yfwx4C/ZLFW/LyXOuJ+oW+mje+812Ddd
         8Qzg==
X-Gm-Message-State: APjAAAXRSUmXpaekFu/mWdyDDA3sqUQjIjqCBH6t9zqiRYkOxYjVosQ2
        TQ/paxX+tSsusY4Lmgcw8qw=
X-Google-Smtp-Source: APXvYqy78FwQ0IyHLVf1KkNtwI6gTwSnlnSD6/3cqf+lIyvR4EPXl5KE9PBVnMkDXqOcsX0MeDz+Ew==
X-Received: by 2002:a1c:304:: with SMTP id 4mr13947202wmd.39.1557143302586;
        Mon, 06 May 2019 04:48:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y4sm8053826wmj.20.2019.05.06.04.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 04:48:21 -0700 (PDT)
Date:   Mon, 6 May 2019 13:48:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Len Brown <lenb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 17/18] perf/x86/intel/rapl: Support multi-die/package
Message-ID: <20190506114819.GA24079@gmail.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
 <da7518106ce152367457c014bc91281925ee9576.1556657368.git.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da7518106ce152367457c014bc91281925ee9576.1556657368.git.len.brown@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Len Brown <lenb@kernel.org> wrote:

>  
>  static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
>  {
> -	unsigned int pkgid = topology_logical_package_id(cpu);
> +	unsigned int pkgid = topology_logical_die_id(cpu);

Yeah, I think Peter pointed this out before: why is the local variable 
still named 'pkg' when we now have a die ID?

The other patches have such problems too: when new facilities are 
introduced and used then function names and variable names need to be 
harmonized. Makes for rather confusing code otherwise, which invites bugs 
down the road.

There's many such instances left in this series, please review the whole 
patchset for such problems.

Thanks,

	Ingo
