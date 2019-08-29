Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCD9A146E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 11:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfH2JLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 05:11:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17929 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfH2JLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:11:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2134D4E4E6;
        Thu, 29 Aug 2019 09:11:25 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5A965196B2;
        Thu, 29 Aug 2019 09:11:23 +0000 (UTC)
Date:   Thu, 29 Aug 2019 11:11:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kyle Meyer <meyerk@hpe.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Russ Anderson <russ.anderson@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: Re: [PATCH v4 1/7] perf: Refactor svg_build_topology_map
Message-ID: <20190829091122.GA10127@krava>
References: <20190827214352.94272-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
 <20190827214352.94272-2-meyerk@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827214352.94272-2-meyerk@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 29 Aug 2019 09:11:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 04:43:46PM -0500, Kyle Meyer wrote:
> Exchange the parameters of svg_build_topology_map with struct perf_env
> *env and adjust the function accordingly. This patch should not change any
> behavior, it is merely refactoring for the following patch.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: Russ Anderson <russ.anderson@hpe.com>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>

for the patchset:

Reviewed-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
