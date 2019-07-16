Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0078E6A42A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 10:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbfGPIrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 04:47:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10765 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfGPIrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:47:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E406413A41;
        Tue, 16 Jul 2019 08:47:47 +0000 (UTC)
Received: from krava (unknown [10.43.17.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id 409FD5B684;
        Tue, 16 Jul 2019 08:47:45 +0000 (UTC)
Date:   Tue, 16 Jul 2019 10:47:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH 2/3] perf: Use CAP_SYS_ADMIN with perf_event_paranoid
 checks
Message-ID: <20190716084744.GB22317@krava>
References: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
 <1562112605-6235-3-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562112605-6235-3-git-send-email-ilubashe@akamai.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 16 Jul 2019 08:47:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 08:10:04PM -0400, Igor Lubashev wrote:
> The kernel is using CAP_SYS_ADMIN instead of euid==0 to override
> perf_event_paranoid check. Make perf do the same.

I see another geteuid check in __cmd_ftrace,
perhaps we should cover this one as well

jirka
