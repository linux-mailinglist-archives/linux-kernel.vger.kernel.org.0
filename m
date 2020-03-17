Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8181888A1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 16:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgCQPJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 11:09:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33065 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726781AbgCQPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584457772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ta0KhgepEfUwCGXHHAmHDiK6AEcY63fhQKakFvy+9pQ=;
        b=VuWpoTNi9KHnSb+2MvzLw9Dd3fX20rxvRkKFwlizT//BCIytg7egBD494nS0PKxqPF2MVB
        HyBCKTr1pSNdhj3ftKmt0dKqhxsgb4RP67TT03NfYBAaXNcng8ml/0a14mF4Mp2Ta83VNV
        NhZBXye3k49TveaYI8bBQVkIpk+H4fk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-enRAUM7-PJ6go4nbvKaw4A-1; Tue, 17 Mar 2020 11:09:28 -0400
X-MC-Unique: enRAUM7-PJ6go4nbvKaw4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE536107B7F0;
        Tue, 17 Mar 2020 15:09:10 +0000 (UTC)
Received: from krava (unknown [10.40.195.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 437EE19756;
        Tue, 17 Mar 2020 15:09:04 +0000 (UTC)
Date:   Tue, 17 Mar 2020 16:07:03 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com,
        jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v5 09/11] perf/tools: Enhance JSON/metric infrastructure
 to handle "?"
Message-ID: <20200317150703.GB757893@krava>
References: <20200317062333.14555-1-kjain@linux.ibm.com>
 <20200317062333.14555-10-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317062333.14555-10-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 11:53:31AM +0530, Kajol Jain wrote:

SNIP

> diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
> index 3b4cdfc5efd6..dcc3c6ab2e67 100644
> --- a/tools/perf/arch/powerpc/util/header.c
> +++ b/tools/perf/arch/powerpc/util/header.c
> @@ -7,6 +7,8 @@
>  #include <string.h>
>  #include <linux/stringify.h>
>  #include "header.h"
> +#include "metricgroup.h"
> +#include <api/fs/fs.h>
>  
>  #define mfspr(rn)       ({unsigned long rval; \
>  			 asm volatile("mfspr %0," __stringify(rn) \
> @@ -16,6 +18,8 @@
>  #define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF) /* Version field */
>  #define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF) /* Revison field */
>  
> +#define SOCKETS_INFO_FILE_PATH "/devices/hv_24x7/interface/sockets"
> +
>  int
>  get_cpuid(char *buffer, size_t sz)
>  {
> @@ -44,3 +48,9 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
>  
>  	return bufp;
>  }
> +
> +int arch_get_runtimeparam(void)
> +{
> +	int count;
> +	return sysfs__read_int(SOCKETS_INFO_FILE_PATH, &count) < 0 ? 1 : count;

is that SOCKETS_INFO_FILE_PATH define used later? if not please
put the path directly as an argument to sysfs__read_int

jirka

