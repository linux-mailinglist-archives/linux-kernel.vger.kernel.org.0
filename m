Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97A9315498
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 21:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEFTtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 15:49:41 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:45471 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfEFTtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 15:49:40 -0400
Received: by mail-wr1-f49.google.com with SMTP id s15so18816597wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 12:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=66mlbL0CrJ7/fuI7SCKRUurSoskawyn/TvebHqiOTt8=;
        b=FlXDTIis0m0j5kLiizL/QvH7mk4IWpAx57X9RljhmJQn1jHHcX2QlV1+UCcX/kOqXy
         4jsJbJQANImituAVQ+nE5tOHnBMqPG7ibCwL4IILpy4hTszYW3kr1X2AEBfhJluyssZL
         mNHUHFxT7GF8O++hCAdk2cYRiMKDPMlh+0Lh65cBhlSqO8y9Jv6gv1eeQYtwQenwSRcc
         zjzw6zjabhucP+ZT0ZrnbsbIRkAtL/HqH98Egt0TdItAWYknFxwiYBt8YQ15do5I+MKj
         Q8JRGsl4WNrhvwE/YVnQA75k8ZA9ltrM9IkssX5sbVf9Q6neS/Q2kUww1edOF4kt/eCn
         1yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=66mlbL0CrJ7/fuI7SCKRUurSoskawyn/TvebHqiOTt8=;
        b=BTWMpTI0zOzSOYQXUNSDhbUSYQuXBFIj2p/J08i7BGxJUqz6vcwZB7i5e+cEV7AQDC
         jmljIAIvPg8w9QmI18cBCWZGSBHkj+GCYCo3iC3npQmasfmgWul984RhuqR7SG+p8TcW
         DMNP1R3QRcsMd5eg01sEHpJmRMr7PZztHXLXr545DUblP56qtte5nL0hSLdghaQt0zxw
         H4F3tZ6FMdXNrYJqQTNbSEVjbBf0VOIJmMC2dop5hgljc9IUCzye6RKwn+/rhdJGo+3u
         ZHRQpVQ2IfDyqQpprzUqFb2E7inubSf8wKnxwpka/GowpVcTTDWhhDNxPnci0iTuivi3
         aouA==
X-Gm-Message-State: APjAAAUGBWSu8/yNQwWIzlWLCv2wsIxDjzYzsf0Z7rKZilDWQqVtR2oF
        xgcv2wxItHAp83zZBQKX0qpyvwZF
X-Google-Smtp-Source: APXvYqz01qngGuY0hCwslSWQ48ISnDoheCvFT6fhoee9EhzVYjJ1GRWVZHVliPnRFQd9b70DWVN9Vw==
X-Received: by 2002:adf:fe49:: with SMTP id m9mr1443607wrs.73.1557172179285;
        Mon, 06 May 2019 12:49:39 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a11sm8221615wmm.35.2019.05.06.12.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 12:49:38 -0700 (PDT)
Date:   Mon, 6 May 2019 21:49:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Len Brown <lenb@kernel.org>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 17/18] perf/x86/intel/rapl: Support multi-die/package
Message-ID: <20190506194936.GA23707@gmail.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
 <da7518106ce152367457c014bc91281925ee9576.1556657368.git.len.brown@intel.com>
 <20190506114819.GA24079@gmail.com>
 <CAJvTdKnZhyk_aWjQP_dtnNjvV75MvXBEmXUjH=K0hu2Kb77pYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJvTdKnZhyk_aWjQP_dtnNjvV75MvXBEmXUjH=K0hu2Kb77pYQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Len Brown <lenb@kernel.org> wrote:

> On Mon, May 6, 2019 at 7:48 AM Ingo Molnar <mingo@kernel.org> wrote:
> 
> > > -     unsigned int pkgid = topology_logical_package_id(cpu);
> > > +     unsigned int pkgid = topology_logical_die_id(cpu);
> 
> > There's many such instances left in this series, please review the whole
> > patchset for such problems.
> 
> I agree, the legacy names make the code read as if it were a bug, even
> when it is correct.
> I'll refresh the series with some re-names to make the end result ready clearly.

Thanks a lot!

	Ingo
