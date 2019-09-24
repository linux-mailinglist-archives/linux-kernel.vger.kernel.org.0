Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAAEFBCA41
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 16:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632783AbfIXOa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 10:30:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59026 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393649AbfIXOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:30:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B300D6119F; Tue, 24 Sep 2019 14:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569335456;
        bh=jWArOvsz6NRdh9PJYtvmiNuvWkTRH8UprwwY0Orf34w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xk1fuuc1NLrLO2BEidkQngIYmiTHehT184sWRBliCCcZt/VF7KQHj3m8hiFZfWq+O
         pcrhtq5TnS0fFLHTuxTA7JzgTw48wUfj+RWfrUubwXcM06UrRd5KjahoSfB6hBFks1
         gPh3NpMblhw7jzQQjcksGupWZzXJjnfkICvcN20M=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 317BA60A05;
        Tue, 24 Sep 2019 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569335455;
        bh=jWArOvsz6NRdh9PJYtvmiNuvWkTRH8UprwwY0Orf34w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Yf+bg+kLliiHIHbvl3+cyyM5Mg04xx1RAo5uMnd9VnlPGSML564/t2TUfIVvvqXSt
         SDVJYPaMbkmlBfua2AS244fB9areJ1kBTlcsLdYNloBfS4O8YPuZ8TEnxsDs6/yOmL
         7vcsLhPRSLPqFCdc65tZqij+gs4Y2cNTYTltWHiM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 317BA60A05
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH V5 1/1] perf: event preserve and create across cpu hotplug
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Raghavendra Rao Ananta <rananta@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <1564685213-8180-1-git-send-email-mojha@codeaurora.org>
 <1564685213-8180-2-git-send-email-mojha@codeaurora.org>
 <20190812104232.GA17441@krava>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <1ad8874b-e6fc-9cb2-8dbb-7de6139e6c4a@codeaurora.org>
Date:   Tue, 24 Sep 2019 20:00:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190812104232.GA17441@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/12/2019 4:12 PM, Jiri Olsa wrote:
> On Fri, Aug 02, 2019 at 12:16:53AM +0530, Mukesh Ojha wrote:
>> Perf framework doesn't allow preserving CPU events across
>> CPU hotplugs. The events are scheduled out as and when the
>> CPU walks offline. Moreover, the framework also doesn't
>> allow the clients to create events on an offline CPU. As
>> a result, the clients have to keep on monitoring the CPU
>> state until it comes back online.
>>
>> Therefore, introducing the perf framework to support creation
>> and preserving of (CPU) events for offline CPUs. Through
>> this, the CPU's online state would be transparent to the
>> client and it not have to worry about monitoring the CPU's
>> state. Success would be returned to the client even while
>> creating the event on an offline CPU. If during the lifetime
>> of the event the CPU walks offline, the event would be
>> preserved and would continue to count as soon as (and if) the
>> CPU comes back online.
>>
>> Co-authored-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> ---
>> Change in V5:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> - Rebased it.
> note that we might need to change how we store cpu topology,
> now that it can change during the sampling.. like below it's
> the comparison of header data with and without cpu 1
>
> I think some of the report code checks on topology or caches
> and it might get confused
>
> perhaps we could watch cpu topology in record and update the
> data as we see it changing.. future TODO list ;-)

Hi Jiri,

Can we do something like below=C2=A0 to address issue=C2=A0 related to he=
ader=20
update while perf record with offline cpus.

--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1432,7 +1432,7 @@ static int __cmd_record(struct record *rec, int=20
argc, const char **argv)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 opts->no_bpf_event =3D true;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D record__synthesize(rec, fal=
se);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D record__synthesize(rec, tru=
e);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err < 0)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto out_child;

@@ -1652,7 +1652,7 @@ static int __cmd_record(struct record *rec, int=20
argc, const char **argv)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 status =3D err;

-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 record__synthesize(rec, true);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 record__synthesize(rec, false);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* this will be recalculated =
during process_buildids() */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rec->samples =3D 0;

Thanks.
Mukesh


>
> perf stat is probably fine
>
> jirka
>
>
> ---
> -# nrcpus online : 39
> +# nrcpus online : 40
>   # nrcpus avail : 40
>   # cpudesc : Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz
>   # cpuid : GenuineIntel,6,85,4
> ...
>   # sibling sockets : 0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,=
36,38
> -# sibling sockets : 3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,=
39
> +# sibling sockets : 1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,3=
7,39
>   # sibling dies    : 0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,=
36,38
> -# sibling dies    : 3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,=
39
> +# sibling dies    : 1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,3=
7,39
>   # sibling threads : 0,20
> +# sibling threads : 1,21
>   # sibling threads : 2,22
>   # sibling threads : 3,23
>   # sibling threads : 4,24
> @@ -38,9 +39,8 @@
>   # sibling threads : 17,37
>   # sibling threads : 18,38
>   # sibling threads : 19,39
> -# sibling threads : 21
>   # CPU 0: Core ID 0, Die ID 0, Socket ID 0
> -# CPU 1: Core ID -1, Die ID -1, Socket ID -1
> +# CPU 1: Core ID 0, Die ID 0, Socket ID 1
>   # CPU 2: Core ID 4, Die ID 0, Socket ID 0
>   # CPU 3: Core ID 4, Die ID 0, Socket ID 1
>   # CPU 4: Core ID 1, Die ID 0, Socket ID 0
> @@ -79,14 +79,16 @@
>   # CPU 37: Core ID 9, Die ID 0, Socket ID 1
>   # CPU 38: Core ID 10, Die ID 0, Socket ID 0
>   # CPU 39: Core ID 10, Die ID 0, Socket ID 1
> -# node0 meminfo  : total =3D 47391616 kB, free =3D 46536844 kB
> +# node0 meminfo  : total =3D 47391616 kB, free =3D 46548348 kB
>   # node0 cpu list : 0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,3=
6,38
> -# node1 meminfo  : total =3D 49539612 kB, free =3D 48908820 kB
> -# node1 cpu list : 3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,3=
9
> +# node1 meminfo  : total =3D 49539612 kB, free =3D 48897176 kB
> +# node1 cpu list : 1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37=
,39
>   # pmu mappings: intel_pt =3D 8, uncore_cha_1 =3D 25, uncore_irp_3 =3D=
 49, software =3D 1, uncore_imc_5 =3D 18, uncore_m3upi_0 =3D 21, uncore_i=
io_free_running_5 =3D 45, uncore_irp_1 =3D 47, uncore_m2m_1 =3D 12, uncor=
e_imc_3 =3D 16, uncore_cha_8 =3D 32, uncore_iio_free_running_3 =3D 43, un=
core_imc_1 =3D 14, uncore_upi_1 =3D 20, power =3D 10, uncore_cha_6 =3D 30=
, uncore_iio_free_running_1 =3D 41, uncore_iio_4 =3D 38, uprobe =3D 7, cp=
u =3D 4, uncore_cha_4 =3D 28, uncore_iio_2 =3D 36, cstate_core =3D 53, br=
eakpoint =3D 5, uncore_cha_2 =3D 26, uncore_irp_4 =3D 50, uncore_m3upi_1 =
=3D 22, uncore_iio_0 =3D 34, tracepoint =3D 2, uncore_cha_0 =3D 24, uncor=
e_irp_2 =3D 48, cstate_pkg =3D 54, uncore_imc_4 =3D 17, uncore_cha_9 =3D =
33, uncore_iio_free_running_4 =3D 44, uncore_ubox =3D 23, uncore_irp_0 =3D=
 46, uncore_m2m_0 =3D 11, uncore_imc_2 =3D 15, kprobe =3D 6, uncore_cha_7=
 =3D 31, uncore_iio_free_running_2 =3D 42, uncore_iio_5 =3D 39, uncore_im=
c_0 =3D 13, uncore_upi_0 =3D 19, uncore_cha_5 =3D 29, uncore_iio_free_run=
ning_0 =3D 40, uncore_pcu =3D 52, msr =3D 9, uncore_iio_3 =3D 37, uncore_=
cha_3 =3D 27, uncore_irp_5 =3D 51, uncore_iio_1 =3D 35
>   # CPU cache info:
>   #  L1 Data                 32K [0,20]
>   #  L1 Instruction          32K [0,20]
> +#  L1 Data                 32K [1,21]
> +#  L1 Instruction          32K [1,21]
>   #  L1 Data                 32K [2,22]
>   #  L1 Instruction          32K [2,22]
>   #  L1 Data                 32K [3,23]
> @@ -123,9 +125,8 @@
>   #  L1 Instruction          32K [18,38]
>   #  L1 Data                 32K [19,39]
>   #  L1 Instruction          32K [19,39]
> -#  L1 Data                 32K [21]
> -#  L1 Instruction          32K [21]
>   #  L2 Unified            1024K [0,20]
> +#  L2 Unified            1024K [1,21]
>   #  L2 Unified            1024K [2,22]
>   #  L2 Unified            1024K [3,23]
>   #  L2 Unified            1024K [4,24]
> @@ -144,12 +145,11 @@
>   #  L2 Unified            1024K [17,37]
>   #  L2 Unified            1024K [18,38]
>   #  L2 Unified            1024K [19,39]
> -#  L2 Unified            1024K [21]
>   #  L3 Unified           14080K [0,2,4,6,8,10,12,14,16,18,20,22,24,26,=
28,30,32,34,36,38]
> -#  L3 Unified           14080K [3,5,7,9,11,13,15,17,19,21,23,25,27,29,=
31,33,35,37,39]
> ...

