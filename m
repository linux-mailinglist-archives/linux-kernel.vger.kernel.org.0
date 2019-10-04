Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7DABCC17E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 19:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbfJDRS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 13:18:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387458AbfJDRS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:18:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0935910DCCA6;
        Fri,  4 Oct 2019 17:18:57 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BB3419C69;
        Fri,  4 Oct 2019 17:18:56 +0000 (UTC)
Subject: Re: [PATCH v2 3/7] intel-speed-select: Add check for CascadeLake-N
 models
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20191003121112.25870-1-prarit@redhat.com>
 <20191003121112.25870-4-prarit@redhat.com>
 <b1895913e2adaff4daf7be6b919e50714b418fe8.camel@linux.intel.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <8c831fa0-bb42-76bf-a624-12b063cf8e8b@redhat.com>
Date:   Fri, 4 Oct 2019 13:18:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b1895913e2adaff4daf7be6b919e50714b418fe8.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Fri, 04 Oct 2019 17:18:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/19 1:15 PM, Srinivas Pandruvada wrote:
> On Thu, 2019-10-03 at 08:11 -0400, Prarit Bhargava wrote:
>> Three CascadeLake-N models (6252N, 6230N, and 5218N) have SST-PBF
>> support.
>>
>> Return an error if the CascadeLake processor is not one of these
>> specific
>> models.
>>
> This patch sigfaults immediately on CLX.>
>> v2: Add is_clx_n_platform()
>>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> ---
>>  .../x86/intel-speed-select/isst-config.c      | 44
>> ++++++++++++++++++-
>>  1 file changed, 42 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/power/x86/intel-speed-select/isst-config.c
>> b/tools/power/x86/intel-speed-select/isst-config.c
>> index f4a23678416e..734a7960458c 100644
>> --- a/tools/power/x86/intel-speed-select/isst-config.c
>> +++ b/tools/power/x86/intel-speed-select/isst-config.c
>> @@ -23,6 +23,7 @@ static int debug_flag;
>>  static FILE *outf;
>>  
>>  static int cpu_model;
>> +static int cpu_stepping;
>>  
>>  #define MAX_CPUS_IN_ONE_REQ 64
>>  static short max_target_cpus;
>> @@ -72,7 +73,16 @@ void debug_printf(const char *format, ...)
>>  	va_end(args);
>>  }
>>  
>> -static void update_cpu_model(void)
>> +
>> +int is_clx_n_platform(void)
>> +{
>> +	if (cpu_model == 0x55)
>> +		if (cpu_stepping == 0x6 || cpu_stepping == 0x7)
>> +			return 1;
>> +	return 0;
>> +}
>> +
>> +static int update_cpu_model(void)
>>  {
>>  	unsigned int ebx, ecx, edx;
>>  	unsigned int fms, family;
>> @@ -82,6 +92,34 @@ static void update_cpu_model(void)
>>  	cpu_model = (fms >> 4) & 0xf;
>>  	if (family == 6 || family == 0xf)
>>  		cpu_model += ((fms >> 16) & 0xf) << 4;
>> +
>> +	cpu_stepping = fms & 0xf;
>> +
>> +	/* only three CascadeLake-N models are supported */
>> +	if (is_clx_n_platform()) {
>> +		FILE *fp;
>> +		size_t n;
>> +		char *line;
> Need n = 0 and *line = NULL here as getline() will require if it has to
> allocate.

Odd, I ran multiple tests and never hit the segfault :(.  Thanks for fixing.

P.

> 
> Anyway I will update the patchset and post after test.
> 

> Thanks,
> Srinivas
>> +		int ret = 1;
>> +
>> +		fp = fopen("/proc/cpuinfo", "r");
>> +		if (!fp)
>> +			err(-1, "cannot open /proc/cpuinfo\n");
>> +
>> +		while (getline(&line, &n, fp) > 0) {
>> +			if (strstr(line, "model name")) {
>> +				if (strstr(line, "6252N") ||
>> +				    strstr(line, "6230N") ||
>> +				    strstr(line, "5218N"))
>> +					ret = 0;
>> +				break;
>> +			}
>> +		}
>> +		free(line);
>> +		fclose(fp);
>> +		return ret;
>> +	}
>> +	return 0;
>>  }
>>  
>>  /* Open a file, and exit on failure */
>> @@ -1889,7 +1927,9 @@ static void cmdline(int argc, char **argv)
>>  		fprintf(stderr, "Feature name and|or command not
>> specified\n");
>>  		exit(0);
>>  	}
>> -	update_cpu_model();
>> +	ret = update_cpu_model();
>> +	if (ret)
>> +		err(-1, "Invalid CPU model (%d)\n", cpu_model);
>>  	printf("Intel(R) Speed Select Technology\n");
>>  	printf("Executing on CPU model:%d[0x%x]\n", cpu_model,
>> cpu_model);
>>  	set_max_cpu_num();
> 
