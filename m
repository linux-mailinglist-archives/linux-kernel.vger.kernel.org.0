Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70744A89BD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbfIDPx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 11:53:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbfIDPx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:53:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 176293084246;
        Wed,  4 Sep 2019 15:53:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.103])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7D924194BB;
        Wed,  4 Sep 2019 15:53:55 +0000 (UTC)
Date:   Wed, 4 Sep 2019 17:53:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Naveen N Rao <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] Perf/stat: Solve problems with repeat and interval
Message-ID: <20190904155354.GC10468@krava>
References: <20190904094738.9558-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904094738.9558-1-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 04 Sep 2019 15:53:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 03:17:36PM +0530, Srikar Dronamraju wrote:
> There are some problems in perf stat when using a combination of repeat and
> interval options. This series tries to fix them.
> 
> Srikar Dronamraju (2):
>   perf/stat: Reset previous counts on repeat with interval
>   perf/stat: Fix a segmentation fault when using repeat forever
> 
>  tools/perf/builtin-stat.c |  5 ++++-
>  tools/perf/util/stat.c    | 17 +++++++++++++++++
>  tools/perf/util/stat.h    |  1 +
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> -- 
> 2.18.1
> 

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
