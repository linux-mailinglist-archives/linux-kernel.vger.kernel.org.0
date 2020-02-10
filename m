Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352FF1573FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 13:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBJMHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 07:07:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57547 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727818AbgBJMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581336471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jONdue0ovlDdMXefHuursR0LxtLZt0LrzIOWpvfMZzk=;
        b=dZCmecK8EVRIkBz5/RxXkiaJUeD+wxOHsPIo6PsTCgtqm4pFQHBdGco9hQDRklN8YkrBaE
        Uv1xowyw/bBTYO2X+dP9mj/cJl5lunOg7mLbKHU4JaABn2RxNQPi7F9EQPrUauLekvzOyl
        1AuB3bqI1ksRfWQYPn+5g3dIkFu3Ftg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-Q1NGfm_wOESApJ57bhvzhQ-1; Mon, 10 Feb 2020 07:07:47 -0500
X-MC-Unique: Q1NGfm_wOESApJ57bhvzhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 251201005510;
        Mon, 10 Feb 2020 12:07:45 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A1A389F30;
        Mon, 10 Feb 2020 12:07:42 +0000 (UTC)
Date:   Mon, 10 Feb 2020 13:07:39 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        james.clark@arm.com, zhangshaokun@hisilicon.com,
        robin.murphy@arm.com
Subject: Re: [PATCH RFC 3/7] perf jevents: Add support for a system events PMU
Message-ID: <20200210120739.GE1907700@krava>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-4-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579876505-113251-4-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:35:01PM +0800, John Garry wrote:

SNIP

> +	return ret;
> +}
> +
>  /*
>   * If we fail to locate/process JSON and map files, create a NULL mapping
>   * table. This would at least allow perf to build even if we can't find/use
> @@ -887,6 +917,7 @@ static int get_maxfds(void)
>   */
>  static FILE *eventsfp;
>  static char *mapfile;
> +static char *mapfile_sys;
>  
>  static int is_leaf_dir(const char *fpath)
>  {
> @@ -1024,6 +1055,11 @@ static int process_one_file(const char *fpath, const struct stat *sb,
>  			return 0;
>  		}
>  
> +		if (!strcmp(bname, "mapfile_sys.csv")) {
> +			mapfile_sys = strdup(fpath);


we could release that in the cleanup code at the end of main
together with 'mapfile', which is also missing

jirka

