Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E28313E0D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 17:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgAPQpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 11:45:53 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45668 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbgAPQps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:45:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so19670047qkl.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wvt8smsg1HL/HROaSH1vcUPejygGWroBMJD9sx4u7EQ=;
        b=gx0Q5k/vJ3zGnE2w0yfnD8HiYO/z+498mW+4yPeOc0Yx9qHVU3cchwAzkAhZWAZtQ2
         DKvZby1uWKPceCAPp9gIUK95GtVIGDBi314APQmyR/w1SsXmzeVpor7loLQ8oP29VxGA
         xuBQwbfPSZutI7MJpYp6sW0mvqoNQOzhWLOzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wvt8smsg1HL/HROaSH1vcUPejygGWroBMJD9sx4u7EQ=;
        b=V7DOs1WdmviCMYRCGXPSd18ruh1MLbRYUFnMQwodpUHoNrVozGs1hDzMW+6u7FXIZi
         Zam1CmC97zbF9FVi0Fzi++xm1y5LvxvmLJpgZu52SfvRK19z0Y4e9DgUKPo0Li/sgytq
         PG66sdq4fn3OfuHRVs5Y/3DqtgveZasMh2xd7K/Wb9a2iTla0FkpWDfmCVt2XHhu7+iy
         dZ8BTCNeUinf5KxnCTQ7xcBzSlC+7GxpT75D9pwNE59RwhCx1Q4Eu9sdu5BZCY9QsLkN
         zoMRiH/HSPA8lcKGekJT8Gpmx0DSdQ/3WoXmbfuL/BEBh+kuC3vieWm0mYGoCiziCGoL
         uMXw==
X-Gm-Message-State: APjAAAUJbTDdlJJHt4F75LnNMpqj9Qigl1uuvRmlBna9nSx6NcWiW7bR
        cDXr1BfkBRs5TTY4kU7g77py6A==
X-Google-Smtp-Source: APXvYqxNm5u/3SanIpSyF46ty0cpiVkf7U7YOWJtvaCzMM84yx+2kbF6335YW3J2CNQkQ2x2hO3EqA==
X-Received: by 2002:a37:7d01:: with SMTP id y1mr8317444qkc.452.1579193147715;
        Thu, 16 Jan 2020 08:45:47 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id n4sm11195152qti.55.2020.01.16.08.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:45:46 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 16 Jan 2020 11:45:45 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Vince Weaver <vincent.weaver@maine.edu>
cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf: correctly handle failed perf_get_aux_event() (was:
 Re: [perf] perf_event_open() sometimes returning 0)
In-Reply-To: <alpine.DEB.2.21.2001061307460.24675@macbook-air>
Message-ID: <alpine.DEB.2.21.2001161144590.29041@macbook-air>
References: <alpine.DEB.2.21.2001021349390.11372@macbook-air> <alpine.DEB.2.21.2001021418590.11372@macbook-air> <20200106120338.GC9630@lakrids.cambridge.arm.com> <alpine.DEB.2.21.2001061307460.24675@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2020, Vince Weaver wrote:

> On Mon, 6 Jan 2020, Mark Rutland wrote:
> 
> > On Thu, Jan 02, 2020 at 02:22:47PM -0500, Vince Weaver wrote:
> > > On Thu, 2 Jan 2020, Vince Weaver wrote:
> > > 
> > Vince, does the below (untested) patch work for you?
> 
> 
> yes, this patch fixes things for me.
> 
> Tested-by: Vince Weaver <vincent.weaver@maine.edu>
> 

is this patch going to make it upstream?  It's a fairly major correctness 
bug with perf_event_open().

Vince
