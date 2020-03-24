Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A79190E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 14:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCXNMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 09:12:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58385 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727448AbgCXNME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585055523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bAV0a5EbyjxKEoAhknEvXpmwJ3mEJrJzUIE/or3dQRE=;
        b=VqpLNIzWk6ZKcxWY3uQrizNVICSQD4lYB/JIxAGU73WKaCz3X5SOv8mfzvC6hLdlXKXTAb
        1kRcZtjOWtOMJnod9f+18VgXazDFgZWt8OaAEkUhRZvoilMR87LzHXJqhkkyU6z+tbRNM0
        2zusiNtKpMYANlQOyT705jTICoj/qsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-xLFoOtpINUi2luA0yLmjIw-1; Tue, 24 Mar 2020 09:11:59 -0400
X-MC-Unique: xLFoOtpINUi2luA0yLmjIw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D841C1926DA3;
        Tue, 24 Mar 2020 13:11:55 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A015760BE0;
        Tue, 24 Mar 2020 13:11:43 +0000 (UTC)
Date:   Tue, 24 Mar 2020 14:11:41 +0100
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
Subject: Re: [PATCH v6 09/11] perf/tools: Enhance JSON/metric infrastructure
 to handle "?"
Message-ID: <20200324131141.GV1534489@krava>
References: <20200320125406.30995-1-kjain@linux.ibm.com>
 <20200320125406.30995-10-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320125406.30995-10-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 06:24:04PM +0530, Kajol Jain wrote:
> Patch enhances current metric infrastructure to handle "?" in the metric
> expression. The "?" can be use for parameters whose value not known while
> creating metric events and which can be replace later at runtime to
> the proper value. It also add flexibility to create multiple events out
> of single metric event added in json file.
> 
> Patch adds function 'arch_get_runtimeparam' which is a arch specific
> function, returns the count of metric events need to be created.
> By default it return 1.
> 
> This infrastructure needed for hv_24x7 socket/chip level events.
> "hv_24x7" chip level events needs specific chip-id to which the
> data is requested. Function 'arch_get_runtimeparam' implemented
> in header.c which extract number of sockets from sysfs file
> "sockets" under "/sys/devices/hv_24x7/interface/".
> 
> 
> With this patch basically we are trying to create as many metric events
> as define by runtime_param.
> 
> For that one loop is added in function 'metricgroup__add_metric',
> which create multiple events at run time depend on return value of
> 'arch_get_runtimeparam' and merge that event in 'group_list'.
> 
> To achieve that we are actually passing this parameter value as part of
> `expr__find_other` function and changing "?" present in metric expression
> with this value.
> 
> As in our json file, there gonna be single metric event, and out of
> which we are creating multiple events, I am also merging this value
> to the original metric name to specify parameter value.
> 
> For example,
> command:# ./perf stat  -M PowerBUS_Frequency -C 0 -I 1000
> #           time             counts unit events
>      1.000101867          9,356,933      hv_24x7/pm_pb_cyc,chip=0/ #      2.3 GHz  PowerBUS_Frequency_0
>      1.000101867          9,366,134      hv_24x7/pm_pb_cyc,chip=1/ #      2.3 GHz  PowerBUS_Frequency_1
>      2.000314878          9,365,868      hv_24x7/pm_pb_cyc,chip=0/ #      2.3 GHz  PowerBUS_Frequency_0
>      2.000314878          9,366,092      hv_24x7/pm_pb_cyc,chip=1/ #      2.3 GHz  PowerBUS_Frequency_1
> 
> So, here _0 and _1 after PowerBUS_Frequency specify parameter value.
> 
> As after adding this to group_list, again we call expr__parse
> in 'generic_metric' function present in util/stat-display.c.
> By this time again we need to pass this parameter value. So, now to get this value
> actually I am trying to extract it from metric name itself. Because
> otherwise it gonna point to last updated value present in runtime_param.
> And gonna match for that value only.

so why can't we pass that param as integer value through the metric objects?

it get's created in metricgroup__add_metric_param:
  - as struct egroup *eg
  - we can add egroup::param and store the param value there

then in metricgroup__setup_events it moves to:
  - struct metric_expr *expr
  - we can add metric_expr::param to keep the param

then in perf_stat__print_shadow_stats there's:
  - struct metric_expr *mexp loop
  - calling generic_metric metric - we could call it with mexp::param
  - and pass the param to expr__parse

jirka

