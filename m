Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A955E157466
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 13:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgBJMSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 07:18:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46974 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727481AbgBJMSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581337122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eqPIoVcEMGbnA2FeJ8SA7ZoTHkVUXEq8MW9ue55rthI=;
        b=H/yNjdCgFgqnVCM+6vTBdKh+sYWIWL8cmoH4vA1etYOBTsyFbNM48T8e97EJF3MTdTU1dE
        GmNdB6SX4xAbcY3/ed+ZQDGt92hjjwLeCQSBaP45oeKnszVv/qIsEUWVNKHFKycX4k4sAA
        uJiUrq5wn3d9z+2RfKoLu1z3LqV8Yac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-VBSmjAz3MwmX04KcWUwYmw-1; Mon, 10 Feb 2020 07:18:37 -0500
X-MC-Unique: VBSmjAz3MwmX04KcWUwYmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 503AC800D41;
        Mon, 10 Feb 2020 12:18:36 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8B4138B;
        Mon, 10 Feb 2020 12:18:34 +0000 (UTC)
Date:   Mon, 10 Feb 2020 13:18:32 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] perf annotate: Misc fixes / improvements
Message-ID: <20200210121832.GA2004503@krava>
References: <20200204045233.474937-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204045233.474937-1-ravi.bangoria@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 10:22:27AM +0530, Ravi Bangoria wrote:
> Few fixes / improvements related to perf annotate.
> 
> v2: https://lore.kernel.org/r/20200124080432.8065-1-ravi.bangoria@linux.ibm.com
> 
> v2->v3:
>  - [PATCH v3 2/6] New function annotation_line__exit() to clear
>    annotation_line objects.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> v1: http://lore.kernel.org/r/20200117092612.30874-1-ravi.bangoria@linux.ibm.com
> 
> v1->v2:
>  - Split [PATCH v1 1/3] into two patches.
>  - Patch 5 and patch 6 are new.
> 
> Ravi Bangoria (6):
>   perf annotate: Remove privsize from symbol__annotate() args
>   perf annotate: Simplify disasm_line allocation and freeing code
>   perf annotate: Align struct annotate_args
>   perf annotate: Fix segfault with source toggle
>   perf annotate: Make few functions static
>   perf annotate: Get rid of annotation->nr_jumps
> 
>  tools/perf/builtin-top.c     |   2 +-
>  tools/perf/ui/gtk/annotate.c |   2 +-
>  tools/perf/util/annotate.c   | 115 ++++++++++++++---------------------
>  tools/perf/util/annotate.h   |   8 +--
>  4 files changed, 49 insertions(+), 78 deletions(-)
> 
> -- 
> 2.24.1
> 

