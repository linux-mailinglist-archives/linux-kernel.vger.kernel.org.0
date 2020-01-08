Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A19D0134F52
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 23:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgAHWSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 17:18:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47154 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726179AbgAHWSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578521921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4e6nR53z1prPkb37+MkpsiKLkGTsqnZqGNyyc/Ox5pI=;
        b=OxH8tz4poiR52K9blkKXNYvd+nngrEFKv8XcI+TfspNrP6DQAkEvvxApbNjldApC1k0f/G
        BJRJJ3kVQ5mj0weF2i+8pfbXk0v3ws404tZ7WuUIiQbIf9f/e0JlIAx6j0tv+3i9Bs7KNx
        jLjA358XPTBcUviN1wiuy908NmXKisQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-SjOFkSvzNJCyTT2_GQWFrw-1; Wed, 08 Jan 2020 17:18:40 -0500
X-MC-Unique: SjOFkSvzNJCyTT2_GQWFrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1EC7107ACC4;
        Wed,  8 Jan 2020 22:18:38 +0000 (UTC)
Received: from krava (ovpn-204-121.brq.redhat.com [10.40.204.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DF587C383;
        Wed,  8 Jan 2020 22:18:36 +0000 (UTC)
Date:   Wed, 8 Jan 2020 23:18:33 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 6/9] perf record: Support synthesizing cgroup events
Message-ID: <20200108221833.GD12995@krava>
References: <20200107133501.327117-1-namhyung@kernel.org>
 <20200107133501.327117-7-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107133501.327117-7-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:34:58PM +0900, Namhyung Kim wrote:

SNIP

> +	if (perf_tool__process_synth_event(tool, event, machine, process) < 0) {
> +		pr_debug("process synth event failed\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int perf_event__walk_cgroup_tree(struct perf_tool *tool,
> +					union perf_event *event,
> +					char *path, size_t mount_len,
> +					perf_event__handler_t process,
> +					struct machine *machine)
> +{
> +	size_t pos = strlen(path);
> +	DIR *d;
> +	struct dirent *dent;
> +	int ret = 0;
> +
> +	if (perf_event__synthesize_cgroup(tool, event, path, mount_len,
> +					  process, machine) < 0)
> +		return -1;
> +
> +	d = opendir(path);
> +	if (d == NULL) {
> +		pr_debug("failed to open directory: %s\n", path);
> +		return -1;
> +	}
> +
> +	while ((dent = readdir(d)) != NULL) {
> +		if (dent->d_type != DT_DIR)
> +			continue;
> +		if (!strcmp(dent->d_name, ".") ||
> +		    !strcmp(dent->d_name, ".."))
> +			continue;
> +
> +		if (path[pos - 1] != '/')
> +			strcat(path, "/");
> +		strcat(path, dent->d_name);

shouldn't you also check for the max size of path in here?

jirka

