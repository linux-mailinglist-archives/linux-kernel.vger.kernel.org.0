Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 019C8110165
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 16:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLCPlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 10:41:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50118 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfLCPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:41:18 -0500
Received: from [81.92.17.147] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1icAIW-0004j9-RQ; Tue, 03 Dec 2019 15:41:09 +0000
Date:   Tue, 3 Dec 2019 16:41:07 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Adrian Reber <areber@redhat.com>
Subject: Re: [PATCH 19/23] perf beauty: Add CLEAR_SIGHAND support for clone's
 flags arg
Message-ID: <20191203154106.7kio25pcank6p2a3@wittgenstein>
References: <20191203135606.24902-1-acme@kernel.org>
 <20191203135606.24902-20-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191203135606.24902-20-acme@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 10:56:02AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Add support for the recently added CLONE_CLEAR_SIGHAND flag.
> 
> This takes advantage of the copy of the uapi/linux/sched.h we have in
> tools/include, which allows us to build tools/perf in older systems and
> have the binary support printing that flag whenever that system gets its
> kernel updated to one where this feature is present.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Adrian Reber <areber@redhat.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org
> Link: https://lkml.kernel.org/n/tip-1vnz497ubtu5oz16ygdcul0e@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
